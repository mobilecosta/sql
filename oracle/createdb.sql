create database PROTHEUS
logfile group 1 ('C:\ORACLE\DATA\redo1.log') size 10M,
group 2 ('C:\ORACLE\DATA\redo2.log') size 10M,
group 3 ('C:\ORACLE\DATA\redo3.log') size 10M
character set WE8MSWIN1252
national character set AL16UTF16
datafile 'C:\ORACLE\DATA\system.dbf'
size 524288000
autoextend on
maxsize unlimited
extent management local
sysaux datafile 'C:\ORACLE\DATA\sysaux.dbf'
size 524288000
autoextend on
maxsize unlimited
undo tablespace undotbs1
datafile 'C:\ORACLE\DATA\undo.dbf'
size 770703360
default temporary tablespace temp
tempfile 'C:\ORACLE\DATA\temp.dbf' size 10000M;

create tablespace USERS
 datafile 'C:\ORACLE\DATA\USERS01.DBF' size 2147483648
 autoextend on maxsize unlimited
default storage ( initial 65536 minextents 1 maxextents unlimited) ;

create tablespace DADOSADV
 datafile 'C:\ORACLE\DATA\DADOSADV_01.ORA' size 10737418240
 autoextend on maxsize unlimited
default storage ( initial 65536 minextents 1 maxextents unlimited) ;

create tablespace INDEXADV
 datafile 'C:\ORACLE\DATA\INDEXADV_01.ORA' size 10737418240
 autoextend on maxsize unlimited
default storage ( initial 65536 minextents 1 maxextents unlimited) ;