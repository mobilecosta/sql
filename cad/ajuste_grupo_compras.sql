select * from SBM010 order by BM_GRUPO;
 
update SB1010 
   set B1_GRUPO = 'R003' 
 where D_E_L_E_T_ = ' ' and (B1_DESC LIKE '%ROBO%') and B1_GRUPO <> 'R003'; 
 
select B1_GRUPO, * from SB1010 
 where D_E_L_E_T_ = ' ' and not B1_DESC LIKE '%ROBO%' and B1_GRUPO <> 'R003';  
 
select B1_GRUPO, * from SB1010 
 where D_E_L_E_T_ = ' ' and left(B1_COD, 3) = 'RYB' and B1_GRUPO <> 'R003';   

-- Marca todos como PARTES E PECAS ROBOS
update SB1010 
   set B1_GRUPO = 'R003' 
 where D_E_L_E_T_ = ' '; 
 
-- Pela descrição ou código marca o que é robo
update SB1010 set B1_GRUPO = 'R001' 
 where D_E_L_E_T_ = ' ' and (LEFT(B1_DESC, 4) = 'ROBO' or LEFT(B1_COD, 3) = 'RYB');
 
select * from SB1010
 where D_E_L_E_T_ = ' ' and (LEFT(B1_DESC, 4) = 'ROBO' or LEFT(B1_COD, 3) = 'RYB');
  