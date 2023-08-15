SELECT TAB.B1_COD, TAB.B1_LOCAL, SUM(TAB.QUANT) AS QUANT, MIN(SB2.B2_QFIM) AS B2_QFIM
FROM (
SELECT 1 AS TIPO, SD1.D1_COD AS B1_COD, SD1.D1_LOCAL AS B1_LOCAL, SD1.D1_DTDIGIT AS DATA,
       SD1.D1_NUMSEQ AS SEQUENCIA, SD1.D1_LOTECTL AS LOTE, SD1.D1_QUANT AS QUANT, SD1.D1_CUSTO AS CUSTO,
       SD1.D1_DOC AS DOC, SD1.D1_SERIE AS SERIE, SD1.D1_FORNECE AS CODIGO, SD1.D1_LOJA AS LOJA,
       'SD1' as Origem, SD1.R_E_C_N_O_ AS RECNO
  FROM SD1010 SD1
  JOIN SB1010 SB1 ON SB1.D_E_L_E_T_ = ' ' AND SB1.B1_FILIAL = '00' AND SB1.B1_COD = SD1.D1_COD
  JOIN SF4010 SF4 ON SF4.D_E_L_E_T_ = ' ' AND SF4.F4_FILIAL = '00' AND SF4.F4_CODIGO = SD1.D1_TES
   AND SF4.F4_ESTOQUE =  'S'
 WHERE SD1.D_E_L_E_T_ = ' ' AND SD1.D1_FILIAL = '00' AND SD1.D1_ORIGLAN <> 'LF' 
UNION
SELECT 1 AS TIPO, SD2.D2_COD AS B1_COD, SD2.D2_LOCAL AS B1_LOCAL, SD2.D2_EMISSAO AS DATA,
       SD2.D2_NUMSEQ AS SEQUENCIA, SD2.D2_LOTECTL AS LOTE, SD2.D2_QUANT * -1 AS QUANT, SD2.D2_CUSTO1 AS CUSTO, 
       SD2.D2_DOC AS DOC, SD2.D2_SERIE AS SERIE, SD2.D2_CLIENTE AS CODIGO, SD2.D2_LOJA AS LOJA,
       'SD2' as Origem, SD2.R_E_C_N_O_ AS RECNO
  FROM SD2010 SD2
  JOIN SB1010 SB1 ON SB1.D_E_L_E_T_ = ' ' AND SB1.B1_FILIAL = '00' AND SB1.B1_COD = SD2.D2_COD
  JOIN SF4010 SF4 ON SF4.D_E_L_E_T_ = ' ' AND SF4.F4_FILIAL = '00' AND SF4.F4_CODIGO = SD2.D2_TES
   AND SF4.F4_ESTOQUE =  'S'
 WHERE SD2.D_E_L_E_T_ = ' ' AND SD2.D2_FILIAL = '00' AND SD2.D2_ORIGLAN <> 'LF'
UNION
SELECT 1 AS TIPO, D3_COD AS B1_COD, D3_LOCAL AS B1_LOCAL, D3_EMISSAO AS DATA, D3_NUMSEQ AS SEQUENCIA, D3_LOTECTL AS LOTE,
       D3_QUANT * CASE WHEN D3_TM < '500' THEN 1 ELSE -1 END AS D3_QUANT, D3_CUSTO1 AS CUSTO,
       D3_DOC AS DOC, '' AS SERIE, '' AS CODIGO, '' AS LOJA,
       'SD3' as Origem, R_E_C_N_O_ AS RECNO
  FROM SD3010
 WHERE D_E_L_E_T_ = ' ' AND D3_FILIAL = '00'
   AND D3_ESTORNO <> 'S' 
) TAB
LEFT JOIN SB2010 SB2 ON SB2.D_E_L_E_T_ = ' ' AND SB2.B2_FILIAL = '00' AND SB2.B2_COD = TAB.B1_COD AND SB2.B2_LOCAL = TAB.B1_LOCAL
WHERE COALESCE(SB2.B2_QATU, 0) <> COALESCE(TAB.QUANT, 0) and TAB.B1_LOCAL IN ('01', '02')
GROUP BY TAB.B1_COD, TAB.B1_LOCAL
ORDER BY TAB.B1_COD, TAB.B1_LOCAL