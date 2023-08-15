-- Itens de Entrada de Mercadoria
select D1_LOTECTL, *
  from SD1010
 where D_E_L_E_T_ = ' ' and D1_LOTECTL <> '';

-- Itens de Saída de Mercadoria
select D2_LOTECTL, *
  from SD2010
 where D_E_L_E_T_ = ' ' and D2_LOTECTL <> '';

-- Requisição de Mercadoria
select D3_LOTECTL, *
  from SD3010
 where D_E_L_E_T_ = ' ' and D3_LOTECTL <> '' AND D3_ESTORNO <> 'S';

-- Requisições por Lote
select * from SD5010
 where D_E_L_E_T_ = ' '
 order by D5_PRODUTO, D5_NUMSEQ; 

-- Movimentação por Lote
select D5_PRODUTO, SUM(D5_QUANT * CASE WHEN D5_ORIGLAN < '500' THEN 1 ELSE -1 END) AS SALDO
  from SD5010
 where D_E_L_E_T_ = ' '
 group by D5_PRODUTO
 order by D5_PRODUTO;

select * from SD5010
 where D_E_L_E_T_ = ' '
 order by R_E_C_N_O_;

select * from SB8010
 where D_E_L_E_T_ = ' '
 order by R_E_C_N_O_;

-- Requisição de Mercadoria
select D3_LOTECTL, *
  from SD3010
 where D_E_L_E_T_ = ' ' and D3_COD = '158290-4MP'
 ORDER BY R_E_C_N_O_;

-- Saldos por Lote
select * from SB8010
 where D_E_L_E_T_ = ' ';

-- Saldos Iniciais por Lote
select * from SBJ010
 where D_E_L_E_T_ = ' ';

select * from SDB010
 where D_E_L_E_T_ = ' ';

-- Saldos por Lote
select * from SC9010
 where D_E_L_E_T_ = ' ' AND C9_NUMLOTE <> '';
 
-- Saldos Iniciais por Local
select SB9.B9_COD, SB9.B9_LOCAL, SB9.B9_QINI as QTD_042012, COALESCE(KDX.QUANT, 0) AS MOVIMENTO,
       COALESCE(SB9_OLD.B9_QINI, 0) as QTD_032012, KDX_05.QUANT AS QUANT_05, SB2.B2_QATU 
  from SB9010 SB9
  left join (select B9_COD, B9_LOCAL, B9_QINI from SB9010
              where D_E_L_E_T_ = ' ' and B9_FILIAL = '01' and B9_DATA = '20120331') SB9_OLD on SB9_OLD.B9_COD = SB9.B9_COD
   and SB9_OLD.B9_LOCAL = SB9.B9_LOCAL
  left join (select B1_COD, B1_LOCAL, SUM(QUANT) AS QUANT
               from KARDEX
              where DATA between '20120401' and '20120430'
           group by B1_COD, B1_LOCAL) KDX on KDX.B1_COD = SB9.B9_COD 
   and KDX.B1_LOCAL = SB9.B9_LOCAL
  left join (select B1_COD, B1_LOCAL, SUM(QUANT) AS QUANT
               from KARDEX
              where DATA between '20120501' and '20120531'
           group by B1_COD, B1_LOCAL) KDX_05 on KDX_05.B1_COD = SB9.B9_COD 
   and KDX_05.B1_LOCAL = SB9.B9_LOCAL
  join SB2010 SB2 on SB2.D_E_L_E_T_ = ' ' AND SB2.B2_FILIAL = SB9.B9_FILIAL AND SB2.B2_COD = SB9.B9_COD 
   and SB2.B2_LOCAL = SB9.B9_LOCAL 
 where SB9.D_E_L_E_T_ = ' ' and SB9.B9_FILIAL = '01' and SB9.B9_DATA = '20120430'
   and SB9.B9_QINI > 0 AND SB9.B9_QINI + KDX_05.QUANT = SB2.B2_QATU
 order by SB9.B9_COD, SB9.B9_LOCAL;

SELECT * FROM SB2010 WHERE D_E_L_E_T_ = ' ' AND B2_QATU > 0;

select SB9.B9_COD, SB9.B9_QINI, 
       (SELECT SUM(D1_QUANT) FROM SD1010 WHERE D_E_L_E_T_ = ' ' AND D1_COD = SB9.B9_COD) AS ENTRADAS
  from SB9010 SB9
 where SB9.D_E_L_E_T_ = ' ' AND SB9.B9_DATA = '20120430' AND SB9.B9_QINI > 0
 order by SB9.B9_COD;
 
-- Movimentação
SELECT D1_EMISSAO, * FROM SD1010 
 WHERE D_E_L_E_T_ = ' ' AND D1_COD = '021973' 
 ORDER BY D1_EMISSAO, R_E_C_N_O_;

SELECT * FROM SD3010 
 WHERE D_E_L_E_T_ = ' ' AND D3_COD = '021973' 
 ORDER BY D3_EMISSAO, R_E_C_N_O_;
 
-- Kardex 05/2012
SELECT * FROM KARDEX 
 WHERE DATA >= '20120501' AND ABS(QUANT) <> 0
 ORDER BY SEQUENCIA;
 
-- Produtos vinculados a POM
SELECT * FROM AFA010 
 WHERE D_E_L_E_T_ = ' ' AND AFA_PROJET <> '' AND AFA_XPO <> ''
 ORDER BY AFA_PROJET;

SELECT * FROM AF8010 WHERE RIGHT(AF8_PROJET, 3) = '12A'
 ORDER BY AF8_PROJET;
 
SELECT AF8_FASE, * 
  FROM AF8010
 WHERE AF8_PROJET = 'PMS003912A'; 
 
-- Produtos com empenho
SELECT SG1.CONTADOR, SB2.B2_QEMP, SB2.* 
  FROM SB2010 SB2
  LEFT JOIN (SELECT G1_COMP, COUNT(*) AS CONTADOR FROM SG1010 
              WHERE D_E_L_E_T_ = ' '
              GROUP BY G1_COMP) SG1 ON  SG1.G1_COMP = SB2.B2_COD
 WHERE SB2.D_E_L_E_T_ = ' ' AND SB2.B2_QEMP > 0 AND SG1.CONTADOR > 0
 ORDER BY SB2.B2_COD;

-- ESTRUTURA
SELECT * FROM SG1010;

SELECT * FROM SB8010;
SELECT * FROM SD5010;

-- Tabelas a Gerar
DELETE FROM SB8010;
DELETE FROM SD5010;

-- Lote
select * from SB8010
 where D_E_L_E_T_ = ' '
 order by B8_PRODUTO;

select * into SB8010_LOTE from SB8010;

delete from SB8010;

select * from SB8010_LOTE
 where D_E_L_E_T_ = ' '
 order by B8_PRODUTO;

-- Movimento do Lote
select * from SD5010
 where D_E_L_E_T_ = ' '
 order by D5_PRODUTO;

select * into SD5010_LOTE from SD5010;

delete from SD5010;

select * from SD5010_LOTE
 where D_E_L_E_T_ = ' '
 order by D5_PRODUTO;

insert into SD5010
select * from SD5010_LOTE;
 
-- Movimentos Internos
select * from SD3010
 where D_E_L_E_T_ = ' ' and D3_LOTECTL <> '' AND D3_ESTORNO <> 'S';
 
select * from SD3010
 where D_E_L_E_T_ = ' ' and D3_EMISSAO = '20120516';
 
select B2_COD, B2_QATU, B2_VATU1, B2_QEMP, B2_QEMPN, B2_RESERVA, B2_QPEDVEN, B2_NAOCLAS, B2_SALPEDI, 
       B2_QTNP, B2_QNPT, B2_QTER, B2_QACLASS, B2_QEMPPR2
  from SB2010
 where B2_QATU + B2_VATU1 + B2_QEMP + B2_QEMPN + B2_RESERVA + B2_QPEDVEN + B2_NAOCLAS + B2_SALPEDI + 
       B2_QTNP + B2_QNPT + B2_QTER + B2_QACLASS + B2_QEMPPR2 <> 0;        
-- Saldo Atual: B2_QATU - B2_QEMP - B2_RESERVA        

-- Resultado de testes
select * 
  from SB8010
 where D_E_L_E_T_ = ' ' and B8_PRODUTO in ('CELROB008911A3', '158290-4MP', 'MCDC.0001.01.MC');

SELECT * FROM SB8010
 WHERE B8_PRODUTO = '1119 005';
 
SELECT * FROM SD5010 WHERE D5_ORIGLAN > '499'; 
SELECT * FROM SB8010;

-- Comparações
SELECT SUM(SB9.B9_QINI) AS B9_QINI, SUM(SB2.B8_QTDORI) AS B8_QTDORI
  FROM (
SELECT SB2.B2_FILIAL, SB2.B2_COD, SB2.B2_LOCAL, 
       SB2.B2_QATU + COALESCE(KDX.QUANT * -1, 0) AS B8_QTDORI, 
       SB2.B2_QATU AS B8_SALDO, 
       '20120430' AS B8_DATA, '20301231' AS B8_DTVALID, 
       'NF' AS B8_ORIGLAN, 'INICIAL' AS B8_LOTECTL, ' ' AS D_E_L_E_T_, 
       ROW_NUMBER() OVER(ORDER BY R_E_C_N_O_) AS R_E_C_N_O_
  FROM SB2010 SB2
  LEFT JOIN (select B1_COD, SUM(QUANT) AS QUANT
               from KARDEX
              where DATA between '20120501' and '20120531' and B1_LOCAL = '01'
              group by B1_COD
             having SUM(QUANT) <> 0) KDX ON KDX.B1_COD = SB2.B2_COD
 WHERE SB2.D_E_L_E_T_ = ' ' AND SB2.B2_FILIAL = '01' AND SB2.B2_LOCAL = '01'
   AND SB2.B2_QATU + COALESCE(KDX.QUANT * -1, 0) > 0
) SB2
  LEFT JOIN SB9010 SB9 ON SB9.D_E_L_E_T_ = ' ' AND SB9.B9_FILIAL = '01' AND SB9.B9_DATA = '20120430'
   AND SB9.B9_COD = SB2.B2_COD AND SB9.B9_LOCAL = '01';
   
SELECT SUM(B9_QINI) FROM SB9010 WHERE D_E_L_E_T_ = ' ' AND B9_FILIAL = '01' AND B9_LOCAL = '01' 
   AND B9_DATA = '20120430';
   
-- Movimentação por Lote
select SUM(D5_QUANT * CASE WHEN D5_ORIGLAN < '500' THEN 1 ELSE -1 END) AS SALDO
  from SD5010
 where D_E_L_E_T_ = ' ';
   