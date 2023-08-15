SELECT D1_DTDIGIT, D1_FORNECE, D1_DOC, D1_SERIE, D1_ITEM, D1_BASIMP5, D1_ALQIMP5, D1_VALIMP5, 
       D1_BASIMP6, D1_ALQIMP6, D1_VALIMP6, * 
  FROM SD1010 WHERE D_E_L_E_T_ = ' ' and D1_DTDIGIT between '20120201' and '20120229' 
   and D1_TES = '135'
   order by D1_FORNECE, D1_DOC, D1_SERIE, D1_ITEM;
   
--
SELECT R_E_C_N_O_, D_E_L_E_T_, FT_BASEPIS, FT_ALIQPIS, FT_VALPIS, FT_BASECOF, FT_ALIQCOF, FT_VALCOF, * 
  FROM SFT010 
 WHERE D_E_L_E_T_ = ' ' AND FT_ENTRADA BETWEEN '20120201' and '20120229' 
 ORDER BY R_E_C_N_O_;
 
SELECT F1_STATUS, * FROM SF1010  WHERE F1_DOC = '000000495';

SELECT * FROM SF3010 WHERE D_E_L_E_T_ = ' ' AND F3_ENTRADA = '20120229' AND F3_NFISCAL = '000000495';

SELECT D_E_L_E_T_, * FROM SF3010 
 WHERE F3_ENTRADA = '20120229' AND F3_NFISCAL = '000000495' 
 ORDER BY R_E_C_N_O_;

-- Reprocessamento 
SELECT F1_DTDIGIT, *
  FROM SF1010
 WHERE D_E_L_E_T_ = ' ' AND F1_EMISSAO = '20120203';
 
SELECT D_E_L_E_T_, F3_REPROC, F3_BASEICM, F3_VALICM, * 
  FROM SF3010 WHERE F3_ENTRADA = '20120203' 
   AND F3_NFISCAL in ('000000001','000000002')
 ORDER BY R_E_C_N_O_; 

-- Corre��o da al�quota das notas e produto
UPDATE SD1010 
   SET D1_ALQIMP5 = 7.6, D1_VALIMP5 = ROUND(D1_BASIMP5 * 0.076, 2) , 
       D1_ALQIMP6 = 1.65, D1_VALIMP6 = ROUND(D1_BASIMP6 * 0.0165, 2)
 WHERE D_E_L_E_T_ = ' ' and D1_DTDIGIT between '20120201' and '20120229' and D1_TES = '135';

UPDATE SB1010 
   SET B1_PCOFINS = 0, B1_PPIS = 0
 WHERE D_E_L_E_T_ = ' ' AND B1_PCOFINS > 0 OR B1_PPIS > 0;