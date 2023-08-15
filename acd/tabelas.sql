-- Etiquetas
SELECT * FROM CB0990 WHERE D_E_L_E_T_ = ' ';
SELECT * FROM SDB990 WHERE D_E_L_E_T_ = ' ';

-- Operadores
SELECT * FROM CB1990 WHERE D_E_L_E_T_ = ' ';

-- Cart�o de Volume
SELECT * FROM CB2990 WHERE D_E_L_E_T_ = ' ';
UPDATE CB2990 SET CB2_ORDSEP = '' WHERE D_E_L_E_T_ = ' ';

-- Libera��o de Pedidos
SELECT * FROM SC9990 
 WHERE D_E_L_E_T_ = ' ' AND C9_ORDSEP = '000024';

-- Cabecalho de Separa��o
SELECT * FROM CB7990 
 WHERE D_E_L_E_T_ = ' ' AND CB7_ORDSEP = '000024';

UPDATE CB7990 
   SET CB7_STATUS = '0', CB7_NOTA = '', CB7_SERIE = '' 
-- SET CB7_NFEMIT = '1', CB7_STATUS = '6'
 WHERE D_E_L_E_T_ = ' ' AND CB7_ORDSEP = '000024';

-- Itens a serem separados
SELECT * FROM CB8990 
 WHERE D_E_L_E_T_ = ' ' AND CB8_ORDSEP = '000024';

UPDATE CB8990 SET CB8_SALDOS = CB8_QTDORI, CB8_SALDOE = CB8_QTDORI
 WHERE D_E_L_E_T_ = ' ' AND CB8_ORDSEP = '000024'; 

-- Itens separados
SELECT * FROM CB9990 
 WHERE D_E_L_E_T_ = ' ' AND CB9_ORDSEP = '000024';

UPDATE CB9990 SET D_E_L_E_T_ = ' '
 WHERE D_E_L_E_T_ = ' ' AND CB9_ORDSEP = '000024';
UPDATE CB9990 SET D_E_L_E_T_ = '*' 
 WHERE D_E_L_E_T_ = ' ' AND CB9_ORDSEP = '000024';

-- Itens Volumes
SELECT * FROM CB6990 WHERE D_E_L_E_T_ = ' ';
UPDATE CB6990 SET D_E_L_E_T_ = '*' WHERE D_E_L_E_T_ = ' ' AND CB6_STATUS = '1';

END:  0000000263
SEP:  000018
VOL:  0000000016
SVOL: 0000000264

-- Faturamento
SELECT * FROM SF2990 WHERE D_E_L_E_T_ = ' ';
SELECT * FROM SF3990 WHERE D_E_L_E_T_ = ' ';

UPDATE CB0990 SET CB0_LOCALI = 'EXP'  WHERE D_E_L_E_T_ = ' ' AND CB0_CODETI = '0000000263';
SELECT * FROM CB0990 WHERE D_E_L_E_T_ = ' ' AND CB0_CODETI = '0000000263';

-- Convoca��o
SELECT CB7.CB7_X2CODP,CB7.CB7_CODOPE,CB7.CB7_STATUS,CB7.R_E_C_N_O_ AS RECNO FROM CB7990 CB7 WHERE  CB7.CB7_FILIAL = '01' AND CB7.D_E_L_E_T_ = ' ' AND ((CB7.CB7_X2CODP = '000000' AND CB7.CB7_XSEP2 <> '1') OR CB7.CB7_CODOPE = '000000' OR CB7.CB7_CODOPE = '      ') AND CB7_STATUS IN ('0', '1')  ORDER BY  CASE WHEN CB7.CB7_CODOPE = '000000' AND (CB7.CB7_DIVERG = '1' OR CB7.CB7_XCONF = '1') THEN 0 ELSE CASE WHEN CB7.CB7_X2CODP = '000000' THEN 1 ELSE CASE WHEN CB7.CB7_CODOPE = '000000' THEN 2 ELSE 3 END END END , CB7_XPDTCL, CB7_XPHRCL, CB7_PEDIDO

SELECT * FROM CBG990 
 WHERE D_E_L_E_T_ = ' ' AND CBG_ORDSEP = '000024'
 ORDER BY CBG_HORA

-- Saldo por Lote
SELECT * FROM SB8990 
 WHERE D_E_L_E_T_ = ' ' AND B8_PRODUTO = 'EXP' AND B8_SALDO > 0;
 
-- Saldo por Endere�o
SELECT * FROM SBF990 
 WHERE D_E_L_E_T_ = ' ' AND BF_PRODUTO = 'EXP' AND BF_QUANT > 0; 
 
SELECT F2_TRANSP, * FROM SF2990 WHERE D_E_L_E_T_ = ' '; 

SELECT * FROM CB9990 WHERE D_E_L_E_T_ = ' ' AND CB9_DISPID <> ''
 ORDER BY CB9_DISPID;