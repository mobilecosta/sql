-- FGTS TOTAL
select SUM(RT_VALOR) from SRT010 
 where D_E_L_E_T_ = ' ' AND RT_DATACAL = '20120930' AND RT_TIPPROV = '3' AND RT_VERBA = '737';

-- FGTS por Centro de Custos
select RT_CC, SUM(RT_VALOR) from SRT010 
 where D_E_L_E_T_ = ' ' AND RT_DATACAL = '20120930' AND RT_TIPPROV = '3' AND RT_VERBA = '737'
 group by RT_CC
 order by RT_CC