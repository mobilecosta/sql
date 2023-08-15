-- Valores das Saidas
SELECT SUM(D2_VALIMP5) AS D2_VALORCOF, SUM(D2_VALIMP6) AS D2_VALORPIS
  FROM SD2010
 WHERE D_E_L_E_T_ = ' ' AND D2_FILIAL = '01' AND D2_EMISSAO BETWEEN '20110901' AND '20110930';
 
-- Valores das Entradas
SELECT SUM(D1_VALIMP5) AS D1_VALORCOF, SUM(D1_VALIMP6) AS D1_VALORPIS
  FROM SD1010
 WHERE D_E_L_E_T_ = ' ' AND D1_FILIAL = '01' AND D1_EMISSAO BETWEEN '20110901' AND '20110930'; 
 
SELECT D1_VALIMP5, D1_VALIMP6, * FROM SD1010 WHERE D1_DOC = '000372664'; 

-- Somat�ria dos impostos
SELECT FT_CSTCOF, FT_CSTPIS, SUM(FT_BASEPIS) AS FT_BASEPIS, SUM(FT_VALPIS) AS FT_VALPIS,
       SUM(FT_BASECOF) AS FT_BASECOF, SUM(FT_VALCOF) AS FT_VALCOF
  FROM SFT010 WHERE D_E_L_E_T_ = ' ' AND FT_ENTRADA BETWEEN '20110901' AND '20110930'
 GROUP BY FT_CSTCOF, FT_CSTPIS
 
-- Verifica��es de campos na tabela SFT
SELECT FT_CODBCC, FT_INDNTFR,* FROM SFT010 WHERE FT_ENTRADA BETWEEN '20110901' AND '20110930';

-- Preenchimento com zero = FT_INDNTFR - Ver preenchimento correto
UPDATE SFT010 SET FT_INDNTFR = '0';

SELECT * FROM SF2010 WHERE F2_DOC = '000000624';
SELECT * FROM SF1010 WHERE F1_DOC = '000000624';

SELECT * FROM SF3010 WHERE F3_NFISCAL = '000000624';

SELECT * FROM SD2010 WHERE D2_DOC = '000000624';

SELECT * FROM SFT010 WHERE FT_NFISCAL = '000000624';

-- 
SELECT SUM(D2_TOTAL) AS D2_TOTAL
  FROM SD2010
 WHERE D_E_L_E_T_ = ' ' AND D2_FILIAL = '01' AND D2_EMISSAO BETWEEN '20120701' AND '20120731'
   AND D2_VALIMP6 > 0;

-- Base do Faturamento
SELECT SUM(FT_TOTAL) AS FT_TOTAL
  FROM (
SELECT FT_CSTCOF, FT_CSTPIS, SUM(FT_BASEPIS) AS FT_BASEPIS, SUM(FT_VALPIS) AS FT_VALPIS,
       SUM(FT_BASECOF) AS FT_BASECOF, SUM(FT_VALCOF) AS FT_VALCOF,
       SUM(CASE WHEN FT_CSTPIS IN ('01', '02', '03', '05') AND FT_DTCANC = ''
                THEN FT_TOTAL ELSE 0 END) AS FT_TOTAL
   FROM SFT010 
  WHERE D_E_L_E_T_ = ' ' AND FT_ENTRADA BETWEEN '20120701' AND '20120731'
    AND FT_DTCANC = '' AND FT_ESPECIE IN ('SPED', 'NFS')
 GROUP BY FT_CSTCOF, FT_CSTPIS
) AS FAT

-- DEVOLU��ES
SELECT SUM(FT_TOTAL)
  FROM SFT010
 WHERE D_E_L_E_T_ = ' ' AND FT_ENTRADA BETWEEN '20120701' AND '20120731'
   AND FT_TIPOMOV='E' AND FT_DTCANC='' AND FT_TIPO='D'

SELECT FT_TIPOMOV, *
  FROM SFT010
 WHERE D_E_L_E_T_ = ' ' AND FT_ENTRADA BETWEEN '20120701' AND '20120731'
   AND FT_TIPO='D';

-- Registro M210
SELECT SUM(FT_TOTAL) AS FT_TOTAL, SUM(FT_VALPIS) AS FT_VALPIS
  FROM (
SELECT FT_NFISCAL, SUM(FT_TOTAL) AS FT_TOTAL, SUM(FT_VALPIS) AS FT_VALPIS
  FROM SFT010
 WHERE D_E_L_E_T_ = ' ' AND FT_ENTRADA BETWEEN '20120701' AND '20120731'
   AND FT_DTCANC = '' AND FT_TIPOMOV = 'S'
   AND CASE WHEN FT_CSTPIS IN ('01', '02', '03', '05') AND FT_ALIQPIS > 0 OR FT_CSTPIS = '49' THEN '1' ELSE '0' END = '1'
   AND FT_ESPECIE = 'SPED'
 GROUP BY FT_NFISCAL
 ORDER BY FT_NFISCAL
) AS FAT

-- Corrige a especie da s�rie B
UPDATE SF2010
   SET F2_ESPECIE = 'NFS'
 WHERE F2_SERIE = 'B';

UPDATE SF3010
   SET F3_ESPECIE = 'NFS'
 WHERE F3_SERIE = 'B';

UPDATE SFT010
   SET FT_ESPECIE = 'NFS'
 WHERE FT_SERIE = 'B';