-- Relat�rio de Vendas
SELECT SUM(D2_CUSTO1) AS D2_CUSTO1
  FROM SB1010 SB1, SD2010 SD2, SF4010 SF4
 WHERE SD2.D2_FILIAL = '01' AND SF4.F4_FILIAL = '01' AND SB1.B1_FILIAL = '01' AND SB1.B1_COD = SD2.D2_COD
   AND SD2.D2_TES =  SF4.F4_CODIGO AND SF4.F4_ESTOQUE = 'S' AND SF4.F4_PODER3 = 'N' AND SD2.D2_TIPO <> 'D'
   AND SD2.D2_EMISSAO >= '20110101'	AND SD2.D2_EMISSAO <= '20110831' AND SD2.D2_ORIGLAN <> 'LF'
   AND SD2.D_E_L_E_T_ = ' ' AND SF4.D_E_L_E_T_ = ' '  AND SB1.D_E_L_E_T_ = ' ' 

-- Arquivo Ernest - PA
SELECT SUM(D2_CUSTO1) AS D2_CUSTO1
  FROM SB1010 SB1, SD2010 SD2, SF4010 SF4
 WHERE SD2.D2_FILIAL = '01' AND SF4.F4_FILIAL = '01' AND SB1.B1_FILIAL = '01' AND SB1.B1_COD = SD2.D2_COD
   AND SD2.D2_TES =  SF4.F4_CODIGO AND SF4.F4_XTESPAE = '1' AND SD2.D2_TIPO <> 'D'
   AND SD2.D2_EMISSAO >= '20110101'	AND SD2.D2_EMISSAO <= '20110831'
   AND SD2.D_E_L_E_T_ = ' ' AND SF4.D_E_L_E_T_ = ' '  AND SB1.D_E_L_E_T_ = ' ' 

-- Arquivo Ernest - Vendas
SELECT SUM(SD2.D2_CUSTO1) AS D2_CUSTO1
  FROM SB1010 SB1, SD2010 SD2, SF4010 SF4
 WHERE SD2.D2_FILIAL = '01' AND SF4.F4_FILIAL = '01' AND SB1.B1_FILIAL = '01' AND SB1.B1_COD = SD2.D2_COD
   AND SD2.D2_TES =  SF4.F4_CODIGO AND SF4.F4_XTESVDE = '1'
   AND SD2.D2_TIPO <> 'D'
   AND SD2.D2_EMISSAO >= '20110101'	AND SD2.D2_EMISSAO <= '20110831'
   AND SD2.D_E_L_E_T_ = ' ' AND SF4.D_E_L_E_T_ = ' '  AND SB1.D_E_L_E_T_ = ' ';

-- Arquivo Ernest 
SELECT SB1.B1_TIPO, SD2.D2_TES, 
       SUM(CASE WHEN SF4.F4_XTESVDE = '1' THEN D2_CUSTO1 ELSE 0 END) AS D2_CUSTO1_ERN,
       SUM(CASE WHEN SF4.F4_ESTOQUE = 'S' AND SF4.F4_PODER3 = 'N' THEN D2_CUSTO1 ELSE 0 END) AS D2_CUSTO1
  FROM SB1010 SB1, SD2010 SD2, SF4010 SF4
 WHERE SD2.D2_FILIAL = '01' AND SF4.F4_FILIAL = '01' AND SB1.B1_FILIAL = '01' AND SB1.B1_COD = SD2.D2_COD
   AND SD2.D2_TES =  SF4.F4_CODIGO
   AND SD2.D2_TIPO <> 'D'
   AND SD2.D2_EMISSAO >= '20110101'	AND SD2.D2_EMISSAO <= '20110831'
   AND SD2.D_E_L_E_T_ = ' ' AND SF4.D_E_L_E_T_ = ' '  AND SB1.D_E_L_E_T_ = ' '
 GROUP BY SB1.B1_TIPO, SD2.D2_TES
 HAVING SUM(CASE WHEN SF4.F4_XTESVDE = '1' THEN D2_CUSTO1 ELSE 0 END) <> 
        SUM(CASE WHEN SF4.F4_ESTOQUE = 'S' AND SF4.F4_PODER3 = 'N' THEN D2_CUSTO1 ELSE 0 END)
ORDER BY SD2.D2_TES;

-- Arquivo
select SUM(TAB.D2_CUSTO1) as D2_CUSTO1
from (
SELECT SB1.B1_TIPO, CASE WHEN SB1.B1_TIPO = 'PA' THEN D2.D2_CUSTO1 / 22187971.90  ELSE 0.00 END AS D2_PER_CUS, 
       D2.D2_CUSTO1, D2.R_E_C_N_O_ 
  FROM SD2010 D2 
  JOIN SF4010 F4 ON F4_FILIAL = '01' AND F4.F4_CODIGO = D2.D2_TES AND F4.F4_XTESPAE = '1' 
   AND F4.D_E_L_E_T_ ='' 
  LEFT JOIN SB1010 SB1 ON B1_FILIAL = '01' AND SB1.B1_COD = D2.D2_COD AND SB1.D_E_L_E_T_ ='' 
 WHERE D2.D2_FILIAL = '01' AND D2.D2_EMISSAO >= '20110101' AND D2_EMISSAO <='20110831' 
   AND D2.D2_CUSTO1 > 0 AND D2.D2_TIPO <> 'D' AND D2.D_E_L_E_T_=''
) as TAB
