SELECT SB1.B1_TIPO,
       SUM(CASE WHEN SB9.B9_QINI = 0 THEN 0.0001 ELSE SB9.B9_QINI END) AS QUANTIDADE, 
       SUM(CAST(SB9.B9_VINI1 / CASE WHEN SB9.B9_QINI = 0 THEN 0.0001 ELSE SB9.B9_QINI END AS NUMERIC(15,6))) AS VALOR_UNIT, 
       SUM(SB9.B9_VINI1) AS TOTAL
  FROM SB9010 SB9 
  JOIN SB1010 SB1 ON SB1.D_E_L_E_T_ = ' ' AND SB1.B1_COD = SB9.B9_COD 
 WHERE SB9.D_E_L_E_T_ = ' ' AND B9_DATA = '20130731' AND SB9.B9_VINI1 <> 0 
 GROUP BY SB1.B1_TIPO;

SELECT SB1.B1_TIPO, SB1.B1_COD, SB9.B9_QINI, SB9.B9_VINI1 AS VALOR, INV.TOTAL
  FROM SB9010 SB9 
  JOIN SB1010 SB1 ON SB1.D_E_L_E_T_ = ' ' AND SB1.B1_COD = SB9.B9_COD 
  LEFT JOIN INVENTARIO INV ON INV.PRODUTO = SB1.B1_COD
 WHERE SB9.D_E_L_E_T_ = ' ' AND B9_DATA = '20121231' AND SB9.B9_VINI1 <> 0 
   AND COALESCE(INV.TOTAL, 0) <> SB9.B9_VINI1
   AND SB1.B1_TIPO = 'MP'
 ORDER BY SB1.B1_COD;

SELECT SUM(VALOR)
  FROM ( 
SELECT SB1.B1_TIPO, SB1.B1_COD, SB9.B9_QINI, SB9.B9_VINI1 AS VALOR
  FROM SB9010 SB9 
  JOIN SB1010 SB1 ON SB1.D_E_L_E_T_ = ' ' AND SB1.B1_COD = SB9.B9_COD 
  LEFT JOIN INVENTARIO INV ON INV.PRODUTO = SB1.B1_COD
 WHERE SB9.D_E_L_E_T_ = ' ' AND B9_DATA = '20121231' AND SB9.B9_VINI1 <> 0 
   AND COALESCE(INV.TOTAL, 0) <> SB9.B9_VINI1
   AND SB1.B1_TIPO = 'ME') QRY

-- Saldo Fechamento
SELECT SB1.B1_TIPO, SUM(ROUND(SB9.B9_QINI * SB9.B9_CM1, 2)) AS TOTAL
  FROM SB9010 SB9
  JOIN SB1010 SB1 ON SB1.D_E_L_E_T_ = ' ' AND SB1.B1_COD = SB9.B9_COD
 WHERE SB9.D_E_L_E_T_ = ' ' AND SB9.B9_DATA = '20130731' 
 GROUP BY SB1.B1_TIPO
 HAVING SUM(SB9.B9_QINI * SB9.B9_CM1) > 0
 ORDER BY SB1.B1_TIPO

-- MATR320 - Resumo das Entradas e Sa�das
SELECT 'SD1' ARQ, SB1.B1_COD PRODUTO, SB1.B1_TIPO, SB1.B1_UM, SB1.B1_GRUPO, SB1.B1_DESC, D1_DTDIGIT DATA, D1_TES TES, D1_CF CF, D1_NUMSEQ SEQUENCIA, D1_DOC DOCUMENTO, D1_SERIE SERIE, D1_QUANT QUANTIDADE, D1_QTSEGUM QUANT2UM, D1_LOCAL ARMAZEM, ' ' OP, D1_FORNECE FORNECEDOR, D1_LOJA LOJA, D1_TIPO TIPONF,    D1_CUSTO CUSTO,  SD1.R_E_C_N_O_ NRECNO
  FROM  SB1010 SB1, SD1010 SD1, SF4010 SF4
 WHERE SB1.B1_COD = SD1.D1_COD AND SD1.D1_FILIAL =  '01'  AND SF4.F4_FILIAL =  '01'  AND SD1.D1_TES = SF4.F4_CODIGO
   AND SF4.F4_ESTOQUE = 'S' AND SD1.D1_DTDIGIT >=  '20130701' AND SD1.D1_DTDIGIT <=  '20130731'
   AND SD1.D1_ORIGLAN <> 'LF' AND SD1.D1_LOCAL >=  '  ' AND SD1.D1_LOCAL <=  'ZZ' AND SD1.D_E_L_E_T_= ' '
   AND SF4.D_E_L_E_T_= ' ' AND SB1.B1_COD >=  '               ' AND SB1.B1_COD <=  'ZZZZZZZZZZZZZZZ'
   AND SB1.B1_FILIAL =  '01'  AND SB1.B1_TIPO >=  '  ' AND SB1.B1_TIPO <=  'ZZ' AND SB1.D_E_L_E_T_= ' '
 UNION
SELECT 'SD2', SB1.B1_COD, SB1.B1_TIPO, SB1.B1_UM, SB1.B1_GRUPO, SB1.B1_DESC,     D2_EMISSAO, D2_TES, D2_CF, D2_NUMSEQ, D2_DOC, D2_SERIE, D2_QUANT, D2_QTSEGUM, D2_LOCAL, ' ', D2_CLIENTE, D2_LOJA, D2_TIPO,    D2_CUSTO1 CUSTO,  SD2.R_E_C_N_O_ SD2RECNO
  FROM  SB1010 SB1, SD2010 SD2, SF4010 SF4
 WHERE SB1.B1_COD = SD2.D2_COD AND SD2.D2_FILIAL =  '01'  AND SF4.F4_FILIAL =  '01'  AND SD2.D2_TES = SF4.F4_CODIGO
   AND SF4.F4_ESTOQUE = 'S' AND SD2.D2_EMISSAO >=  '20130701' AND SD2.D2_EMISSAO <=  '20130731' 
   AND SD2.D2_ORIGLAN <> 'LF' AND SD2.D2_LOCAL >=  '  ' AND SD2.D2_LOCAL <=  'ZZ' AND SD2.D_E_L_E_T_= ' ' 
   AND SF4.D_E_L_E_T_= ' ' AND SB1.B1_COD >=  '               ' AND SB1.B1_COD <=  'ZZZZZZZZZZZZZZZ' 
   AND SB1.B1_FILIAL =  '01'  AND SB1.B1_TIPO >=  '  ' AND SB1.B1_TIPO <=  'ZZ' AND SB1.D_E_L_E_T_= ' '     
 UNION 
SELECT 'SD3', SB1.B1_COD, SB1.B1_TIPO, SB1.B1_UM, SB1.B1_GRUPO, SB1.B1_DESC,     D3_EMISSAO, D3_TM, D3_CF, D3_NUMSEQ, D3_DOC, ' ', D3_QUANT, D3_QTSEGUM, D3_LOCAL, D3_OP, ' ', ' ', ' ',    D3_CUSTO1 CUSTO,  SD3.R_E_C_N_O_ SD3RECNO 
  FROM  SB1010 SB1, SD3010 SD3 
 WHERE SB1.B1_COD = SD3.D3_COD AND SD3.D3_FILIAL =  '01'  AND SD3.D3_EMISSAO >=  '20130701' 
   AND SD3.D3_EMISSAO <=  '20130731' AND SD3.D3_LOCAL >=  '  ' AND SD3.D3_LOCAL <=  'ZZ' AND SD3.D_E_L_E_T_= ' ' 
   AND SB1.B1_COD >=  '               ' AND SB1.B1_COD <=  'ZZZZZZZZZZZZZZZ' AND SB1.B1_FILIAL =  '01'  
   AND SB1.B1_TIPO >=  '  ' AND SB1.B1_TIPO <=  'ZZ' AND SB1.D_E_L_E_T_= ' '    AND D3_ESTORNO <> 'S'  
 UNION 
SELECT 'SB1', SB1.B1_COD, SB1.B1_TIPO, SB1.B1_UM, SB1.B1_GRUPO, SB1.B1_DESC,     ' ', ' ', ' ', ' ', ' ', ' ', 0, 0, ' ', ' ', ' ', ' ', ' ', 0, 0 
  FROM  SB1010 SB1 
 WHERE SB1.B1_COD >=  '               ' AND SB1.B1_COD <=  'ZZZZZZZZZZZZZZZ' AND SB1.B1_FILIAL =  '01'  AND SB1.B1_TIPO >=  '  ' AND SB1.B1_TIPO <=  'ZZ' AND SB1.D_E_L_E_T_= ' ' 
 ORDER BY 3,2,1;