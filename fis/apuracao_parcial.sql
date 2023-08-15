SELECT SUM(F3_VALICM * CASE WHEN LEFT(F3_CFO, 1) < '5' THEN -1 ELSE 1 END) AS VALOR_ICM
  FROM SF3010 
 WHERE F3_ENTRADA BETWEEN '20111201' AND '20111215' AND NOT F3_OBSERV LIKE '%CANC%' 
   AND F3_DTCANC = '' AND D_E_L_E_T_ = ' ';
 
SELECT SUM(F3_VALICM * CASE WHEN LEFT(F3_CFO, 1) < '5' THEN -1 ELSE 1 END) AS VALOR_ICM
  FROM SF3010 
 WHERE F3_ENTRADA BETWEEN '20111201' AND '20111231' AND NOT F3_OBSERV LIKE '%CANC%' AND F3_DTCANC = '' AND D_E_L_E_T_ = ' '; 