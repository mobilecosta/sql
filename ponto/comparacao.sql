select * from TOTVS11.dbo.SP0010;
select * from ZT8HTG.dbo.SP0010;

select * from TOTVS11.dbo.SP1010;
select * from ZT8HTG.dbo.SP1010;

select * from TOTVS11.dbo.SP2010;
select * from ZT8HTG.dbo.SP2010;

select * from TOTVS11.dbo.SP3010;
select * from ZT8HTG.dbo.SP3010;

-- Atualizar
select * from TOTVS11.dbo.SP4010;
select * INTO SP4010_BKP from ZT8HTG.dbo.SP4010;

delete from ZT8HTG.dbo.SP4010;
insert into ZT8HTG.dbo.SP4010 
select * from TOTVS11.dbo.SP4010;

select * from ZT8HTG.dbo.SP4010;

select * from TOTVS11.dbo.SP5010;
select * from ZT8HTG.dbo.SP5010;

select * from TOTVS11.dbo.SP6010;
select * from ZT8HTG.dbo.SP6010;

select * from TOTVS11.dbo.SP8010;
select * from ZT8HTG.dbo.SP8010;

-- Atualizar
select * from TOTVS11.dbo.SP9010;
select * from ZT8HTG.dbo.SP9010;

select * into ZT8HTG.dbo.SP9010_bkp from ZT8HTG.dbo.SP9010;
delete from ZT8HTG.dbo.SP9010;

insert into ZT8HTG.dbo.SP9010 
select * from TOTVS11.dbo.SP9010;

select * from TOTVS11.dbo.SPA010;
select * from ZT8HTG.dbo.SPA010;

select * from TOTVS11.dbo.SPB010;
select * from ZT8HTG.dbo.SPB010;

select * from TOTVS11.dbo.SPC010;
select * from ZT8HTG.dbo.SPC010;