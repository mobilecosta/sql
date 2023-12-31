SELECT SF4.F4_TESDV, B6_TES, B6_QUANT, B6_SALDO, SB6.* 
  FROM SB6010 SB6
  LEFT JOIN SF4010 SF4 ON SF4.D_E_L_E_T_ = ' ' AND SF4.F4_FILIAL = SB6.B6_FILIAL AND SF4.F4_CODIGO = SB6.B6_TES
 WHERE SB6.D_E_L_E_T_ = ' ' AND B6_TIPO = 'E' AND B6_SALDO > 0
 ORDER BY SB6.B6_PRODUTO;

SELECT SF4.F4_TESDV, B6_TES, B6_QUANT, B6_SALDO, SB6.*
  FROM SB6010 SB6
  LEFT JOIN SF4010 SF4 ON SF4.D_E_L_E_T_ = ' ' AND SF4.F4_FILIAL = SB6.B6_FILIAL AND SF4.F4_CODIGO = SB6.B6_TES
 WHERE SB6.D_E_L_E_T_ = ' ' AND SB6.B6_TIPO = 'D' AND SB6.B6_SALDO > 0
 ORDER BY B6_PRODUTO;

-- B2_QTER = Saldo do Poder de Terceiros
-- B2_QTNP = Qtd. Terc. em Nosso Poder
-- B2_QNPT = Qt.Ns.Pd.Ter

-- 1) F4_ESTOQUE = N

-- SE F4_PODER3 = D 
-- B2_QTER -= B6_QUANT
-- ELSE F4_PODER3 = R
-- B2_QTER += B6_QUANT

-- 2) ENTRADA -> F4_ESTOQUE = S
-- SE F4_PODER3 = D 
-- B2_QNPT -= B6_QUANT
-- ELSE F4_PODER3 = R
-- B2_QTNP += B6_QUANT

-- 3) SAIDA -> F4_ESTOQUE = S
-- SE F4_PODER3 = D 
-- B2_QTNP -= B6_QUANT
-- ELSE F4_PODER3 = R
-- B2_QNPT += B6_QUANT

-- A) Devolu��o de produto de fornecedor

-- 1. Gera nova ocorr�ncia utilizando a pr�pria nota de origem
INSERT INTO SB6010(B6_FILIAL, B6_CLIFOR, B6_LOJA, B6_PRODUTO, B6_LOCAL, B6_SEGUM, B6_DOC, B6_SERIE, B6_EMISSAO,
                   B6_DTDIGIT, B6_QUANT, B6_PRUNIT, B6_TES, B6_TIPO, B6_UM, B6_QTSEGUM, B6_IDENT,
                   B6_TPCF, B6_PODER3, B6_ORIGLAN, B6_ESTOQUE, R_E_C_N_O_)
            SELECT B6_FILIAL, B6_CLIFOR, B6_LOJA, B6_PRODUTO, B6_LOCAL, B6_SEGUM, B6_DOC, B6_SERIE, 
                   CONVERT(VARCHAR(8), CAST(B6_EMISSAO AS DATETIME) + 1, 112) AS B6_EMISSAO,
                   CONVERT(VARCHAR(8), CAST(B6_DTDIGIT AS DATETIME) + 1, 112) AS B6_DTDIGIT,
                   B6_QUANT, B6_PRUNIT, SF4.F4_TESDV AS B6_TES, B6_TIPO, B6_UM, B6_QTSEGUM, B6_IDENT, B6_TPCF, 
                   SF4DV.F4_PODER3 AS B6_PODER3, B6_ORIGLAN, B6_ESTOQUE, 
                   COALESCE((SELECT MAX(R_E_C_N_O_) + 1 FROM SB6010), 1) AS R_E_C_N_O_
              FROM SB6010 SB6
              JOIN SF4010 SF4 ON SF4.D_E_L_E_T_ = ' ' AND SF4.F4_FILIAL = SB6.B6_FILIAL AND SF4.F4_CODIGO = SB6.B6_TES
              JOIN SF4010 SF4DV ON SF4DV.D_E_L_E_T_ = ' ' AND SF4DV.F4_FILIAL = SB6.B6_FILIAL AND SF4DV.F4_CODIGO = SF4.F4_TESDV
             WHERE SB6.B6_PRODUTO = '000.000.20.00'
             ORDER BY B6_PRODUTO;

-- 2. Zera o saldo do item de terceiros
UPDATE SB6010
   SET B6_SALDO = 0, B6_UENT = CONVERT(VARCHAR(8), CAST(B6_DTDIGIT AS DATETIME) + 1, 112),
       B6_ATEND = 'S'
 WHERE R_E_C_N_O_ = 185180;

ALTER TABLE SB6010 DROP B6_XORIGEM;

-- 3. Atualiza o saldo por local do produto
UPDATE SB2010 
   SET B2_QTER = CASE WHEN SF4.F4_ESTOQUE = 'N' 
                      THEN B2_QTER + SB6010.B6_QUANT * CASE WHEN SF4.F4_PODER3 = 'D' THEN -1 ELSE 1 END
                      ELSE B2_QTER END,
       B2_QNPT = CASE WHEN SF4.F4_ESTOQUE = 'S' AND SB6010.B6_ORIGEM = 'SD1'
                      THEN B2_QNPT + SB6010.B6_QUANT * CASE WHEN SF4.F4_PODER3 = 'D' THEN -1 ELSE 1 END
                      ELSE B2_QNPT END,
       B2_QTNP = CASE WHEN SF4.F4_ESTOQUE = 'S' AND SB6010.B6_ORIGEM = 'SD2'
                      THEN B2_QTNP + SB6010.B6_QUANT * CASE WHEN SF4.F4_PODER3 = 'D' THEN -1 ELSE 1 END
                      ELSE B2_QTNP END
  FROM SB6010
  JOIN SF4010 SF4 ON SF4.D_E_L_E_T_ = ' ' AND SF4.F4_FILIAL = SB6010.B6_FILIAL AND SF4.F4_CODIGO = SB6010.B6_TES
 WHERE SB6010.R_E_C_N_O_ = (SELECT MAX(R_E_C_N_O_) + 1 FROM SB6010) 
   AND SB2010.D_E_L_E_T_ = ' ' AND SB2010.B2_COD = SB6010.B6_PRODUTO
   AND SB2010.B2_LOCAL = SB6010.B6_LOCAL;

-- 1) F4_ESTOQUE = N

-- SE F4_PODER3 = D 
-- B2_QTER -= B6_QUANT
-- ELSE F4_PODER3 = R
-- B2_QTER += B6_QUANT

-- 2) ENTRADA -> F4_ESTOQUE = S
-- SE F4_PODER3 = D 
-- B2_QNPT -= B6_QUANT
-- ELSE F4_PODER3 = R
-- B2_QTNP += B6_QUANT

-- 3) SAIDA -> F4_ESTOQUE = S
-- SE F4_PODER3 = D 
-- B2_QTNP -= B6_QUANT
-- ELSE F4_PODER3 = R
-- B2_QNPT += B6_QUANT

SELECT * FROM SB2010 
 WHERE D_E_L_E_T_ = ' ' AND B2_COD = '000.000.20.00';
 
SELECT B6_XORIGEM, * FROM SB6010 
 WHERE D_E_L_E_T_ = ' ' AND B6_PRODUTO = '000.000.20.00'; 
 
SELECT COUNT(*) FROM SB6010 WHERE D_E_L_E_T_ = ' '; 