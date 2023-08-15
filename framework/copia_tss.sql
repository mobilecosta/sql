select 'INSERT INTO ' + obj.name + ' SELECT * FROM TSS03.dbo.' + obj.name + ' WHERE ID_ENT IN ("000059","000061");'
  from sys.all_columns sys 
  join sys.systypes typ on typ.xtype = sys.system_type_id 
  join sys.tables obj on obj.object_id = sys.object_id and obj.name like '%SPED%'
 where sys.name like '%ID_ENT%' 
 order by obj.name;

select 'TRUNCATE TABLE ' + obj.name + ';'
  from sys.all_columns sys 
  join sys.systypes typ on typ.xtype = sys.system_type_id 
  join sys.tables obj on obj.object_id = sys.object_id and obj.name like '%SPED%'
 where sys.name like '%ID_ENT%'
 order by obj.name;

select obj.name as tabela, 'SELECT COUNT(*), ''' + obj.name + ''' as tabela FROM ' + obj.name + ' WHERE ID_ENT IN ("000059","000061")', 1 as tipo
  from sys.all_columns sys 
  join sys.systypes typ on typ.xtype = sys.system_type_id 
  join sys.tables obj on obj.object_id = sys.object_id and obj.name like '%SPED%' AND obj.name > 'SPED050'
 where sys.name like '%ID_ENT%'
 union
select obj.name as tabela, 'UNION ALL ', 2 as tipo
  from sys.all_columns sys 
  join sys.systypes typ on typ.xtype = sys.system_type_id 
  join sys.tables obj on obj.object_id = sys.object_id and obj.name like '%SPED%' AND obj.name > 'SPED050'
 where sys.name like '%ID_ENT%'
order by tabela, tipo;

SELECT 'DROP TABLE ' || TABLE_NAME AS COMANDO
  FROM ALL_TABLES
 WHERE TABLE_NAME like '%SPED%'

