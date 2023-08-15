-- Campos Faltantes
ALTER TABLE SB1010 ADD B1_XCATEG varchar(6);
ALTER TABLE SB1020 ADD B1_XCATEG varchar(6);

ALTER TABLE SB1010 ADD B1_XTPSRV varchar(6);
ALTER TABLE SB1020 ADD B1_XTPSRV varchar(6);

ALTER TABLE SB1010 ADD B1_XCTROLE varchar(2);
ALTER TABLE SB1020 ADD B1_XCTROLE varchar(2);

-- Campos Afetados
alter table SC5010 ALTER COLUMN C5_XDEPART VARCHAR(1) NOT NULL;
alter table SC6010 ALTER COLUMN C6_XCC VARCHAR(9) NOT NULL;
alter table SD2010 ALTER COLUMN D2_XCC VARCHAR(9) NOT NULL;

alter table AF8010 ALTER COLUMN AF8_XCODSR varchar(6) NOT NULL;
alter table AF8010 ALTER COLUMN AF8_XREPRE varchar(6) NOT NULL;
alter table AF8010 ALTER COLUMN AF8_XVLACO float NOT NULL;
alter table AF8010 ALTER COLUMN AF8_XPRJOR varchar(14) NOT NULL;
alter table AF8010 ALTER COLUMN AF8_XNMAPR varchar(15) NOT NULL;
alter table AF8010 ALTER COLUMN AF8_XDTAPR varchar(8) NOT NULL;
alter table AF8010 ALTER COLUMN AF8_XHRAPR varchar(8) NOT NULL;
alter table AF8010 ALTER COLUMN AF8_XNOMCL varchar(40) NOT NULL;
alter table AF8010 ALTER COLUMN AF8_XCOMIS float NOT NULL;
alter table AF8010 ALTER COLUMN AF8_XRESP1 varchar(40) NOT NULL;
alter table AF8010 ALTER COLUMN AF8_XRESP2 varchar(40) NOT NULL;
alter table AF8010 ALTER COLUMN AF8_XVENDE varchar(6) NOT NULL;
alter table AF8010 ALTER COLUMN AF8_XPROP varchar(20) NOT NULL;

alter table AFC010 ALTER COLUMN AFC_XOP varchar(13) NOT NULL;
alter table AFC010 ALTER COLUMN AFC_XPROD varchar(15) NOT NULL;
alter table AFC010 ALTER COLUMN AFC_XPRODU varchar(1) NOT NULL;

--
select B1_XCATEG, B1_XTPSRV, B1_XCTROLE from SB1010 WHERE B1_XCATEG <> '' or B1_XTPSRV <> '' or B1_XCTROLE <> '';