1) MANUTEN��O TABLE SPACE

CREATE UNDO TABLESPACE UNDOTBS2
DATAFILE 'D:\ORACLE\ORADATA\P10DES\UNDOTBS02.DBF' 
SIZE 32M AUTOEXTEND ON NEXT 32M MAXSIZE 24576M EXTENT MANAGEMENT LOCAL;

ALTER SYSTEM SET UNDO_TABLESPACE='UNDOTBS2' SCOPE=BOTH;

DROP TABLESPACE UNDOTBS1 INCLUDING CONTENTS AND DATAFILES;

CREATE TEMPORARY TABLESPACE TEMP2
TEMPFILE 'E:\ORACLE\ORADATA\PRODUCAO\temp2.dbf' SIZE 10000M REUSE
AUTOEXTEND ON NEXT 1000M MAXSIZE 10000M
EXTENT MANAGEMENT LOCAL UNIFORM SIZE 10M;

ALTER DATABASE DEFAULT TEMPORARY TABLESPACE temp2;

DROP TABLESPACE temp INCLUDING CONTENTS AND DATAFILES;

2) Script Table Space

 select 'create tablespace ' || df.tablespace_name || chr(10)
 || ' datafile ''' || df.file_name || ''' size ' || df.bytes 
 || decode(autoextensible,'N',null, chr(10) || ' autoextend on maxsize ' 
 || maxbytes) 
 || chr(10) 
 || 'default storage ( initial ' || initial_extent 
 || decode (next_extent, null, null, ' next ' || next_extent )
 || ' minextents ' || min_extents
 || ' maxextents ' ||  decode(max_extents,'2147483645','unlimited',max_extents) 
 || ') ;'
 from dba_data_files df, dba_tablespaces t
 where df.tablespace_name=t.tablespace_name 

3) Espa�o utilizado por cada table space

SET LINESIZE 200
SET PAGES 150
COL TABLESPACE_NAME FORMAT A15
SELECT  A.TABLESPACE_NAME,
        round(A.TAMANHO_MAXIMO,2) TAMANHO_MAXIMO,
        round(A.TAMANHO_ATUAL,2) TAMANHO_ATUAL,
        A.AUTOEXTENSIBLE,
        round(B.USADO,2) USADO,
        round(CASE WHEN A.TAMANHO_MAXIMO<a.TAMANHO_ATUAL THEN A.TAMANHO_ATUAL-B.USADO
ELSE A.TAMANHO_MAXIMO-B.USADO END,2) LIVRE,
        round(CASE WHEN A.TAMANHO_MAXIMO<a.TAMANHO_ATUAL THEN
(B.USADO/A.TAMANHO_ATUAL)*100 ELSE (B.USADO/A.TAMANHO_MAXIMO)*100 END,2) AS USADO
 FROM 
        (SELECT TABLESPACE_NAME,AUTOEXTENSIBLE,
                       SUM(BYTES/1024/1024) TAMANHO_ATUAL,
                       SUM(MAXBYTES/1024/1024) TAMANHO_MAXIMO
         FROM   DBA_DATA_FILES
         GROUP BY TABLESPACE_NAME,AUTOEXTENSIBLE) A,
        (SELECT TABLESPACE_NAME,
                       SUM(BYTES/1024/1024) USADO
         FROM   DBA_SEGMENTS S
         GROUP BY TABLESPACE_NAME ) B
         WHERE A.TABLESPACE_NAME=B.TABLESPACE_NAME;