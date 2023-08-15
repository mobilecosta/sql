-- Processo ativo no oracle
SELECT NVL(s.username, '(oracle)') AS username,
       s.osuser,
       s.sid,
       s.serial#,
       p.spid,
       s.lockwait,
       s.status,
       s.module,
       s.machine,
       s.program,
       TO_CHAR(s.logon_Time,'DD-MON-YYYY HH24:MI:SS') AS logon_time
FROM   v$session s,
       v$process p
WHERE  s.paddr  = p.addr
AND    s.status = 'ACTIVE'
ORDER BY s.username, s.osuser

-- Instruções executadas
select sql_text, object_status, first_load_time, username, sid, lockwait
  from v$session ses, v$sql sql
where ses.sql_id = sql.sql_id and lockwait <> ' '

select inst_id,sid,serial# from gv$session where username='MXMCORP' and sid = 8574

alter system kill session '8574,19371,@1'

ALTER SYSTEM KILL SESSION '8574, 19371, @1' IMMEDIATE
	
-- Tempo de processamento
SELECT SID,
       SERIAL#,
       START_TIME,
       ((SOFAR/TOTALWORK)*100),'%',
       MESSAGE
  FROM V$SESSION_LONGOPS
  where TIME_REMAINING > 0 ORDER BY start_time

-- Tabelas em processo  
SELECT b.session_id AS sid,
       NVL(b.oracle_username, '(oracle)') AS username,
       a.owner AS object_owner,
       a.object_name,
       Decode(b.locked_mode, 0, 'None',
                             1, 'Null (NULL)',
                             2, 'Row-S (SS)',
                             3, 'Row-X (SX)',
                             4, 'Share (S)',
                             5, 'S/Row-X (SSX)',
                             6, 'Exclusive (X)',
                             b.locked_mode) locked_mode,
       b.os_user_name
FROM   dba_objects a,
       v$locked_object b
WHERE  a.object_id = b.object_id
ORDER BY 1, 2, 3, 4