-- 1) M810 - Classificação dos produtos
update SB1010 
   set B1_TNATREC = '4313', B1_CNATREC = '999'
 where D_E_L_E_T_ = ' ';

update SB1010 
   set B1_TNATREC = '    ', B1_CNATREC = '   '
 where D_E_L_E_T_ = ' ';
 
-- 2) M505 - N1_CBASE = 0000000533 e N1_ITEM = 0002
select N1_ORIGCRD, N1_CSTPIS, N1_CSTCOFI, * from SN1010
 where D_E_L_E_T_ = ' ' and N1_CSTPIS = '52'; 
 
update SN1010
   set N1_ORIGCRD = '0', N1_CSTPIS = '50', N1_CSTCOFI = '50'
 where D_E_L_E_T_ = ' ' and N1_CSTPIS = '52';