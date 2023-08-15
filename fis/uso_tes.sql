SELECT F4_CODIGO, F4_CF, F4_TEXTO, CASE WHEN F4_MSBLQL = '1' THEN 'SIM' ELSE 'NAO' END AS BLOQUEADO, 
       CASE WHEN MOV.TES IS NULL THEN 'SEM USO' ELSE 'EM USO' END AS STATUS
  FROM SF4700
  LEFT JOIN (
SELECT D1_TES AS TES FROM SD1700
 WHERE D1_FILIAL = '01' AND D1_EMISSAO BETWEEN '20170101' AND '20191231' AND D_E_L_E_T_ = ' '
 GROUP BY D1_TES
 UNION 
SELECT D2_TES FROM SD2700
 WHERE D2_FILIAL = '01' AND D2_EMISSAO BETWEEN '20170101' AND '20191231' AND D_E_L_E_T_ = ' '
 GROUP BY D2_TES) MOV ON MOV.TES = F4_CODIGO
 WHERE F4_FILIAL = ' ' AND D_E_L_E_T_ = ' '
 ORDER BY CASE WHEN MOV.TES IS NULL THEN '2' ELSE '1' END,
          CASE WHEN F4_MSBLQL = '1' THEN '1' ELSE ' ' END, F4_CODIGO
