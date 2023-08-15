-- 1) Ajuste da tabela de grupos
delete from dbo.SNG010;
insert into dbo.SNG010
select * from ZT8HTG_LAB.dbo.SNG010;
 
-- 2) Preenchimento da moeda 3 no mês 10/2011
update SM2010 set M2_MOEDA3 = 0.8287 
 where M2_DATA >= '20111001' and M2_DATA <= '20111031'; 
 
-- 3) Configuração MV_TIPDEPR = 1

-- 4) Executar a importação da planilha

-- 5) Baixa dos ativos Celrob004209

-- 6) Revisão das tes que geram ativo fixo
select F4_BENSATF,* from SF4010 
 where F4_ATUATF = 'S' and F4_MSBLQL <> '1'
 order by F4_CODIGO;

-- Marca para desmembrar o ativo
update SF4010 set F4_BENSATF = '1'
 where F4_ATUATF = 'S' and F4_MSBLQL <> '1';
 
-- 7) Calculo da Depreciação do mês 10/2011 

-- 8) Valor do PIS/COFINS
SELECT SUM(N1_XCOFAPR) AS VLR_COFINS, SUM(N1_XPISAPR) AS VLR_PIS, SUM(N1_ICMSAPR) AS N1_ICMSAPR
  FROM SN1010;
  
-- 9) Ajuste dos excesso
SELECT SUBSTRING(FA_DATA, 1, 6) AS COMPETE, SUM(FA_VALOR) AS BASE 
  FROM SFA010
 GROUP BY SUBSTRING(FA_DATA, 1, 6)
 ORDER BY SUBSTRING(FA_DATA, 1, 6) ;
 
DELETE FROM SFA010 WHERE FA_DATA >= '20090101';

-- 10) Ajuste de acordo com o balanço feito pela planilha do Jorge - 11/2011

-- Acumulados pela conta de depreciação - Por Centro de Custos
SELECT SUM(N3_VRDACM1)
  FROM
(
SELECT N3_CCDEPR, N3_CCUSTO, SUM(N3_VRDACM1) AS N3_VRDACM1
  FROM SN3010
 WHERE N3_CCDEPR <> '' AND N3_DTBAIXA = ''
 GROUP BY N3_CCDEPR, N3_CCUSTO
 ORDER BY N3_CCDEPR, N3_CCUSTO
) AS SN3;


-- Acumulados pela conta de depreciação - Por Conta Contábil
SELECT N3_CCDEPR, SUM(N3_VRDACM1) AS N3_VRDACM1
  FROM SN3010
 WHERE N3_CCDEPR <> '' AND N3_DTBAIXA = ''
 GROUP BY N3_CCDEPR
 ORDER BY N3_CCDEPR;

-- Acumulados pela conta de depreciação
SELECT SUM(N3_VORIG1)
  FROM
(
SELECT N3_CCDEPR, N3_CCUSTO, SUM(N3_VORIG1) AS N3_VORIG1
  FROM SN3010
 WHERE N3_CCDEPR <> '' AND N3_DTBAIXA = ''
 GROUP BY N3_CCDEPR, N3_CCUSTO
) AS SN3;

SELECT * FROM SN1010;

-- Controle do CIAP
SELECT * FROM SF9010 WHERE F9_VLESTOR > F9_ICMIMOB;

SELECT SUM(FA_VALOR) FROM SFA010 WHERE FA_CODIGO = '000445';

SELECT * FROM SFA010 WHERE FA_CODIGO = '000445' ORDER BY FA_DATA