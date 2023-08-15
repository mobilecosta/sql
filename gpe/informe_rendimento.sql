select R4_TIPOREN, SUM(R4_VALOR) as R4_VALOR
  from SR4010 where R4_MAT = '3053' AND R4_ANO = '2011' AND D_E_L_E_T_ = ' '
 group by R4_TIPOREN
 order by R4_TIPOREN;
 
select R4_VALOR, R4_MES, *
  from SR4010 
 where R4_MAT = '3053' AND R4_ANO = '2011' AND D_E_L_E_T_ = ' ' and R4_TIPOREN = 'A'
 ORDER BY R4_MES; 
 
select SUM(R4_VALOR)
  from SR4010 
 where R4_MAT = '3053' AND R4_ANO = '2011' AND D_E_L_E_T_ = ' ' and R4_TIPOREN = 'A';  