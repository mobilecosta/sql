SELECT D1_NFORI, D1_SERIORI, D1_ITEMORI,  * FROM SD1010 
 WHERE D_E_L_E_T_ = ' ' AND D1_TES = '314' AND D1_IDENTB6 = '';

SELECT D2_TES, D2_IDENTB6, * FROM SD2010 WHERE D2_DOC in ('000004059','000002976');

SELECT F4_PODER3, * FROM SF4010 WHERE F4_CODIGO = '815';

SELECT B6_IDENT, B6_IDENTB6, * FROM SB6010 WHERE D_E_L_E_T_ = ' ' AND B6_DOC in ('000004059','000002976');

UPDATE SB6010 SET D_E_L_E_T_ = '*' WHERE B6_DOC in ('000004059','000002976');

UPDATE SD2010 
   SET D2_IDENTB6 = (SELECT B6_IDENTB6 FROM SB6010 WHERE D_E_L_E_T_ = ' ' 
                        AND B6_DOC = SD2010.D2_DOC AND B6_SERIE = SD2010.D2_SERIE
                        AND B6_PRODUTO = SD2010.D2_COD)
 WHERE D2_DOC in ('000004059','000002976');

SELECT D2_NUMSEQ, D2_IDENTB6, * FROM SD2010
 WHERE D2_DOC in ('000004059','000002976');


SELECT (SELECT B6_IDENTB6 FROM SB6010 WHERE D_E_L_E_T_ = ' ' 
                        AND B6_DOC = SD2010.D2_DOC AND B6_SERIE = SD2010.D2_SERIE
                        AND B6_PRODUTO = SD2010.D2_COD), * FROM SD2010 
 WHERE D2_DOC in ('000004059','000002976');

SELECT B6_SERIE, B6_DOC, B6_IDENTB6, * 
  FROM SB6010 
 WHERE D_E_L_E_T_ = ' ' AND B6_PRODUTO = '150289-8';
  
SELECT D2_SERIE, D2_DOC, D2_PEDIDO, D2_EMISSAO, * FROM SD2010 
 WHERE D_E_L_E_T_ = ' ' 
   AND D2_DOC = '000004059' AND D2_COD = '150289-8';

SELECT C6_IDENTB6, * FROM SC6010 
 WHERE C6_NUM = '004395' AND C6_PRODUTO = '150289-8';

SELECT C6_IDENTB6, * FROM SC6010 WHERE C6_IDENTB6 <> ''
 ORDER BY C6_NUM;
 
SELECT F4_PODER3 FROM SF4010 WHERE F4_CODIGO = '815'; 

UPDATE SF4010 SET F4_PODER3 = 'R' WHERE F4_CODIGO = '815'; 

-- Teste
SELECT C6_IDENTB6, * FROM SC6010 
 WHERE C6_NUM = '005092' AND C6_PRODUTO = '150289-8';

SELECT D2_IDENTB6, D2_NUMSEQ, * FROM SD2010 
 WHERE D2_PEDIDO = '005092' AND D2_COD = '150289-8';

SELECT MAX(D3_NUMSEQ) FROM SD3010;

-- Corre��o
UPDATE SD2010 SET D2_IDENTB6 = D2_NUMSEQ
 WHERE D2_DOC in ('000004059','000002976');

-- Tes 715
SELECT * FROM SD2010 WHERE D2_TES = '715' AND D2_IDENTB6 <> '';

SELECT D2_DOC, D2_SERIE, D2_ITEM, D2_NUMSEQ, * 
  FROM SD2010 
 WHERE D2_TES = '715' AND D2_IDENTB6 = '' AND D2_FILIAL = '01';
 
-- Tes de entrada sem identificador de terceiros
SELECT SD1.D1_TES, SD1.D1_COD, SD1.* 
  FROM SD1010 SD1
  JOIN SF4010 SF4 ON SF4.D_E_L_E_T_ = ' ' AND SF4.F4_FILIAL = SD1.D1_FILIAL AND SF4.F4_CODIGO = SD1.D1_TES
   AND SF4.F4_PODER3 IN ('R', 'D')
 WHERE SD1.D1_IDENTB6 = ''
 ORDER BY SD1.D1_TES, SD1.D1_COD;
 
UPDATE SD1010
   SET D1_IDENTB6 = D1_NUMSEQ
 WHERE R_E_C_N_O_ IN
(
SELECT SD1.R_E_C_N_O_
  FROM SD1010 SD1
  JOIN SF4010 SF4 ON SF4.D_E_L_E_T_ = ' ' AND SF4.F4_FILIAL = SD1.D1_FILIAL AND SF4.F4_CODIGO = SD1.D1_TES
   AND SF4.F4_PODER3 IN ('R', 'D')
 WHERE SD1.D1_IDENTB6 = ''
);

-- Tes de sa�da sem identificador de terceiros
SELECT SD2.D2_TES, SD2.D2_COD, SD2.* 
  FROM SD2010 SD2
  JOIN SF4010 SF4 ON SF4.D_E_L_E_T_ = ' ' AND SF4.F4_FILIAL = SD2.D2_FILIAL AND SF4.F4_CODIGO = SD2.D2_TES
   AND SF4.F4_PODER3 IN ('R', 'D')
 WHERE SD2.D2_IDENTB6 = ''
 ORDER BY SD2.D2_TES, SD2.D2_COD;

UPDATE SD2010
   SET D2_IDENTB6 = D2_NUMSEQ
 WHERE R_E_C_N_O_ IN
(
SELECT SD2.R_E_C_N_O_
  FROM SD2010 SD2
  JOIN SF4010 SF4 ON SF4.D_E_L_E_T_ = ' ' AND SF4.F4_FILIAL = SD2.D2_FILIAL AND SF4.F4_CODIGO = SD2.D2_TES
   AND SF4.F4_PODER3 IN ('R', 'D')
 WHERE SD2.D2_IDENTB6 = ''
); 

-- Preenche identificador SB6
UPDATE SD1010
   SET D1_IDENTB6 = SD2.D2_IDENTB6
  FROM (
SELECT SD2.D2_IDENTB6, SD1.R_E_C_N_O_
  FROM SD1010 SD1
  JOIN SD2010 SD2 ON SD2.D2_FILIAL = SD1.D1_FILIAL AND SD2.D2_DOC = SD1.D1_NFORI 
   AND SD2.D2_SERIE = SD1.D1_SERIORI AND SD2.D2_CLIENTE = SD1.D1_FORNECE AND SD2.D2_LOJA = SD1.D1_LOJA
   AND SD2.D2_ITEM = SD1.D1_ITEMORI AND SD2.D2_IDENTB6 <> ''
 WHERE SD1.D1_FILIAL = '01' AND SD1.D1_IDENTB6 = '' AND SD1.D1_NFORI <> '' AND SD1.D1_ITEMORI <> ''
) SD2
 WHERE SD1010.R_E_C_N_O_ = SD2.R_E_C_N_O_;
 
UPDATE SD2010
   SET D2_IDENTB6 = SD1.D1_IDENTB6
  FROM (
  SELECT SD1.D1_IDENTB6, SD2.R_E_C_N_O_
  FROM SD2010 SD2
  JOIN SD1010 SD1 ON SD1.D1_FILIAL = SD2.D2_FILIAL AND SD1.D1_DOC = SD2.D2_NFORI 
   AND SD1.D1_SERIE = SD2.D2_SERIORI AND SD1.D1_FORNECE = SD2.D2_CLIENTE AND SD1.D1_LOJA = SD2.D2_LOJA
   AND SD1.D1_ITEM = SD2.D2_ITEMORI AND SD1.D1_IDENTB6 <> ''
 WHERE SD2.D2_FILIAL = '01' AND SD2.D2_IDENTB6 = '' AND SD2.D2_NFORI <> ''  AND SD2.D2_ITEMORI <> ''
) SD1
 WHERE SD2010.R_E_C_N_O_ = SD1.R_E_C_N_O_; 
 
-- Verifica��o
SELECT D1_IDENTB6, D1_DOC, D1_SERIE, D1_ITEM, D1_FORNECE, D1_LOJA, * 
  FROM SD1010 WHERE D1_DOC = '011972' AND D1_COD = 'CADEIRA TRAPEZI'; 
  
SELECT D2_NFORI, D2_SERIORI, D2_ITEMORI, * FROM SD2010 
 WHERE D2_NFORI = '011972';


SELECT D1_IDENTB6, * FROM SD1010 WHERE D1_COD = 'CADEIRA TRAPEZI'; 
SELECT D2_IDENTB6, D2_NUMSEQ, * FROM SD2010 WHERE D2_COD = 'CADEIRA TRAPEZI'; 
SELECT * FROM SB6010 WHERE B6_PRODUTO = 'CADEIRA TRAPEZI'; 

-- Sa�das
SELECT D2_NFORI, D2_SERIORI, D2_COD, D2_CLIENTE, D2_LOJA, * FROM SD2010 SD2
 WHERE D_E_L_E_T_ = ' ' AND D2_NFORI <> '' AND D2_ITEMORI = '' AND D2_QUANT > 0
   AND EXISTS(SELECT D1_ITEM FROM SD1010 WHERE D_E_L_E_T_ = ' ' AND D1_FILIAL = '01' AND D1_DOC = SD2010.D2_NFORI 
                 AND D1_SERIE = SD2010.D2_SERIORI AND D1_FORNECE = SD2010.D2_CLIENTE AND D1_LOJA = SD2010.D2_LOJA
                 AND D1_COD = SD2010.D2_COD);

SELECT * FROM SD1010 
 WHERE D1_DOC = '002022' AND D1_SERIE = '' AND D1_COD = '149671-2' AND D1_FORNECE = '005400' AND D1_LOJA = '01';

SELECT * FROM SD2010 
 WHERE D_E_L_E_T_ = ' ' AND D2_NFORI <> '' AND D2_ITEMORI = '' AND D2_QUANT > 0;
 
-- Entradas
SELECT * FROM SD1010 
 WHERE D_E_L_E_T_ = ' ' AND D1_NFORI <> '' AND D1_ITEMORI = '' AND D1_QUANT > 0;
 
-- 01. Corrige Identificador e n�mero do item original
UPDATE SD2010
   SET D2_IDENTB6 = SD1.D1_IDENTB6, D2_ITEMORI = SD1.D1_ITEM
  FROM (
SELECT SD1.D1_IDENTB6, SD1.D1_ITEM, SD2.R_E_C_N_O_
  FROM SD2010 SD2
  JOIN SF4010 SF4 ON SF4.D_E_L_E_T_ = ' ' AND SF4.F4_FILIAL = SD2.D2_FILIAL AND SF4.F4_CODIGO = SD2.D2_TES
   AND SF4.F4_PODER3 = 'D'
  JOIN SD1010 SD1 ON SD1.D_E_L_E_T_ = ' ' AND SD1.D1_FILIAL = SD2.D2_FILIAL AND SD1.D1_DOC = SD2.D2_NFORI 
   AND SD1.D1_SERIE = SD2.D2_SERIORI AND SD1.D1_FORNECE = SD2.D2_CLIENTE AND SD1.D1_LOJA = SD2.D2_LOJA
   AND SD1.D1_COD = SD2.D2_COD
 WHERE SD2.D_E_L_E_T_ = ' ' AND SD2.D2_IDENTB6 <> '' AND SD2.D2_IDENTB6 = SD2.D2_NUMSEQ AND SD2.D2_ITEMORI <> ''
) SD1
 WHERE SD2010.R_E_C_N_O_ = SD1.R_E_C_N_O_; 
 
-- 02. Gerar nova TES (715 para 830)
UPDATE SD2010 SET D2_TES = '830' WHERE D2_COD = 'FONTE FRONIUS I';

-- 03. Gerar nova TES (778 para 831)
UPDATE SD2010 SET D2_TES = '831' WHERE D_E_L_E_T_ = ' ' AND D2_COD = 'SUP MERCEDES';

-- 04. Gerar nova TES (799 para 832)
UPDATE SD2010 SET D2_TES = '832' WHERE D_E_L_E_T_ = ' ' AND D2_COD = 'DISP PNEUMATICO';

-- 05. Gerar nova TES (717 para 833)
SELECT * FROM SD2010 WHERE D_E_L_E_T_ = ' ' AND D2_COD = '5D0391';
UPDATE SD2010 SET D2_TES = '833' WHERE D_E_L_E_T_ = ' ' AND D2_COD = '5D0391';

-- 06. Gerar nova TES (717 para 833)
SELECT * FROM SD2010 WHERE D_E_L_E_T_ = ' ' AND D2_COD = '5P0112';
UPDATE SD2010 SET D2_TES = '833' WHERE D_E_L_E_T_ = ' ' AND D2_COD = '5P0112';

-- 07. Gerar nova TES (715 para 834)
SELECT D2_EMISSAO, D2_NFORI, * FROM SD2010 WHERE D_E_L_E_T_ = ' ' AND D2_COD = '4565' AND D2_EMISSAO = '20100423';
UPDATE SD2010 SET D2_TES = '834' WHERE D_E_L_E_T_ = ' ' AND D2_COD = '4565' AND D2_EMISSAO = '20100423';