select sum(F3_ESTCRED), sum(F3_IPIOBS) from SF3010 where D_E_L_E_T_ = ' ' 
   and F3_ENTRADA between '20120201' AND '20120229';
   
select * from SF3010 where D_E_L_E_T_ = ' ' 
   and F3_ENTRADA between '20120201' AND '20120229';   
   
select * from CDP010 where D_E_L_E_T_ = ' ' AND CDP_DTINI = '20120201' AND CDP_SEQUEN = '007';

select * from CDP010 where D_E_L_E_T_ = ' ' AND CDP_LINHA = '004' AND CDP_VALOR > 0 ORDER BY CDP_DTINI;