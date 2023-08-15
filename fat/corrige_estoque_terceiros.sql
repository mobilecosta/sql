select B2_QTNP, B2_QTER, * from SB2010 WHERE B2_COD = '34.0350.1973';

select B6_IDENT, B6_IDENTB6, B6_SALDO, * from SB6010 
 WHERE B6_PRODUTO = '34.0350.1973' and D_E_L_E_T_ = ' ';

SELECT D1_DOC, D1_SERIE, D1_FORNECE, D1_LOJA, D1_IDENTB6, D1_DTDIGIT, * 
  FROM SD1010 WHERE D1_COD = '34.0350.1973';

SELECT D2_DOC, D2_SERIE, D2_TIPO, D2_IDENTB6, D2_DTDIGIT, * 
  FROM SD2010 WHERE D2_COD = '34.0350.1973';

UPDATE SD2010 SET D2_IDENTB6 = '' WHERE D2_COD = '34.0350.1973';

update SB6010 SET D_E_L_E_T_ = '*' WHERE B6_PRODUTO = '34.0350.1973';

-- Remessa do Poder
SELECT SD1.D1_IDENTB6, SD1.D1_LOCAL, SF4.F4_PODER3, SF4.F4_ESTOQUE, SD1.* FROM SD1010 SD1, SF4010 SF4 
 WHERE SD1.D1_FILIAL='01' AND SD1.D1_COD >= '34.0350.1973' AND SD1.D1_COD <= '34.0350.1973'
   AND SD1.D_E_L_E_T_=' ' AND SF4.F4_FILIAL='01' AND SF4.F4_CODIGO=SD1.D1_TES AND SF4.F4_PODER3='R' 
   AND SF4.D_E_L_E_T_=' '
 ORDER BY D1_FILIAL,D1_COD,D1_LOCAL;

-- Devolu��o
SELECT SD2.D2_TES, SD2.D2_IDENTB6, SF4.F4_PODER3, SD2.*, SF4.F4_PODER3 
  FROM SD2010 SD2, SF4010 SF4
 WHERE SD2.D2_FILIAL='01' AND SD2.D2_COD >= '34.0350.1973' AND SD2.D2_COD <= '34.0350.1973'
   AND SD2.D_E_L_E_T_=' ' AND SF4.F4_FILIAL='01' AND SF4.F4_PODER3='D'
   AND SF4.F4_CODIGO=SD2.D2_TES AND SF4.D_E_L_E_T_=' ' 
 ORDER BY D2_FILIAL,D2_COD,D2_LOCAL;
 
-- 01. poder de/em terceiro - Sa�das
SELECT SD2.*,SF4.F4_PODER3 FROM SD2010 SD2 , SF4010 SF4 
 WHERE SD2.D2_FILIAL='01' AND SD2.D2_COD >= '34.0350.1973   ' AND SD2.D2_COD <= '34.0350.1973   ' AND SD2.D_E_L_E_T_=' ' AND SF4.F4_FILIAL='01' AND SF4.F4_CODIGO=SD2.D2_TES AND SF4.F4_PODER3='R' AND SF4.D_E_L_E_T_=' ' 
 ORDER BY D2_FILIAL,D2_COD,D2_LOCAL;
 
-- 02. poder de/em terceiro
SELECT SD1.*,SF4.F4_PODER3 FROM SD1010 SD1 , SF4010 SF4 
 WHERE SD1.D1_FILIAL='01' AND SD1.D1_COD >= '34.0350.1973   ' AND SD1.D1_COD <= '34.0350.1973   ' AND SD1.D_E_L_E_T_=' ' AND SF4.F4_FILIAL='01' AND SF4.F4_CODIGO=SD1.D1_TES AND SF4.F4_PODER3='R' AND SF4.D_E_L_E_T_=' ' 
 ORDER BY D1_FILIAL,D1_COD,D1_LOCAL;
 
-- 03. Retornos do Poder de terceiro 
SELECT SD2.*,SF4.F4_PODER3 FROM SD2010 SD2 , SF4010 SF4 
 WHERE SD2.D2_FILIAL='01' AND SD2.D2_COD >= '34.0350.1973   ' AND SD2.D2_COD <= '34.0350.1973   ' AND SD2.D_E_L_E_T_=' ' AND SF4.F4_FILIAL='01' AND SF4.F4_CODIGO=SD2.D2_TES AND SF4.F4_PODER3='D' AND SF4.D_E_L_E_T_=' ' 
 ORDER BY D2_FILIAL,D2_COD,D2_LOCAL 

-- Itens de nota de beneficiamento sem o identificador de terceiros 
SELECT D2_NFORI, D2_SERIORI, D2_CLIENTE, D2_LOJA, D2_ITEMORI, * FROM SD2010 
 WHERE D2_FILIAL = '01' AND D2_IDENTB6 = '' AND D2_TIPO = 'B' AND D2_NFORI <> '' AND D2_ITEMORI <> '';
-- AND D2_COD = '34.0350.1973   ';

-- Relacionamento com SD1
SELECT SD1.D1_IDENTB6, SD2.D2_NFORI, SD2.D2_SERIORI, SD2.D2_CLIENTE, SD2.D2_LOJA, SD2.D2_ITEMORI, SD2.* 
  FROM SD2010 SD2
  JOIN SD1010 SD1 ON SD1.D1_FILIAL = SD2.D2_FILIAL AND SD1.D1_DOC = SD2.D2_NFORI 
   AND SD1.D1_SERIE = SD2.D2_SERIORI AND SD1.D1_FORNECE = SD2.D2_CLIENTE AND SD1.D1_LOJA = SD2.D2_LOJA
   AND SD1.D1_ITEM = SD2.D2_ITEMORI AND SD1.D1_IDENTB6 <> ''
 WHERE SD2.D2_FILIAL = '01' AND SD2.D2_IDENTB6 = '' AND SD2.D2_TIPO = 'B' AND SD2.D2_NFORI <> '' 
   AND SD2.D2_ITEMORI <> '';
 
-- Update D2_TIPO = 'B'
UPDATE SD2010
   SET D2_IDENTB6 = SD1.D1_IDENTB6
  FROM (
SELECT SD1.D1_IDENTB6, SD2.R_E_C_N_O_
  FROM SD2010 SD2
  JOIN SD1010 SD1 ON SD1.D1_FILIAL = SD2.D2_FILIAL AND SD1.D1_DOC = SD2.D2_NFORI 
   AND SD1.D1_SERIE = SD2.D2_SERIORI AND SD1.D1_FORNECE = SD2.D2_CLIENTE AND SD1.D1_LOJA = SD2.D2_LOJA
   AND SD1.D1_ITEM = SD2.D2_ITEMORI AND SD1.D1_IDENTB6 <> ''
 WHERE SD2.D2_FILIAL = '01' AND SD2.D2_IDENTB6 = '' AND SD2.D2_TIPO = 'B' AND SD2.D2_NFORI <> '' 
   AND SD2.D2_ITEMORI <> ''
) SD1
 WHERE SD2010.R_E_C_N_O_ = SD1.R_E_C_N_O_;
 
SELECT SD1.D1_IDENTB6, SD2010.*
  FROM SD2010, (
SELECT SD1.D1_IDENTB6, SD2.R_E_C_N_O_
  FROM SD2010 SD2
  JOIN SD1010 SD1 ON SD1.D1_FILIAL = SD2.D2_FILIAL AND SD1.D1_DOC = SD2.D2_NFORI 
   AND SD1.D1_SERIE = SD2.D2_SERIORI AND SD1.D1_FORNECE = SD2.D2_CLIENTE AND SD1.D1_LOJA = SD2.D2_LOJA
   AND SD1.D1_ITEM = SD2.D2_ITEMORI AND SD1.D1_IDENTB6 <> ''
 WHERE SD2.D2_FILIAL = '01' AND SD2.D2_IDENTB6 = '' AND SD2.D2_TIPO = 'B' AND SD2.D2_NFORI <> '' 
   AND SD2.D2_ITEMORI <> ''
) SD1
 WHERE SD2010.R_E_C_N_O_ = SD1.R_E_C_N_O_;  

USE ZT8HTG_LAB;

SELECT COUNT(*) FROM SB6010;

lab: 5364
prd: 5499

-- 1. Produto 11.32
select B6_IDENT, B6_IDENTB6, B6_SALDO, * from SB6010 
 WHERE B6_PRODUTO = '11.32' and D_E_L_E_T_ = ' ';

SELECT D1_DOC, D1_SERIE, D1_FORNECE, D1_LOJA, D1_IDENTB6, D1_DTDIGIT, * 
  FROM SD1010 WHERE D1_COD = '11.32';

SELECT D2_DOC, D2_SERIE, D2_NFORI, D2_ITEMORI, D2_TIPO, D2_IDENTB6, D2_DTDIGIT, * 
  FROM SD2010 WHERE D2_COD = '11.32';
  
-- Update independente do Tipo
UPDATE SD2010
   SET D2_IDENTB6 = SD1.D1_IDENTB6
  FROM (
  SELECT SD1.D1_IDENTB6, SD2.R_E_C_N_O_
  FROM SD2010 SD2
  JOIN SD1010 SD1 ON SD1.D1_FILIAL = SD2.D2_FILIAL AND SD1.D1_DOC = SD2.D2_NFORI 
   AND SD1.D1_SERIE = SD2.D2_SERIORI AND SD1.D1_FORNECE = SD2.D2_CLIENTE AND SD1.D1_LOJA = SD2.D2_LOJA
   AND SD1.D1_ITEM = SD2.D2_ITEMORI AND SD1.D1_IDENTB6 <> ''
  JOIN SF4010 SF4 ON SF4.F4_FILIAL = '01' AND SF4.D_E_L_E_T_ = ' ' AND SF4.F4_CODIGO = SD2.D2_TES 
   AND SF4.F4_PODER3 IN ('R', 'D')
 WHERE SD2.D2_FILIAL = '01' AND SD2.D2_IDENTB6 = '' AND SD2.D2_NFORI <> ''  AND SD2.D2_ITEMORI <> ''
) SD1
 WHERE SD2010.R_E_C_N_O_ = SD1.R_E_C_N_O_;

SELECT SD2.D2_NFORI, SD2.D2_SERIORI, SD2.D2_CLIENTE, SD2.D2_LOJA, SD2.D2_ITEMORI, SD2.* 
  FROM SD2010 SD2
  JOIN SF4010 SF4 ON SF4.F4_FILIAL = '01' AND SF4.D_E_L_E_T_ = ' ' AND SF4.F4_CODIGO = SD2.D2_TES 
   AND SF4.F4_PODER3 IN ('R', 'D')
 WHERE SD2.D2_FILIAL = '01' AND SD2.D2_IDENTB6 = '' AND SD2.D2_NFORI <> '' AND SD2.D2_ITEMORI <> ''
   AND SD2.D_E_L_E_T_ = ' ';
   
SELECT * FROM SB2010 WHERE B2_COD = '152154-1';   

SELECT D1_DOC, D1_FORNECE, * FROM SD1010 WHERE D1_COD = '152154-1';

-- 12/04/2012
SELECT SF4.F4_PODER3, SF4.F4_ESTOQUE, SD2.D2_NFORI, SD2.D2_SERIORI, SD2.D2_CLIENTE, SD2.D2_LOJA, 
       SD2.D2_ITEMORI, SD2.* 
  FROM SD2010 SD2
  JOIN SF4010 SF4 ON SF4.F4_FILIAL = '01' AND SF4.D_E_L_E_T_ = ' ' AND SF4.F4_CODIGO = SD2.D2_TES 
   AND SF4.F4_PODER3 IN ('R', 'D')
 WHERE SD2.D2_FILIAL = '01' AND SD2.D2_IDENTB6 = '' AND SD2.D2_NFORI <> '' AND SD2.D2_ITEMORI <> ''
   AND SD2.D2_DOC = '000003602' AND SD2.D_E_L_E_T_ = ' ';

SELECT D2_IDENTB6, D2_ITEMORI, * FROM SD2010 WHERE D2_DOC = '000003602';

SELECT D1_QUANT, * FROM SD1010 WHERE D1_COD = '00483';
SELECT D2_IDENTB6, D2_DOC, D2_NFORI, D2_SERIORI, D2_ITEMORI, * FROM SD2010 WHERE D2_COD = '00483';

SELECT SUM(D2_QUANT) FROM SD2010 WHERE D2_COD = '00483';

SELECT * FROM SB2010 WHERE B2_COD = '00483';
SELECT * FROM SB6010 WHERE B6_PRODUTO = '00483' AND D_E_L_E_T_ = ' ';

SELECT SB6.*,R_E_C_N_O_ SB6RECNO FROM SB6010 SB6 WHERE SB6.B6_FILIAL='01' AND SB6.B6_IDENT = '      ' AND SB6.B6_PRODUTO = '00483          ' AND SB6.B6_SALDO > 0 AND SB6.B6_PODER3 = 'R' AND SB6.D_E_L_E_T_=' ' ORDER BY B6_FILIAL,B6_IDENT,B6_PRODUTO,B6_PODER3

 SELECT SD1.D1_IDENTB6, SD2.R_E_C_N_O_
  FROM SD2010 SD2
  JOIN SD1010 SD1 ON SD1.D1_FILIAL = SD2.D2_FILIAL AND SD1.D1_DOC = SD2.D2_NFORI 
   AND SD1.D1_SERIE = SD2.D2_SERIORI AND SD1.D1_FORNECE = SD2.D2_CLIENTE AND SD1.D1_LOJA = SD2.D2_LOJA
   AND SD1.D1_ITEM = SD2.D2_ITEMORI AND SD1.D1_IDENTB6 <> ''
  JOIN SF4010 SF4 ON SF4.F4_FILIAL = '01' AND SF4.D_E_L_E_T_ = ' ' AND SF4.F4_CODIGO = SD2.D2_TES 
   AND SF4.F4_PODER3 IN ('R', 'D')
 WHERE SD2.D2_FILIAL = '01' AND SD2.D2_IDENTB6 = '' AND SD2.D2_NFORI <> ''  AND SD2.D2_ITEMORI <> ''
   AND SD2.D2_COD = '00483';
   
UPDATE SD2010
   SET D2_IDENTB6 = SD1.D1_IDENTB6
  FROM (
  SELECT SD1.D1_IDENTB6, SD2.R_E_C_N_O_
  FROM SD2010 SD2
  JOIN SD1010 SD1 ON SD1.D1_FILIAL = SD2.D2_FILIAL AND SD1.D1_DOC = SD2.D2_NFORI 
   AND SD1.D1_SERIE = SD2.D2_SERIORI AND SD1.D1_FORNECE = SD2.D2_CLIENTE AND SD1.D1_LOJA = SD2.D2_LOJA
   AND SD1.D1_ITEM = SD2.D2_ITEMORI AND SD1.D1_IDENTB6 <> ''
  JOIN SF4010 SF4 ON SF4.F4_FILIAL = '01' AND SF4.D_E_L_E_T_ = ' ' AND SF4.F4_CODIGO = SD2.D2_TES 
   AND SF4.F4_PODER3 IN ('R', 'D')
 WHERE SD2.D2_FILIAL = '01' AND SD2.D2_IDENTB6 = '' AND SD2.D2_NFORI <> ''  AND SD2.D2_ITEMORI <> ''
) SD1
 WHERE SD2010.R_E_C_N_O_ = SD1.R_E_C_N_O_;   
 
 SELECT SD2.* 
  FROM SD2010 SD2
  JOIN SD1010 SD1 ON SD1.D1_FILIAL = SD2.D2_FILIAL AND SD1.D1_DOC = SD2.D2_NFORI 
   AND SD1.D1_SERIE = SD2.D2_SERIORI AND SD1.D1_FORNECE = SD2.D2_CLIENTE AND SD1.D1_LOJA = SD2.D2_LOJA
   AND SD1.D1_ITEM = SD2.D2_ITEMORI AND SD1.D1_IDENTB6 <> ''
  JOIN SF4010 SF4 ON SF4.F4_FILIAL = '01' AND SF4.D_E_L_E_T_ = ' ' AND SF4.F4_CODIGO = SD2.D2_TES 
   AND SF4.F4_PODER3 IN ('R', 'D')
 WHERE SD2.D2_FILIAL = '01' AND SD2.D2_IDENTB6 = '' AND SD2.D2_NFORI <> ''  AND SD2.D2_ITEMORI <> ''
 
-- B6 em Duplicidade
SELECT B6_TIPO, B6_TPCF, B6_DOC, B6_SERIE, * FROM SB6010 WHERE B6_PRODUTO = '0.101.000.021';

SELECT D_E_L_E_T_, D1_FORNECE, D1_DOC, D_E_L_E_T_, D1_EMISSAO, D1_DTDIGIT, D1_TES, * 
  FROM SD1010 WHERE D1_DOC IN ('001503', '059530') 
   AND D1_COD = '0.101.000.021';

SELECT D_E_L_E_T_,* FROM SF1010 WHERE F1_DOC IN ('001503', '059530');

SELECT D_E_L_E_T_, D2_DOC, D_E_L_E_T_, D2_EMISSAO, D2_DTDIGIT, D2_TES, * 
  FROM SD2010 WHERE D2_DOC IN ('001503', '059530') 
   AND D2_COD = '0.101.000.021';   
   
D2_CLIENTE = '000031' AND    
   
D1_FORNECE = '000031' AND    