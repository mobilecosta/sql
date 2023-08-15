SELECT RC_DATA, RC_PD, SUM(RC_VALOR) AS RC_VALOR FROM SRC010 
 WHERE RC_PD IN ('708','723') AND D_E_L_E_T_ = ' '
 GROUP BY RC_DATA, RC_PD
 ORDER BY RC_DATA, RC_PD;

SELECT RI_DATA, RI_PD, SUM(RI_VALOR) AS RI_VALOR 
  FROM SRI010 
 WHERE RI_PD IN ('708','723') AND D_E_L_E_T_ = ' '
 GROUP BY RI_DATA, RI_PD
 ORDER BY RI_DATA, RI_PD;