-- Funcionários transferidos
SELECT SRA.RA_NOME, SRA.RA_CC, SRE.* FROM SRE010 SRE
  JOIN SRA010 SRA ON SRA.D_E_L_E_T_ = ' ' AND SRA.RA_MAT = SRE.RE_MATD
 WHERE SRE.D_E_L_E_T_ = '  ' AND SRE.RE_DATA >= '20130601' and SRE.RE_CCD = '301'
 ORDER BY SRE.RE_MATD;

delete from SRZ010;

SELECT * FROM SRZ010 
 WHERE D_E_L_E_T_ = ' '  
  AND RZ_TIPO <> 'FL'

-- 01/2013
select SRZ.RZ_CC, SRZ.RZ_MAT, SRA.RA_NOME, SRZ.RZ_PD, SRZ.RZ_VAL, SRZ.RZ_TIPO 
  FROM SRZ010 SRZ
  JOIN SRA010 SRA ON SRA.D_E_L_E_T_ = ' ' AND SRA.RA_MAT = SRZ.RZ_MAT
 where SRZ.D_E_L_E_T_ = ' '
   AND SRZ.RZ_FILIAL <> 'zz' and SRZ.RZ_CC <> 'zzzzzzzzz' AND SRZ.RZ_MAT <> 'zzzzzz'
 order by SRZ.RZ_MAT, SRZ.RZ_PD
 
 select SUM(CASE WHEN CTK_DEBITO <> '' THEN CTK_VLR01 ELSE 0 END) AS DEBITO,
        SUM(CASE WHEN CTK_CREDITO <> '' THEN CTK_VLR01 ELSE 0 END) AS CREDITO
   FROM
(           
 select CASE WHEN CTK_DC IN ('1', '3') THEN CTK_DEBITO ELSE '' END AS CTK_DEBITO,
        CASE WHEN CTK_DC IN ('2', '3') THEN CTK_CREDIT ELSE '' END AS CTK_CREDITO,
        CTK_CCD, CTK_CCC, SUM(CTK_VLR01) AS CTK_VLR01, CTK_HIST
   FROM CTK010 
  WHERE D_E_L_E_T_ = ' ' AND CTK_DATA = '20130131' 
    AND CTK_SEQUEN = '0000039821'
 GROUP BY CASE WHEN CTK_DC IN ('1', '3') THEN CTK_DEBITO ELSE '' END,
          CASE WHEN CTK_DC IN ('2', '3') THEN CTK_CREDIT ELSE '' END,
          CTK_CCD, CTK_CCC, CTK_HIST
    ORDER BY CASE WHEN CTK_DC IN ('1', '3') THEN CTK_DEBITO ELSE '' END,
              CASE WHEN CTK_DC IN ('2', '3') THEN CTK_CREDIT ELSE '' END,
              CTK_CCD, CTK_CCC, CTK_HIST
) QRY;


select MAX(CTK_SEQUEN) FROM CTK010;

 SELECT CTK_DEBITO, CTK_CREDIT, CTK_CCC, CTK_CCD, CTK_VLR01, CTK_HAGLUT
   FROM CTK010
  WHERE D_E_L_E_T_ = ' ' AND CTK_DATA = '20130531' 
    AND CTK_SEQUEN = '0000039826';