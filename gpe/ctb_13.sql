select RZ_PD from SRZ010 WHERE RZ_MAT <> 'zzzzzz' 
 group by RZ_PD;

ORDER BY RZ_CC, RZ_MAT 