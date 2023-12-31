-- Acumulados
SELECT RD_PD, SUM(RD_VALOR) AS RHH_VALOR FROM SRD010 
 WHERE D_E_L_E_T_ = ' ' AND RD_PD IN ('532', '943', '944', '945')
 GROUP BY RD_PD
 ORDER BY RD_PD;
 
-- Calculo do Dissidio
SELECT RHH_VERBA, SUM(RHH_VALOR) AS RHH_VALOR FROM RHH010 
 WHERE D_E_L_E_T_ = ' ' AND RHH_VERBA IN ('532', '943', '944', '945')
 GROUP BY RHH_VERBA
 ORDER BY RHH_VERBA
 
-- Folha de Pagamento
SELECT RC_PD, SUM(RC_VALOR) AS RC_VALOR FROM SRC010 
 WHERE D_E_L_E_T_ = ' ' AND RC_PD IN ('532', '943', '944', '945')
 GROUP BY RC_PD
 ORDER BY RC_PD;
 
SELECT * FROM RHH010 
 WHERE D_E_L_E_T_ = ' ' AND RHH_VERBA IN ('532', '943', '944', '945');
 
 
