-- Seleciona os produtos do grupo de robos que não estão como importado
select B1_IMPORT, * from SB1010 where D_E_L_E_T_ = ' ' and B1_GRUPO = 'R001' AND B1_IMPORT IN ('N', ' ');

-- Atualiza como importado os registros do grupo de robos que não estão como importado
UPDATE SB1010 set B1_IMPORT = 'S'
 where D_E_L_E_T_ = ' ' and B1_GRUPO = 'R001' AND B1_IMPORT IN ('N', ' ');

-- Selecionado todos os registros de Partes e Peças que iniciem com códigos 1 ou 4 e no final tenham -*  
select * from SB1010 
 where D_E_L_E_T_ = ' ' and B1_GRUPO = 'R003' AND LEFT(B1_COD, 1) IN ('1', '4') AND B1_COD LIKE '%-[0-9]' 
   AND B1_IMPORT IN ('N', ' ')
 order by B1_COD;
 
-- Atualiza os registros
update SB1010 set B1_IMPORT = 'S'
 where D_E_L_E_T_ = ' ' and B1_GRUPO = 'R003' AND LEFT(B1_COD, 1) IN ('1', '4') AND B1_COD LIKE '%-[0-9]' 
   AND B1_IMPORT IN ('N', ' '); 