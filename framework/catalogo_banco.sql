select obj.name as objeto, typ.name as tipo, sys.* 
  from sys.all_columns sys 
  join sys.systypes typ on typ.xtype = sys.system_type_id 
  left join sys.objects obj on obj.object_id = sys.default_object_id
 where sys.name = 'A4_EMAIL';
 
SELECT * FROM TOP_FIELD   WHERE FIELD_NAME = 'A2_EMAIL';

SELECT * from dba_indexes WHERE INDEX_NAME LIKE '%SUS000%' ORDER BY INDEX_NAME

DROP INDEX SUS000_T02; 