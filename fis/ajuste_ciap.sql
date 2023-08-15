--
select * from SFA010 where FA_DATA = '20120229' and D_E_L_E_T_ = ' ' order by FA_CODIGO;
select * from SFA010 where FA_DATA = '20120331' and D_E_L_E_T_ = ' ' order by FA_CODIGO;

-- Deleta o calculo do mês 03/2011
update SFA010 SET D_E_L_E_T_ = '*' where FA_DATA = '20120331';

update SF9010 set D_E_L_E_T_ = '*' where F9_CODIGO = '000699';

select * from SF9010 where F9_CODIGO = '000699';