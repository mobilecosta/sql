use ZT8HTG;

-- Lote do Estoque
SELECT * FROM SX5010 WHERE X5_TABELA = '09' AND X5_CHAVE = 'EST';

-- Lançamentos contábeis
select * from CT2010 
 where D_E_L_E_T_ = ' ' AND CT2_DATA >= '20110801' AND CT2_DATA <= '20110831' AND LEFT(CT2_DEBITO, 4) = '3221';

-- Agrupamento de Compras
select CT2_DEBITO, CT2_CREDIT, 
       SUM(CASE WHEN CT2_DC IN ('1','3') THEN CT2_VALOR ELSE 0 END) AS CT2_VLRDEB,
       SUM(CASE WHEN CT2_DC IN ('2','3') THEN CT2_VALOR ELSE 0 END) AS CT2_VLRCRD
  from CT2010 
 where D_E_L_E_T_ = ' ' AND CT2_DATA >= '20110801' AND CT2_DATA <= '20110831' AND (CT2_DEBITO = '322111' OR CT2_DEBITO = '322112')
 GROUP BY CT2_DEBITO, CT2_CREDIT
 ORDER BY CT2_DEBITO, CT2_CREDIT;
 
-- 01. Valor das Compras
SELECT CASE WHEN SZ1.Z1_DEBITO <> '' THEN SZ1.Z1_DEBITO ELSE SB1.B1_CONTA END AS CONTA, SUM(SD1.D1_CUSTO) AS D1_CUSTO1
  FROM SB1010 SB1, SD1010 SD1, SF4010 SF4
  LEFT JOIN SZ1010 SZ1 ON SZ1.D_E_L_E_T_ = '	' AND SZ1.Z1_COD = SF4.F4_GRUPO
 WHERE SD1.D1_FILIAL = '01' AND SF4.F4_FILIAL = '01' AND SB1.B1_FILIAL = '01' AND SB1.B1_COD = SD1.D1_COD
   AND SD1.D1_TES =  SF4.F4_CODIGO AND SF4.F4_ESTOQUE = 'S' AND SF4.F4_PODER3 = 'N' AND SD1.D1_TIPO <> 'D' 
   AND SD1.D1_DTDIGIT >= '20110801'	AND SD1.D1_DTDIGIT <= '20110831' AND SD1.D1_ORIGLAN <> 'LF'
   AND SD1.D_E_L_E_T_ = ' ' AND SF4.D_E_L_E_T_ = ' '  AND SB1.D_E_L_E_T_ = ' '
  GROUP BY CASE WHEN SZ1.Z1_DEBITO <> '' THEN SZ1.Z1_DEBITO ELSE SB1.B1_CONTA END;

-- 06. Valor das Vendas
SELECT CASE WHEN SZ1.Z1_CREDITO <> '' THEN SZ1.Z1_CREDITO ELSE SB1.B1_CONTA END AS CONTA, SUM(D2_CUSTO1) AS D2_CUSTO1
  FROM SB1010 SB1, SD2010 SD2, SF4010 SF4
  LEFT JOIN SZ1010 SZ1 ON SZ1.D_E_L_E_T_ = '	' AND SZ1.Z1_COD = SF4.F4_GRUPO
 WHERE SD2.D2_FILIAL = '01' AND SF4.F4_FILIAL = '01' AND SB1.B1_FILIAL = '01' AND SB1.B1_COD = SD2.D2_COD
   AND SD2.D2_TES =  SF4.F4_CODIGO AND SF4.F4_ESTOQUE = 'S' AND SF4.F4_PODER3 = 'N' AND SD2.D2_TIPO <> 'D'
   AND SD2.D2_EMISSAO >= '20110801'	AND SD2.D2_EMISSAO <= '20110831' AND SD2.D2_ORIGLAN <> 'LF'
   AND SD2.D_E_L_E_T_ = ' ' AND SF4.D_E_L_E_T_ = ' '  AND SB1.D_E_L_E_T_ = ' '
 GROUP BY CASE WHEN SZ1.Z1_CREDITO <> '' THEN SZ1.Z1_CREDITO ELSE SB1.B1_CONTA END;

-- SALDO EM ESTOQUE EM 08/2011
SELECT SUM(SB9.B9_CM1 * B9_QINI) AS B9_CM1 
  FROM SB9010 SB9 
 WHERE SB9.D_E_L_E_T_ = ' ' AND SB9.B9_DATA = '20110831';

  JOIN SB1010 SB1 ON SB1.D_E_L_E_T_ = ' ' AND SB1.D_E_L_E_T_ = ' ' AND 

SELECT TOP 1 * FROM SB1010;
SELECT TOP 1 * FROM SB9010;

SELECT SUM(B9_CM1 * B9_QINI) AS B9_CM1 FROM SB9010 WHERE D_E_L_E_T_ = ' ' AND B9_DATA = '20110930';

-- 01. Valor das Compras (Resumo)
SELECT SD1.D1_DTDIGIT, SUM(SD1.D1_CUSTO) AS D1_CUSTO1
  FROM SB1010 SB1, SD1010 SD1, SF4010 SF4
 WHERE SD1.D1_FILIAL = '01' AND SF4.F4_FILIAL = '01' AND SB1.B1_FILIAL = '01' AND SB1.B1_COD = SD1.D1_COD
   AND SD1.D1_TES =  SF4.F4_CODIGO AND SF4.F4_ESTOQUE = 'S' AND SF4.F4_PODER3 = 'N' AND SD1.D1_TIPO <> 'D' 
   AND SD1.D1_DTDIGIT >= '20120101'	AND SD1.D1_DTDIGIT <= '20120123' AND SD1.D1_ORIGLAN <> 'LF'
   AND SB1.B1_TIPO = 'ME'
   AND SD1.D_E_L_E_T_ = ' ' AND SF4.D_E_L_E_T_ = ' '  AND SB1.D_E_L_E_T_ = ' '
 GROUP BY SD1.D1_DTDIGIT
 ORDER BY SD1.D1_DTDIGIT;
 
-- 01. Valor das Compras (Detalhe)
SELECT SD1.D1_DOC, SD1.D1_DTDIGIT, SD1.D1_CUSTO, SD1.*
  FROM SB1010 SB1, SD1010 SD1, SF4010 SF4
 WHERE SD1.D1_FILIAL = '01' AND SF4.F4_FILIAL = '01' AND SB1.B1_FILIAL = '01' AND SB1.B1_COD = SD1.D1_COD
   AND SD1.D1_TES =  SF4.F4_CODIGO AND SF4.F4_ESTOQUE = 'S' AND SF4.F4_PODER3 = 'N' AND SD1.D1_TIPO <> 'D' 
   AND SD1.D1_DTDIGIT >= '20120101'	AND SD1.D1_DTDIGIT <= '20120123' AND SD1.D1_ORIGLAN <> 'LF'
   AND SD1.D_E_L_E_T_ = ' ' AND SF4.D_E_L_E_T_ = ' '  AND SB1.D_E_L_E_T_ = ' '
   AND SB1.B1_TIPO = 'ME'
  ORDER BY SD1.D1_DTDIGIT, SD1.D1_DOC;