IF OBJECT_ID('ct_acerta_estoque') > 0
    DROP procedure ct_acerta_estoque
GO
create procedure [dbo].[ct_acerta_estoque](@in_filial varchar(2), @in_data varchar(8), @in_usuario varchar(10)) AS
Declare
   @b2_cod     varchar(15),
   @b2_local   varchar(2),
   @b1_tipo    varchar(2),
   @b1_grupo   varchar(6),
   @b1_um      varchar(2),
   @d3_numseq  varchar(6),
   @d3_doc     varchar(10),
   @in_recnod3 integer,
   @in_recnodq integer
begin
   set nocount on

   INSERT INTO SB7220(B7_FILIAL, B7_COD, B7_LOCAL, B7_TIPO, B7_DOC, B7_QUANT, B7_DATA, B7_STATUS, R_E_C_N_O_) 
   SELECT B7_FILIAL, B7_COD, B7_LOCAL, B7_TIPO, @in_data AS B7_DOC, B7_QUANT, @in_data AS B7_DATA, 
          '1' AS B7_STATUS, 
	      ROW_NUMBER() OVER(ORDER BY B7_COD) + (SELECT MAX(R_E_C_N_O_) FROM SB7220) AS R_E_C_N_O_ 
     FROM (SELECT B2_FILIAL AS B7_FILIAL, B2_COD AS B7_COD, B2_LOCAL AS B7_LOCAL, B1_TIPO AS B7_TIPO, DQ_XQTD AS B7_QUANT 
             FROM SB2220 SB2 
		     JOIN SB1220 SB1 ON B1_FILIAL = B2_FILIAL AND B1_COD = B2_COD AND SB1.D_E_L_E_T_ = ' ' 
		     JOIN SDQ220 SDQ ON DQ_FILIAL = B2_FILIAL AND DQ_COD = B2_COD AND B2_LOCAL = DQ_LOCAL 
		      AND DQ_DATA = @in_data AND SDQ.D_E_L_E_T_ = ' ' 
		     LEFT JOIN SB7220 SB7 ON B7_FILIAL = B2_FILIAL AND B7_COD = B2_COD AND B7_LOCAL = DQ_LOCAL 
		      AND B7_DATA = @in_data AND SB7.B7_STATUS = '1' AND SB7.D_E_L_E_T_ = ' ' 
		    WHERE B2_FILIAL = @in_filial AND ROUND(B2_VFIM1,2) <> ROUND(DQ_XQTD * DQ_CM1, 2) AND SB2.D_E_L_E_T_ = ' ' 
		      AND B7_DOC IS NULL 
		    UNION 
		   SELECT B2_FILIAL AS B7_FILIAL, B2_COD AS B7_COD, B2_LOCAL AS B7_LOCAL, B1_TIPO AS B7_TIPO, 0 AS B7_QUANT 
		     FROM SB2220 SB2 
		     JOIN SB1220 SB1 ON B1_FILIAL = B2_FILIAL AND B1_COD = B2_COD AND SB1.D_E_L_E_T_ = ' ' 
		     LEFT JOIN SDQ220 SDQ ON DQ_FILIAL = B2_FILIAL AND DQ_COD = B2_COD AND B2_LOCAL = DQ_LOCAL 
		      AND DQ_DATA = @in_data AND SDQ.D_E_L_E_T_ = ' ' 
		     LEFT JOIN SB7220 SB7 ON B7_FILIAL = B2_FILIAL AND B7_COD = B2_COD AND B7_LOCAL = DQ_LOCAL 
		      AND B7_DATA = @in_data AND SB7.B7_STATUS = '1' AND SB7.D_E_L_E_T_ = ' ' 
		    WHERE B2_FILIAL = @in_filial AND DQ_FILIAL IS NULL AND SB2.D_E_L_E_T_ = ' ' 
		      AND B2_QFIM < 0 AND B7_DOC IS NULL ) AS TAB 
      ORDER BY B7_COD,B7_LOCAL

   Select @d3_doc = MAX(D3_DOC) FROM SD3220 WHERE D_E_L_E_T_ = ' '
   If @d3_doc is null
      Set @d3_doc = 'INV0000001'
   
   Select @d3_numseq = MAX(D3_NUMSEQ) FROM SD3220 WHERE D_E_L_E_T_ = ' '
   If @d3_numseq is null
      Set @d3_numseq = '000000'
   
   select @in_recnod3 = MAX(R_E_C_N_O_) FROM SD3220
   If @in_recnod3 is null
      Set @in_recnod3 = 0
   
   select @in_recnodq = MAX(R_E_C_N_O_) FROM SDQ220
   If @in_recnodq is null
      Set @in_recnodq = 0
   
   Declare xCursor Cursor LOCAL For
    SELECT B2_COD, B2_LOCAL, B1_TIPO, B1_GRUPO, B1_UM
      FROM SB2220 SB2
	  JOIN SB1220 SB1 ON B1_FILIAL = B2_FILIAL AND B1_COD = B2_COD AND SB1.D_E_L_E_T_ = ' '
	  LEFT JOIN SDQ220 SDQ ON DQ_FILIAL = @in_filial AND DQ_DATA = @in_data AND DQ_COD = B2_COD AND DQ_LOCAL = B2_LOCAL
	   AND SDQ.D_E_L_E_T_ = ' '
     WHERE B2_FILIAL = @in_filial AND B2_VFIM1 <> 0 AND B2_QFIM <= 0 AND SB2.D_E_L_E_T_ = ' ' AND DQ_FILIAL IS NULL

   Open xCursor

   Fetch xCursor Into @b2_cod, @b2_local, @b1_tipo, @b1_grupo, @b1_um

   While @@Fetch_Status = 0
   Begin
      Exec MSSOMA1 @d3_doc, '0', @d3_doc OutPut

      Exec MSSOMA1 @d3_numseq, '0', @d3_numseq OutPut
	  
      Set @in_recnodq = @in_recnodq + 1
	  
	  INSERT INTO SDQ220(DQ_FILIAL, DQ_COD, DQ_LOCAL, DQ_DATA, DQ_NUMSEQ, R_E_C_N_O_)
	  VALUES(@in_filial, @b2_cod, @b2_local, @in_data, @d3_numseq, @in_recnodq)

      Set @in_recnod3 = @in_recnod3 + 1
	  
	  INSERT INTO SD3220(D3_FILIAL, D3_COD, D3_LOCAL, D3_EMISSAO, D3_NUMSEQ, D3_DOC, D3_TIPO, D3_GRUPO, D3_UM, D3_TM, D3_CF, 
	                     D3_MOEDA, D3_USUARIO, R_E_C_N_O_)
	  VALUES(@in_filial, @b2_cod, @b2_local, @in_data, @d3_numseq, @d3_doc, @b1_tipo, @b1_grupo, @b1_um, '999', 'REA', 1, 
	         @in_usuario, @in_recnod3)

      Fetch xCursor Into @b2_cod, @b2_local, @b1_tipo, @b1_grupo, @b1_um
   End

   Close xCursor
   Deallocate xCursor

end
GO