select * from SF7010 where F7_GRTRIB = '999';

insert into SF7010(F7_FILIAL, F7_GRTRIB, F7_SEQUEN, F7_EST, F7_TIPOCLI, F7_ALIQEXT, F7_ISS, 
                   F7_ICMPAUT, F7_UFBUSCA, R_E_C_N_O_)
select '01' as F7_FILIAL, '999' AS F7_GRPTRIB, 
       dbo.strzero(ROW_NUMBER() OVER(ORDER BY R_E_C_N_O_) + 1, 2) F7_SEQUEN, 
       X5_CHAVE AS F7_EST, '*' AS F7_TIPOCLI, 4 AS F7_ALIQEXT, 'N' AS F7_ISS, '1' AS F7_ICMPAUT,
       '1' AS F7_UFBUSCA, ROW_NUMBER() OVER(ORDER BY R_E_C_N_O_) + 4 AS R_E_C_N_O_
  from SX5010 
 where D_E_L_E_T_ = ' ' AND X5_TABELA = '12' and not X5_CHAVE in ('SP', 'MG')
 order by X5_CHAVE;
 
select * from SA1010 where D_E_L_E_T_ = ' ' AND A1_GRPTRIB <> '';
select A2_GRPTRIB, * from SA2010 where D_E_L_E_T_ = ' ' AND A2_GRPTRIB <> '';
select * from SB1010 where D_E_L_E_T_ = ' ' AND B1_GRTRIB <> '';