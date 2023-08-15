-- Movimento Mensal
select * from SPC010
 where D_E_L_E_T_ = ' ' AND PC_MAT = '3026' AND PC_DATA between '20121116' and '20121215'
 order by PC_DATA, PC_PD;
 
select * from SPC010
 where D_E_L_E_T_ = ' ' AND PC_MAT = '3026' AND PC_DATA between '20121216' and '20130115'
 order by PC_DATA, PC_PD;
 
-- Banco de Horas
select * from SPI010
 where D_E_L_E_T_ = ' ' AND PI_MAT = '3026'; 