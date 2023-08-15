-- Parcela com ASPAS
select * into SE2010_aspas from SE2010 where D_E_L_E_T_ = ' ' and E2_PARCELA = '''' and E2_ORIGEM = 'SIGAEIC';

select * from SE2010_aspas;

select E2_ORIGEM, * from SE2010 where E2_NUM = '000400/11' and E2_ORIGEM = 'SIGAEIC';
select E5_NUMERO, E5_PARCELA, E5_PREFIXO, * from SE5010 where E5_NUMERO = '000400/11' and E5_PREFIXO = 'EIC';

update SE2010 set E2_PARCELA = ' ' where D_E_L_E_T_ = ' ' and E2_PARCELA = '''' and E2_ORIGEM = 'SIGAEIC';
update SE2010 set E2_PARCELA = '''' where D_E_L_E_T_ = ' ' and E2_NUM = '000400/11' and E2_ORIGEM = 'SIGAEIC';

update SE2010 set E2_PARCELA = ' ' where D_E_L_E_T_ = ' ' and E2_NUM = '000400/11' and E2_ORIGEM = 'SIGAEIC';
update SE5010 set E5_PARCELA = ' ' where D_E_L_E_T_ = ' ' and E5_NUMERO = '000400/11' and E5_PREFIXO = 'EIC';

select CHAR(39);

select E2_PARCELA from SE2010
 where E2_ORIGEM = 'SIGAEIC'
 group by E2_PARCELA
 order by E2_PARCELA

update SE2010 set E2_PARCELA = ' ' where D_E_L_E_T_ = ' ' and E2_PARCELA = ''''
 
-- Problemas na integração
select W9_FOB_TOT, * from SW9010 where W9_HAWB = '00349/11'
order by W9_FOB_TOT;

select E2_ORIGEM, E2_VALOR, E2_VALLIQ, * from SE2010 where E2_HIST LIKE '%00349/11%'
ORDER BY E2_VALOR;

select TOP 1 * from SWD010 where WD_HAWB LIKE '%400/11%';

SELECT * FROM SE2010 WHERE E2_ORIGEM = 'SIGAEIC' and E2_PARCELA = 'A' AND E2_TIPO = 'PA';