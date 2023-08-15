-- Update independente do Tipo
UPDATE SD1010
   SET D1_IDENTB6 = SD2.D2_IDENTB6
  FROM (
  SELECT SD2.D2_IDENTB6, SD1.R_E_C_N_O_
  FROM SD1010 SD1
  JOIN SD2010 SD2 ON SD2.D2_FILIAL = SD1.D1_FILIAL AND SD2.D2_DOC = SD1.D1_NFORI 
   AND SD2.D2_SERIE = SD1.D1_SERIORI AND SD2.D2_ITEM = SD1.D1_ITEMORI AND SD2.D2_IDENTB6 <> ''
  JOIN SF4010 SF4 ON SF4.F4_FILIAL = '01' AND SF4.D_E_L_E_T_ = ' ' AND SF4.F4_CODIGO = SD1.D1_TES 
   AND SF4.F4_PODER3 IN ('R', 'D')
 WHERE SD1.D1_FILIAL = '01' AND SD1.D1_IDENTB6 = '' AND SD1.D1_NFORI <> ''  AND SD1.D1_ITEMORI <> ''
) SD2
 WHERE SD1010.R_E_C_N_O_ = SD2.R_E_C_N_O_;

--
SELECT * FROM SB6010
WHERE B6_PRODUTO = '149178-3' AND B6_CLIFOR = '000037';

SELECT D2_IDENTB6, D_E_L_E_T_, * FROM SD2010
WHERE D2_COD = '149178-3' AND D2_CLIENTE = '000037';

SELECT D_E_L_E_T_, * FROM SD1010
WHERE D1_COD = '149178-3' AND D1_FORNECE = '000037';

SELECT SUM(D1_QUANT) FROM SD1010
WHERE D_E_L_E_T_ = ' ' AND D1_COD = '149178-3' AND D1_IDENTB6 <> '';


SELECT SUM(D2_QUANT) FROM SD2010
WHERE D_E_L_E_T_ = ' ' AND D2_COD = '149178-3' AND D2_IDENTB6 <> '';


SELECT * FROM SB2010 WHERE B2_COD = '149178-3'

SELECT * FROM SB2010 WHERE B2_QTER < 0

SELECT * FROM SB6010 WHERE B6_DOC = '000002887';

-- 2887
SELECT D2_SERIE, D2_DOC, D2_ITEM, * FROM SD2010 WHERE D2_DOC = '000002887' AND D_E_L_E_T_ = ' ';

SELECT SD1.*,SF4.F4_PODER3 
FROM SD1010 SD1, SF4010 SF4 
WHERE SD1.D1_FILIAL='01' AND SD1.D_E_L_E_T_=' ' AND SF4.F4_FILIAL='01' AND SF4.F4_CODIGO=SD1.D1_TES AND 
SF4.F4_PODER3='D' AND SF4.D_E_L_E_T_=' ' and SD1.D1_DOC = '000230224'
ORDER BY D1_FILIAL,D1_COD,D1_LOCAL 


-- 01. 000230224
UPDATE SD1010 
   SET D1_SERIORI = '2', D1_NFORI = '000002887', 
       D1_ITEMORI = CASE WHEN D1_COD = 'DIMN.6310.01.MP' THEN '01' ELSE '02' END
 WHERE D1_DOC = '000230224';
   
SELECT D1_SERIORI, D1_NFORI, D1_ITEMORI, D1_COD, D1_IDENTB6, D1_TES
 FROM SD1010 
 WHERE D1_DOC = '000230224';

-- 000002977
SELECT D2_SERIE, D2_DOC, D2_ITEM, * FROM SD2010 WHERE D2_DOC = '000002977' AND D_E_L_E_T_ = ' ';

-- 02. 000230225
UPDATE SD1010 
   SET D1_SERIORI = '2', D1_NFORI = '000002977', 
       D1_ITEMORI = CASE WHEN D1_COD = 'DIMN.6310.03.MP' THEN '01' ELSE '02' END
 WHERE D1_DOC = '000230225';
   
SELECT D1_SERIORI, D1_NFORI, D1_ITEMORI, D1_COD
 FROM SD1010 
 WHERE D1_DOC = '000230225';

-- 03. 000002978
SELECT D2_SERIE, D2_DOC, D2_ITEM, * FROM SD2010 WHERE D2_DOC = '000002978' AND D_E_L_E_T_ = ' ';

UPDATE SD1010 
   SET D1_SERIORI = '2', D1_NFORI = '000002978', 
       D1_ITEMORI = CASE WHEN D1_COD = 'DIMN.6310.06.MP' THEN '01' ELSE '02' END
 WHERE D1_DOC = '000230220';
   
SELECT D1_SERIORI, D1_NFORI, D1_ITEMORI, D1_COD
 FROM SD1010 
 WHERE D1_DOC = '000230220';

-- 04. 000003021
SELECT D2_SERIE, D2_DOC, D2_ITEM, * FROM SD2010 WHERE D2_DOC = '000003021' AND D_E_L_E_T_ = ' ';

UPDATE SD1010 
   SET D1_SERIORI = '2', D1_NFORI = '000003021', 
       D1_ITEMORI = CASE WHEN D1_COD = 'DIMN.6310.06.MP' THEN '01' ELSE '02' END
 WHERE D1_DOC = '000230222';
   
SELECT D1_SERIORI, D1_NFORI, D1_ITEMORI, D1_COD
 FROM SD1010 
 WHERE D1_DOC = '000230222';

-- 05. 000003022
SELECT D2_SERIE, D2_DOC, D2_ITEM, * FROM SD2010 WHERE D2_DOC = '000003022' AND D_E_L_E_T_ = ' ';

UPDATE SD1010 
   SET D1_SERIORI = '2', D1_NFORI = '000003022', D1_ITEMORI = '01' 
 WHERE D1_DOC = '000230221';
   
SELECT D1_SERIORI, D1_NFORI, D1_ITEMORI, D1_COD
 FROM SD1010 
 WHERE D1_DOC = '000230221';

-- 06. 000003023
SELECT D2_SERIE, D2_DOC, D2_ITEM, * FROM SD2010 WHERE D2_DOC = '000003023' AND D_E_L_E_T_ = ' ';

UPDATE SD1010 
   SET D1_SERIORI = '2', D1_NFORI = '000003023', D1_ITEMORI = '01' 
 WHERE D1_DOC = '000230226';
   
SELECT D1_SERIORI, D1_NFORI, D1_ITEMORI, D1_COD
 FROM SD1010 
 WHERE D1_DOC = '000230226';

-- 07. 000003058
SELECT D2_SERIE, D2_DOC, D2_ITEM, * FROM SD2010 WHERE D2_DOC = '000003058' AND D_E_L_E_T_ = ' ';

UPDATE SD1010 
   SET D1_SERIORI = '2', D1_NFORI = '000003058', D1_ITEMORI = '01' 
 WHERE D1_DOC = '000230223';
   
SELECT D1_SERIORI, D1_NFORI, D1_ITEMORI, D1_COD
 FROM SD1010 
 WHERE D1_DOC = '000230223';

-- 08. 006608
SELECT D1_SERIE, D1_DOC, D1_ITEM, * FROM SD1010 WHERE D1_DOC = '006608' AND D_E_L_E_T_ = ' ';

UPDATE SD2010 
   SET D2_NFORI = '006608', D2_ITEMORI = '01' 
 WHERE D2_DOC = '001779' AND D2_COD = '20890' AND D_E_L_E_T_  = ' ';
   
SELECT D2_SERIORI, D2_NFORI, D2_ITEMORI, D2_COD
 FROM SD2010 
 WHERE D2_DOC = '001779' AND D2_COD = '20890' AND D_E_L_E_T_  = ' ';

-- 09. 000192
SELECT D1_SERIE, D1_DOC, D1_ITEM, * FROM SD1010 
 WHERE D1_DOC = '000192' AND D_E_L_E_T_ = ' ' AND D1_COD = 'FONTE FRONIUS I';

UPDATE SD2010 
   SET D2_NFORI = '000192', D2_ITEMORI = '01' 
 WHERE D2_DOC = '001781' AND D2_COD = 'FONTE FRONIUS I' AND D_E_L_E_T_  = ' ';
   
SELECT D2_SERIORI, D2_NFORI, D2_ITEMORI, D2_COD
 FROM SD2010 
 WHERE D2_DOC = '001781' AND D2_COD = 'FONTE FRONIUS I' AND D_E_L_E_T_  = ' ';

-- 10. 000192
SELECT D1_SERIE, D1_DOC, D1_ITEM, * FROM SD1010 
 WHERE D1_DOC = '031319' AND D_E_L_E_T_ = ' ' AND D1_COD = 'SI50MNC19';

UPDATE SD2010 
   SET D2_SERIORI = '6', D2_NFORI = '031319', D2_ITEMORI = '0001' 
 WHERE D2_FILIAL = '01' AND D2_DOC = '000493' AND D2_COD = 'SI50MNC19' AND D_E_L_E_T_  = ' ';
   
SELECT D2_SERIORI, D2_NFORI, D2_ITEMORI, D2_COD, *
 FROM SD2010 
 WHERE D2_FILIAL = '01' AND D2_DOC = '000493' AND D2_COD = 'SI50MNC19' AND D_E_L_E_T_  = ' ';

-- 10. 000038
SELECT D1_SERIE, D1_DOC, D1_ITEM, * FROM SD1010 
 WHERE D1_DOC = '000038' AND D_E_L_E_T_ = ' ' AND D1_COD = 'SIST DVT';

UPDATE SD2010 
   SET D2_NFORI = '000038', D2_ITEMORI = '0001' 
 WHERE D2_FILIAL = '01' AND D2_DOC = '001949' AND D2_COD = 'SIST DVT' AND D_E_L_E_T_  = ' ';
   
SELECT D2_SERIORI, D2_NFORI, D2_ITEMORI, D2_COD, *
 FROM SD2010 
 WHERE D2_FILIAL = '01' AND D2_DOC = '001949' AND D2_COD = 'SIST DVT' AND D_E_L_E_T_  = ' ';

