SELECT N1_CHAPA, * FROM SN1010 WHERE D_E_L_E_T_ = ' ' AND N1_NFISCAL LIKE '%50381%';

-- Chapas Integradas
SELECT SD1.D1_DTDIGIT AS DATA, SD1.D1_DOC AS NOTA, SD1.D1_ITEM AS ITEM, SD1.D1_XCHAPA AS CHAPA_NOTA, 
       SN1.N1_CHAPA AS CHAPA_ATIVO, SD1.R_E_C_N_O_ AS D1_RECNO, SN1.R_E_C_N_O_  AS N1_RECNO
  FROM SD1010 SD1
  LEFT JOIN SN1010 SN1 ON SN1.D_E_L_E_T_ = ' ' AND SN1.N1_NFISCAL = SD1.D1_DOC AND SN1.N1_ITEM = SD1.D1_ITEM
 WHERE SD1.D_E_L_E_T_ = ' ' AND SD1.D1_XCHAPA <> '' AND SD1.D1_XCHAPA <> '0' 
   AND COALESCE(SN1.N1_CHAPA, '') <> ''
 ORDER BY SD1.R_E_C_N_O_;

SELECT SD1.D1_DOC, SD1.D1_ITEM, SD1.D1_XCHAPA, SD1.R_E_C_N_O_ 
  FROM SD1010 SD1
 WHERE SD1.D_E_L_E_T_ = ' ' AND SD1.D1_XCHAPA <> '' AND SD1.D1_XCHAPA <> '0' 
 ORDER BY SD1.R_E_C_N_O_;
 
-- Chapas n�o Integradas
SELECT SD1.D1_DTDIGIT, SD1.D1_DOC, SD1.D1_ITEM, SD1.D1_XCHAPA, SN1.N1_CHAPA, SD1.R_E_C_N_O_ AS D1_RECNO, 
       SN1.R_E_C_N_O_ AS N1_RECNO
  FROM SD1010 SD1
  JOIN SN1010 SN1 ON SN1.D_E_L_E_T_ = ' ' AND SN1.N1_NFISCAL = SD1.D1_DOC AND SN1.N1_ITEM = SD1.D1_ITEM
 WHERE SD1.D_E_L_E_T_ = ' ' AND SD1.D1_XCHAPA <> '' AND SD1.D1_XCHAPA <> '0' 
   AND COALESCE(SN1.N1_CHAPA, '') = ''
 ORDER BY SD1.R_E_C_N_O_; 

-- Update 
UPDATE SN1010
   SET N1_CHAPA = SD1.D1_XCHAPA
  FROM (   
SELECT SD1.D1_DTDIGIT, SD1.D1_DOC, SD1.D1_ITEM, SD1.D1_XCHAPA, SN1.N1_CHAPA, SD1.R_E_C_N_O_ AS D1_RECNO, 
       SN1.R_E_C_N_O_ AS N1_RECNO
  FROM SD1010 SD1
  JOIN SN1010 SN1 ON SN1.D_E_L_E_T_ = ' ' AND SN1.N1_NFISCAL = SD1.D1_DOC AND SN1.N1_ITEM = SD1.D1_ITEM
 WHERE SD1.D_E_L_E_T_ = ' ' AND SD1.D1_XCHAPA <> '' AND SD1.D1_XCHAPA <> '0' 
   AND COALESCE(SN1.N1_CHAPA, '') = '') SD1
 WHERE SN1010.R_E_C_N_O_ = SD1.N1_RECNO;
 
SELECT SD1.D1_DTDIGIT AS DATA, SD1.D1_DOC AS NOTA, SD1.D1_ITEM AS ITEM, SD1.D1_XCHAPA AS NOTA, 
       SN1.N1_CHAPA AS ATIVO
  FROM SD1010 SD1
  LEFT JOIN SN1010 SN1 ON SN1.D_E_L_E_T_ = ' ' AND SN1.N1_NFISCAL = SD1.D1_DOC AND SN1.N1_ITEM = SD1.D1_ITEM
 WHERE SD1.D_E_L_E_T_ = ' ' AND SD1.D1_XCHAPA <> '' AND SD1.D1_XCHAPA <> '0' 
   AND COALESCE(SN1.N1_CHAPA, '') <> ''
 ORDER BY SD1.R_E_C_N_O_;
 