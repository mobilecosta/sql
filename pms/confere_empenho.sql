SELECT SUM(ZZX_QTDE)
  FROM 
(  
SELECT ZZX_FILIAL,ZZX_PRODUT,ZZX_COD,SUM(ZZX_QTDE) ZZX_QTDE
  FROM ZZX010 ZZX
 WHERE D_E_L_E_T_=' ' AND ZZX_FILIAL = '  ' AND ZZX_PROJET = 'PMS002312A'
 GROUP BY ZZX_FILIAL,ZZX_PRODUT,ZZX_COD
-- ORDER BY ZZX_FILIAL,ZZX_PRODUT,ZZX_COD
) TAB

SELECT SUM(AFA_XQENTE)
  FROM
(  
select AFA_XQENTE from AFA010 WHERE D_E_L_E_T_ = ' ' AND AFA_PROJET = 'PMS002312A'
   AND AFA_XQENTE > 0
) TAB

SELECT * FROM AFC010 WHERE D_E_L_E_T_ = ' ' AND AFC_PROJET = 'PMS002312A';

SELECT * FROM SD1010 WHERE D_E_L_E_T_ = ' ' AND LEFT(D1_CF, 1) = '3';