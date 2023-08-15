0) Conectar no SQL_Plus
set oracle_sid=lab
sqlplus /nolog
connect sys/sys@lab as sysdba

1) Drop do Usuário
DROP USER protheus CASCADE;

2) Recriar o usuário
CREATE USER PROTHEUS IDENTIFIED BY PROTHEUS DEFAULT TABLESPACE DADOSADV QUOTA UNLIMITED ON DADOSADV;
GRANT create session, alter session, select_catalog_role, execute_catalog_role, create table, create procedure, create view, create materialized view, create trigger, create sequence, create any directory, create type, create synonym, administer database trigger TO PROTHEUS;

GRANT DBA TO PROTHEUS WITH ADMIN OPTION;

3) Alterar Top Field
UPDATE top_Field set field_table = replace(field_table, 'PROTHEUS10PRD.', 'PROTHEUS.');
