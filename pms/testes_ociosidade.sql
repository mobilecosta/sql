-- Cria link do servidor para uso de OPENQUERY
sp_addlinkedserver @server = 'LOCALSERVER',  @srvproduct = '',
                   @provider = 'SQLOLEDB', @datasrc = @@servername
select * from sys.servers

sp_configure 'show advanced options', 1;
RECONFIGURE;

sp_configure 'Ad Hoc Distributed Queries', 1;
RECONFIGURE;
GO
  
--FROM OPENROWSET('SQLOLEDB','192.168.1.15';'siga';'siga', 'exec dt_pmsocioso');
--FROM OPENROWSET('SQLNCLI','Server=192.168.1.15;Trusted_Connection=yes;', 'exec dt_pmsocioso');
--FROM OPENQUERY(LOCALSERVER, 'exec dt_pmsocioso');
--FROM OPENROWSET('SQLSRV1', 'siga', 'siga', '', 'exec dt_pmsocioso');
