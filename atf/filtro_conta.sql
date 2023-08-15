SELECT SN1.N1_NFISCAL, SN1.N1_AQUISIC, SN3.N3_HISTOR, SN3.N3_VORIG1, SN3.* FROM SN3010 SN3 
  JOIN SN1010 SN1 ON SN1.D_E_L_E_T_ = ' ' AND SN1.N1_CBASE = SN3.N3_CBASE AND SN1.N1_CBASE = SN3.N3_CBASE
   AND SN1.N1_ITEM = SN3.N3_ITEM
 WHERE SN3.D_E_L_E_T_ = ' ' AND SN3.N3_CCONTAB = '132106' 
 ORDER BY SN3.N3_CBASE

SELECT N1_VLAQUIS, * FROM SN1010 WHERE D_E_L_E_T_ = ' ' AND N1_CBASE = '0000000786';

SELECT N3_VORIG1, * FROM SN3010 WHERE D_E_L_E_T_ = ' ' AND N3_CBASE = '0000000786';

select * from SN1010 WHERE N1_NFISCAL LIKE '%289393%';

SELECT * FROM SN4010 WHERE D_E_L_E_T_ = ' ' AND N4_CBASE = '0000000786'

SELECT CT2_CREDIT, SUM(CT2_VALOR) AS CT2_VALOR 
  FROM CT2010 WHERE D_E_L_E_T_ = ' ' AND CT2_DATA = '20121231' 
   AND (CT2_CREDIT IN ('132206', '340511') OR CT2_DEBITO IN ('132206', '340511'))
 GROUP BY CT2_CREDIT
   
SELECT N4_CONTA, SUM(N4_VLROC1) FROM SN4010
 WHERE D_E_L_E_T_ = ' ' AND N4_OCORR = '06' AND N4_TIPOCNT = '4' AND N4_DATA = '20121231'
 GROUP BY N4_CONTA
 ORDER BY N4_CONTA;