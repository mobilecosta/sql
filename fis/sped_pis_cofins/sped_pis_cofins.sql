-- Registro M100
select FT_CODBCC, *
  from SFT010
 where FT_FILIAL = '01' AND D_E_L_E_T_ = ' ' AND FT_ENTRADA BETWEEN '20110901' AND '20110931';

update SFT010 set FT_CODBCC = '01'
 where FT_FILIAL = '01' AND D_E_L_E_T_ = ' '; 

--
select F4_CODBCC, *
  from SF4010
 where F4_FILIAL = '01' AND D_E_L_E_T_ = ' ';
 
update SF4010 set F4_CODBCC = '01'
 where F4_FILIAL = '01' AND D_E_L_E_T_ = ' '; 
 
-- invalid field name in Alias SF4->F4_TNATREC on REGM800(SPEDPISCOF.PRW)
-- invalid field name in Alias SF4->F4_CNATREC on REGM800(SPEDPISCOF.PRW) 13/01/2012 18:01:18 line : 10696
-- invalid field name in Alias SF4->F4_GRPNATR on REGM800(SPEDPISCOF.PRW) 13/01/2012 18:01:18 line : 10696
alter table SF4010 add F4_TNATREC VARCHAR(1);
alter table SF4010 add F4_CNATREC VARCHAR(1);
alter table SF4010 add F4_GRPNATR VARCHAR(1);
alter table SF4010 add F4_DTFIMNT VARCHAR(8);

insert into TOP_FIELD(FIELD_TABLE, FIELD_NAME, FIELD_TYPE, FIELD_PREC)
values('dbo.SF4010', 'F4_DTFIMNT', 'D', 8);

-- Retirada
alter table SF4010 drop column F4_TNATREC;
alter table SF4010 drop column F4_CNATREC;
alter table SF4010 drop column F4_GRPNATR;
alter table SF4010 drop column F4_DTFIMNT;
delete from TOP_FIELD where FIELD_TABLE = 'dbo.SF4010' and FIELD_NAME = 'F4_DTFIMNT';