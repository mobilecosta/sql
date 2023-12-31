-- 05/2012
SELECT SUM(F3_VALICM) FROM SF3010 WHERE D_E_L_E_T_ = ' ' AND F3_ENTRADA BETWEEN '20120401' AND '20120431';

SELECT SUM(FT_VALICM) FROM SFT010 
 WHERE D_E_L_E_T_ = ' ' AND FT_ENTRADA BETWEEN '20120401' AND '20120431'
   AND EXISTS(SELECT 1 FROM SF3010 WHERE D_E_L_E_T_ = ' ' AND F3_NFISCAL = SFT010.FT_NFISCAL  
                 AND F3_SERIE = SFT010.FT_SERIE AND F3_CLIEFOR = SFT010.FT_CLIEFOR 
                 AND F3_LOJA = SFT010.FT_LOJA);

-- 05/2012
SELECT SUM(F3_VALICM) FROM SF3010 WHERE D_E_L_E_T_ = ' ' AND F3_ENTRADA BETWEEN '20120501' AND '20120531'
   AND F3_OBSERV <> 'NF CANCELADA';

SELECT SUM(FT_VALICM) FROM SFT010 
 WHERE D_E_L_E_T_ = ' ' AND FT_ENTRADA BETWEEN '20120501' AND '20120531'
   AND FT_OBSERV <> 'NF CANCELADA';
   AND EXISTS(SELECT 1 FROM SF3010 WHERE D_E_L_E_T_ = ' ' AND F3_NFISCAL = SFT010.FT_NFISCAL  
                 AND F3_SERIE = SFT010.FT_SERIE AND F3_CLIEFOR = SFT010.FT_CLIEFOR 
                 AND F3_LOJA = SFT010.FT_LOJA);
                 
-- Notas Canceladas
SELECT SUM(F3_VALICM) FROM SF3010 WHERE D_E_L_E_T_ = ' ' AND F3_ENTRADA BETWEEN '20120501' AND '20120531'
   AND F3_OBSERV = 'NF CANCELADA';
                 
SELECT SUM(FT_VALICM) FROM SFT010 
 WHERE D_E_L_E_T_ = ' ' AND FT_ENTRADA BETWEEN '20120501' AND '20120531'
   AND FT_OBSERV = 'NF CANCELADA';

-- Troca do N�mero do Livro   
UPDATE SF3010 
   SET F3_NRLIVRO = '1'
 WHERE D_E_L_E_T_ = ' ' AND F3_ENTRADA BETWEEN '20120501' AND '20120531'

UPDATE SFT010 
   SET FT_NRLIVRO = '1'
 WHERE D_E_L_E_T_ = ' ' AND FT_ENTRADA BETWEEN '20120501' AND '20120531'
   
-- Saldo em estoque
SELECT SB1.B1_TIPO, SB2.B2_COD AS CODIGO, SUM(SB2.B2_QATU) AS QUANTIDADE, MIN(SB2.B2_CM1) AS CUSTO 
  FROM SB2010 SB2
  JOIN SB1010 SB1 ON SB1.B1_FILIAL = '01' AND SB1.D_E_L_E_T_ = ' ' AND SB1.B1_COD = SB2.B2_COD
 WHERE SB2.B2_FILIAL = '01' AND SB2.D_E_L_E_T_ = ' ' AND SB2.B2_QATU > 0
 GROUP BY SB1.B1_TIPO, SB2.B2_COD
 ORDER BY SB1.B1_TIPO, SB2.B2_COD;
 
SELECT SB1.B1_TIPO, SUM(SB2.B2_QATU) AS QUANTIDADE, SUM(SB2.B2_CM1 * SB2.B2_QATU) AS CUSTO 
  FROM SB2010 SB2
  JOIN SB1010 SB1 ON SB1.B1_FILIAL = '01' AND SB1.D_E_L_E_T_ = ' ' AND SB1.B1_COD = SB2.B2_COD
 WHERE SB2.B2_FILIAL = '01' AND SB2.D_E_L_E_T_ = ' ' AND SB2.B2_QATU > 0
 GROUP BY SB1.B1_TIPO
 ORDER BY SB1.B1_TIPO; 