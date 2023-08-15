-- MSSQL
SELECT 'SELECT ''' + name + ''' as tabela, COUNT(*) as contador FROM ' + name as stmt, name, 1 as tipo  FROM sys.tables
 where (name like '%700' or name like 'TAF%' or name like 'SPED%' or (name like 'RC%' and len(name) = 8)) and left(name, 2) <> 'xx'
 union all
SELECT 'union all' as stmt, name, 2 as tipo FROM sys.tables
 where (name like '%700' or name like 'TAF%' or name like 'SPED%' or (name like 'RC%' and len(name) = 8)) and left(name, 2) <> 'xx'
order by name, tipo

SELECT 'SELECT ''' + table_name + ''' as tabela, COUNT(*) as contador FROM ' + table_name as stmt, table_name, 1 as tipo  FROM information_schema.tables
 where (table_name like '%EA0') and left(table_name, 2) <> 'xx'
 union all
SELECT 'union all' as stmt, table_name, 2 as tipo FROM information_schema.tables
 where (table_name like '%EA0') and left(table_name, 2) <> 'xx'
order by table_name, tipo

-- PostgreSQL
SELECT 'SELECT ''' || tablename || ''' as tabela, COUNT(*) as contador FROM ' || tablename as stmt, tablename, 1 as tipo  FROM pg_tables
 where (tablename like '%990' or tablename like 'TAF%' or tablename like 'SPED%' or (tablename like 'RC%' and length(tablename) = 8)) and left(tablename, 2) <> 'xx'
 union all
SELECT 'union all' as stmt, tablename, 2 as tipo FROM pg_tables
 where (tablename like '%990' or tablename like 'TAF%' or tablename like 'SPED%' or (tablename like 'RC%' and length(tablename) = 8)) and left(tablename, 2) <> 'xx'
order by tablename, tipo

select * into TBLCPY from
(
) as tab
where contador > 0
order by contador desc

-- limpar temporarios do banco
SELECT 'DROP TABLE ' + name + ';' as stmt, name, 1 as tipo  FROM sys.tables
 where name like 'SC%' and LEN(name) = 8
 
SELECT 'DROP TABLE ' + name + ';' as stmt, name, 1 as tipo  FROM sys.tables
 where name like '%FISA%' and LEN(name) = 8 