SELECT D_E_L_E_T_, * FROM SW2010 WHERE W2_PO_NUM = 'POM0395/11';

SELECT B2_SALPEDI, * FROM SB2010 
 WHERE D_E_L_E_T_ = ' ' AND B2_COD in ('155500-5', '155176-3', '155793-3')
 ORDER BY B2_COD;
