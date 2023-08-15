-- Movimentos
select SUM(QUANT) 
  from KARDEX where B1_COD = 'PNUP.0010.04.MP' and Origem in ('SD1', 'SD3');

select *
  from KARDEX where B1_COD = 'PNUP.0010.04.MP' and Origem in ('SD1', 'SD3')
 order by SEQUENCIA;

select *
  from KARDEX where B1_COD = 'PNUP.0007.03.MP' and Origem in ('SD1', 'SD3')
 order by SEQUENCIA;
 
select * from SD3010 where R_E_C_N_O_ = 31025;

-- Movimentos por Lote
select SUM(CASE WHEN D5_ORIGLAN < '500' Then D5_QUANT else 0 end) as entradas, 
       SUM(CASE WHEN D5_ORIGLAN >= '500' Then D5_QUANT else 0 end) as saidas 
  from SD5010 where D_E_L_E_T_ = ' ' and D5_PRODUTO = 'PNUP.0010.04.MP' and D5_ESTORNO = ' ';

select *
  from SD5010 where D_E_L_E_T_ = ' ' and D5_PRODUTO = 'PNUP.0010.04.MP' and D5_ESTORNO = ' ';  

select SUM(CASE WHEN D5_ORIGLAN < '500' Then D5_QUANT else 0 end) as entradas, 
       SUM(CASE WHEN D5_ORIGLAN >= '500' Then D5_QUANT else 0 end) as saidas 
  from SD5010 where D_E_L_E_T_ = ' ' and D5_PRODUTO = 'PNUP.0007.03.MP' and D5_ESTORNO = ' ';

SELECT * FROM SD1010 WHERE D_E_L_E_T_ = ' ' AND D1_COD = 'PNUP.0007.03.MP' 
   AND D1_DTDIGIT BETWEEN '20121201' AND '20121231'
 ORDER BY D1_DTDIGIT;

-- Detalhe
SELECT * FROM SD3010 WHERE D_E_L_E_T_ = ' ' AND D3_COD = 'PNUP.0007.03.MP' 
   AND D3_EMISSAO BETWEEN '20121201' AND '20121231' AND D3_ESTORNO = ' '
 ORDER BY D3_EMISSAO;

-- Soma
SELECT SUM(D3_QUANT) FROM SD3010 WHERE D_E_L_E_T_ = ' ' AND D3_COD = 'PNUP.0007.03.MP' 
   AND D3_EMISSAO BETWEEN '20121201' AND '20121231' AND D3_ESTORNO = ' ';

-- Detalhe
select *
  from SD5010 where D_E_L_E_T_ = ' ' and D5_PRODUTO = 'PNUP.0007.03.MP'
 order by D5_DATA;  
 
   and D5_ESTORNO = ' '

-- Soma
select SUM(D5_QUANT * CASE WHEN D5_ORIGLAN < '500' THEN 1 ELSE -1 END)
  from SD5010 where D_E_L_E_T_ = ' ' and D5_PRODUTO = 'PNUP.0007.03.MP' and D5_ESTORNO = ' '
   AND D5_DATA BETWEEN '20121201' AND '20121231';
 
select *
  from SD5010 where D_E_L_E_T_ = ' ' and D5_PRODUTO = 'PNUP.0007.03.MP'
 order by D5_DATA;  
  
select * from SB2010  
 where D_E_L_E_T_ = ' ' AND B2_COD in ('PNUP.0010.04.MP', 'PNUP.0007.03.MP', 'PNUP.0007.05.MP');
  
update SB2010  
   set B2_QFIM = 0
 where D_E_L_E_T_ = ' ' AND B2_COD in ('PNUP.0010.04.MP', 'PNUP.0007.03.MP');
 
select * from SD3010
 where D3_NUMSEQ = '169162';

select * from SD3010 
 where D_E_L_E_T_ = ' ' and D3_COD = 'PNUP.0007.03.MP'
 order by D3_EMISSAO;
 
select * from SD3010 
 where D_E_L_E_T_ = ' ' and D3_COD = 'PNUP.0007.05.MP'
 order by D3_EMISSAO;

select * from SBJ010 where D_E_L_E_T_ = ' ' AND BJ_COD = 'PNUP.0007.03.MP';
select * from SB9010 where D_E_L_E_T_ = ' ' AND B9_COD = 'PNUP.0007.03.MP';

select * from SD5010 where D_E_L_E_T_ = ' ' AND D5_PRODUTO = 'PNUP.0007.03.MP';
   
select * from SD5010 where D_E_L_E_T_ = ' ' AND D5_DATA = '20121220'  
   and D5_PRODUTO = 'PNUP.0007.05.MP';  

SELECT MAX(D3_SEQCALC) FROM SD3010 WHERE D3_SEQCALC = '20121201000622'

SELECT * FROM SB8010 WHERE D_E_L_E_T_ = ' ' AND B8_PRODUTO = 'PNUP.0007.03.MP';

SELECT * FROM SB8010 WHERE D_E_L_E_T_ = ' ' AND B8_PRODUTO = 'PNUP.0010.04.MP';

select * from AFR010 