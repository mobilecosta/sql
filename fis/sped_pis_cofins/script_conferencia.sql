-- Base a partir de CFOP - 
SELECT SUM(FT_BASEPIS) AS FT_BASEPIS, SUM(FT_VALPIS) AS FT_VALPIS
  FROM
( 
SELECT FT_CFOP, SUM(FT_BASEPIS) AS FT_BASEPIS, SUM(FT_VALPIS) AS FT_VALPIS FROM SFT010
 where D_E_L_E_T_ = ' ' and FT_FILIAL = '01' and FT_ENTRADA between '20120801' and '20120831'
   and FT_BASEPIS > 0 and left(FT_CFOP, 1) >= '5'
   and FT_DTCANC = '' and FT_CODISS = ''
 GROUP BY FT_CFOP
-- ORDER BY FT_CFOP
) IMP 

select SUM(FT_BASEPIS) AS FT_BASEPIS, SUM(FT_VALPIS) AS FT_VALPIS from SFT010
 where D_E_L_E_T_ = ' ' and FT_FILIAL = '01' and FT_ENTRADA between '20120801' and '20120831'
   and FT_DTCANC = ''
   and FT_CODISS <> '';

SELECT FT_BASEPIS, FT_ALIQPIS, FT_VALPIS, * 
  FROM SFT010 WHERE FT_NFISCAL IN ('000006011', '000006012', '000006013', '000006014');