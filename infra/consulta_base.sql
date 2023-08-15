select * from SDA010;	-- Endereçamento
select * from SF1010;	-- Notas de Compras
select * from SD1010;	-- Itens das Notas de Compras

select * from SC5010;	-- Pedidos de Vendas
select * from SC6010;	-- Itens dos Pedidos de Vendas
select * from SC9010;	-- Liberação dos Pedidos de Vendas

select * from SF2010;	-- Notas de Vendas
select * from SD2010;	-- Itens das Notas de Vendas
select * from ZEF010;	-- Reservas para Antecipação

select * from SB2010;	-- Saldo em Estoque

select * from SBF010 	-- Saldo por Endereço
 where BF_PRODUTO = '90000';
 
select * from SE2010;	-- Contas a Pagar

select * from SF3010;	-- Livro Fiscal
select * from SFT010;	-- Itens do Livro

select D_E_L_E_T_, * from SDC010 	-- Composição do Empenho
 where DC_PRODUTO = '90000' AND D_E_L_E_T_ = ' ';
 
select C0_QUANT, C0_QTDPED, C0_QTDORIG, * from SC0010 	-- Reservas
 where C0_PRODUTO = '90000' and D_E_L_E_T_ = ' ' AND (C0_QUANT > 0 OR C0_QTDPED > 0); 

-- Desbloqueio o produto e informa preço 
UPDATE SB1010 SET B1_MSBLQL = '2', B1_PRV1 = 100, B1_CUSTD = 1000
 WHERE B1_COD IN ('90025','90026');
 
SELECT C0_QUANT, C0_QTDPED, C0_QTDORIG, * FROM SC0010;

SELECT C7_NUM, * FROM SC7010 WHERE C7_PRODUTO = '90000';

SELECT * FROM SB1010 WHERE B1_COD LIKE '9002%' ORDER BY B1_COD;

SELECT * FROM SC2010 WHERE C2_PRODUTO = '90009';
SELECT * FROM SD4010 WHERE D4_COD IN ('90009','90025','90026');
SELECT * FROM SC1010 WHERE C1_PRODUTO IN ('90009','90025','90026');
SELECT B2_QEMP, B2_QACLASS, *  FROM SB2010 WHERE B2_COD IN ('90009','90025','90026');

SELECT * FROM SG1010 WHERE G1_COD = '90009';

SELECT * FROM SC2010 WHERE C2_FILIAL = 'xx';