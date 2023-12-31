-- 0.0 - Kardex
   SELECT D1_COD COD,
	       D1_NUMSEQ NUMSEQ,
	       D1_DTDIGIT DTDIGIT,
	       '100' TM,  
	       D1_QUANT QUANT, 
	       (D1_TOTAL+D1_DESPESA-D1_VALICM) MOVCOST, 
	       D1_CUSTO REALCOST,
	       SD1.R_E_C_N_O_ RECPOINTER,
	       'SD1' ORIG
		FROM SD1450 SD1
		INNER JOIN SB1450 SB1 ON D1_COD=B1_COD          
		INNER JOIN SF4450 SF4 ON D1_TES=F4_CODIGO
		WHERE SD1.D_E_L_E_T_=' '
		  AND SB1.D_E_L_E_T_=' ' 
		  AND D1_QUANT>0
		  AND D1_DTDIGIT > '20161231'
		  AND D1_ORIGLAN <> 'LF'
		  AND (F4_ESTOQUE='S' OR F4_PODER3 IN ('R', 'D'))
		UNION ALL
		SELECT DISTINCT D2_COD COD,
		       D2_NUMSEQ NUMSEQ,
		       D2_EMISSAO DTDIGIT,
		       '600' TM,
		       D2_QUANT QUANT,
		       D2_CUSTO1 MOVCOST,
		       D2_CUSTO1 REALCOST, 
       	               SD2.R_E_C_N_O_ RECPOINTER, 
		       'SD2' ORIG
		FROM SD2450 SD2
		INNER JOIN SB1450 SB1 ON D2_COD=B1_COD
		INNER JOIN SF4450 ON D2_TES=F4_CODIGO
		WHERE SD2.D_E_L_E_T_=' '
		  AND SB1.D_E_L_E_T_=' '
		  AND D2_QUANT >0 
		  AND D2_EMISSAO > '20161231'
		  AND D2_ORIGLAN <> 'LF'
		  AND (F4_ESTOQUE='S' OR F4_PODER3 IN ('R', 'D'))		  
		UNION ALL
		SELECT DISTINCT D3_COD COD,
		       D3_NUMSEQ NUMSEQ,
		       D3_EMISSAO DTDIGIT,
		       D3_TM TM,
		       Case When D3_QUANT = 0 Then 1 else D3_QUANT end QUANT,
		       D3_CUSTO1 MOVCOST,
		       D3_CUSTO1 REALCOST,
       	       SD3.R_E_C_N_O_ RECPOINTER,
		       'SD3' ORIG
		FROM SD3450 SD3
		INNER JOIN SB1450 SB1 ON D3_COD=B1_COD
		WHERE SD3.D_E_L_E_T_=' '
		  AND SB1.D_E_L_E_T_=' '
		  AND D3_EMISSAO > '20161231'
		ORDER BY DTDIGIT, COD, NUMSEQ


-- 0.1 - Limpa data do invent�rio e movimenta��o a ser trocada
SELECT * FROM SD3450 WHERE D3_FILIAL = '01' AND D3_EMISSAO = '20161228' AND D3_DOC = 'INVENT';
DELETE FROM SD3450 WHERE D3_FILIAL = '01' AND D3_EMISSAO = '20161228' AND D3_DOC = 'INVENT';

SELECT * FROM SD5450 WHERE D5_FILIAL = '01' AND D5_DATA = '20161228' AND D5_DOC = 'INVENT';
DELETE FROM SD5450 WHERE D5_FILIAL = '01' AND D5_DATA = '20161228' AND D5_DOC = 'INVENT';

UPDATE SB2450 SET B2_DINVENT = ' ' WHERE B2_DINVENT = '20161228'

-- 0.1 - Corrige saldo atual
SELECT * FROM SB2450 WHERE B2_FILIAL = '01' AND B2_QATU <> B2_QFIM AND D_E_L_E_T_ = ' '
UPDATE SB2450 SET B2_QATU = B2_QFIM WHERE B2_FILIAL = '01' AND B2_QATU <> B2_QFIM AND D_E_L_E_T_ = ' '

SELECT * FROM SB2450 WHERE B2_FILIAL = '01' AND (B2_QATU > 0 OR B2_QFIM < 0) AND D_E_L_E_T_ = ' '

SELECT B1_RASTRO FROM SB1450 WHERE B1_FILIAL = '01' AND B1_COD = '13'

-- 1.1 - Itens com saldo por lote incorreto
SELECT B8_PRODUTO, B8_LOTECTL, B8_SALDO,
       (SELECT SUM(CASE WHEN D5_ORIGLAN  < '500' THEN D5_QUANT ELSE 0 END) -
               SUM(CASE WHEN D5_ORIGLAN >= '500' THEN D5_QUANT ELSE 0 END)
          FROM SD5450 SD5
          JOIN SB8450 SD8 ON B8_FILIAL = D5_FILIAL AND B8_PRODUTO = D5_PRODUTO AND D5_LOTECTL = B8_LOTECTL AND SD8.D_E_L_E_T_ = ' '
         WHERE D5_FILIAL = '01' AND SD5.D5_PRODUTO = SB8450.B8_PRODUTO AND SD5.D5_LOTECTL = SB8450.B8_LOTECTL
		   AND D5_ESTORNO <> 'S' AND SD5.D_E_L_E_T_ = ' '
         GROUP BY D5_PRODUTO, D5_LOTECTL
         HAVING SUM(CASE WHEN D5_ORIGLAN  < '500' THEN D5_QUANT ELSE 0 END) -
                SUM(CASE WHEN D5_ORIGLAN >= '500' THEN D5_QUANT ELSE 0 END) <> MIN(B8_SALDO)) AS NOVO
  FROM SB8450
 WHERE B8_FILIAL = '01' 
   AND EXISTS(SELECT 1
                FROM SD5450 SD5
                JOIN SB8450 SD8 ON B8_FILIAL = D5_FILIAL AND B8_PRODUTO = D5_PRODUTO AND D5_LOTECTL = B8_LOTECTL 
				 AND SD8.D_E_L_E_T_ = ' '
               WHERE D5_FILIAL = '01' AND SD5.D5_PRODUTO = SB8450.B8_PRODUTO AND SD5.D5_LOTECTL = SB8450.B8_LOTECTL
			     AND D5_ESTORNO <> 'S' AND SD5.D_E_L_E_T_ = ' '
               GROUP BY D5_PRODUTO, D5_LOTECTL
              HAVING SUM(CASE WHEN D5_ORIGLAN  < '500' THEN D5_QUANT ELSE 0 END) -
                     SUM(CASE WHEN D5_ORIGLAN >= '500' THEN D5_QUANT ELSE 0 END) <> MIN(B8_SALDO))

-- 1.2 - Corrige saldo do saldo por lote
UPDATE SB8450
   SET B8_SALDO = (SELECT SUM(CASE WHEN D5_ORIGLAN  < '500' THEN D5_QUANT ELSE 0 END) -
                          SUM(CASE WHEN D5_ORIGLAN >= '500' THEN D5_QUANT ELSE 0 END)
                     FROM SD5450 SD5
                     JOIN SB8450 SD8 ON B8_FILIAL = D5_FILIAL AND B8_PRODUTO = D5_PRODUTO AND D5_LOTECTL = B8_LOTECTL AND SD8.D_E_L_E_T_ = ' '
                    WHERE D5_FILIAL = '01' AND SD5.D5_PRODUTO = SB8450.B8_PRODUTO AND SD5.D5_LOTECTL = SB8450.B8_LOTECTL
		              AND D5_ESTORNO <> 'S' AND SD5.D_E_L_E_T_ = ' '
                    GROUP BY D5_PRODUTO, D5_LOTECTL
                   HAVING SUM(CASE WHEN D5_ORIGLAN  < '500' THEN D5_QUANT ELSE 0 END) -
                          SUM(CASE WHEN D5_ORIGLAN >= '500' THEN D5_QUANT ELSE 0 END) <> MIN(B8_SALDO))
 WHERE B8_FILIAL = '01' 
   AND EXISTS(SELECT 1
                FROM SD5450 SD5
                JOIN SB8450 SD8 ON B8_FILIAL = D5_FILIAL AND B8_PRODUTO = D5_PRODUTO AND D5_LOTECTL = B8_LOTECTL 
				 AND SD8.D_E_L_E_T_ = ' '
               WHERE D5_FILIAL = '01' AND SD5.D5_PRODUTO = SB8450.B8_PRODUTO AND SD5.D5_LOTECTL = SB8450.B8_LOTECTL
			     AND D5_ESTORNO <> 'S' AND SD5.D_E_L_E_T_ = ' '
               GROUP BY D5_PRODUTO, D5_LOTECTL
              HAVING SUM(CASE WHEN D5_ORIGLAN  < '500' THEN D5_QUANT ELSE 0 END) -
                     SUM(CASE WHEN D5_ORIGLAN >= '500' THEN D5_QUANT ELSE 0 END) <> MIN(B8_SALDO))

-- 1. Zerar saldo dos lotes existentes com invent�rio 28/12/2016 - Doc 281220161
SELECT * FROM SB7450 WHERE B7_FILIAL = '01' AND B7_DOC = '281220161' AND D_E_L_E_T_ = ' '
DELETE FROM SB7450 WHERE B7_FILIAL = '01' AND B7_DOC = '281220161'

INSERT INTO SB7450(B7_FILIAL, B7_COD, B7_LOCAL, B7_TIPO, B7_DOC, B7_QUANT, B7_DATA, B7_LOTECTL, B7_DTVALID, B7_NUMDOC, B7_SERIE, 
                   B7_FORNECE, B7_LOJA,B7_STATUS, R_E_C_N_O_)
SELECT B8_FILIAL, B8_PRODUTO, B8_LOCAL, B1_TIPO, '281220161' AS B7_DOC, 0 AS B7_QUANT, '20161228' AS B7_DATA, B8_LOTECTL, B8_DTVALID,
       B8_DOC, B8_SERIE, B8_CLIFOR, B8_LOJA, '1' AS B7_STATUS, 
	   ROW_NUMBER() OVER(ORDER BY B8_PRODUTO, B8_LOTECTL ) + (SELECT MAX(R_E_C_N_O_) FROM SB7450) AS R_E_C_N_O_
  FROM SB8450 SB8
  LEFT JOIN SB1450 SB1 ON B1_FILIAL = B8_FILIAL AND B1_COD = B8_PRODUTO AND SB1.D_E_L_E_T_ = ' '
 WHERE B8_FILIAL = '01' AND B8_SALDO > 0 AND SB8.D_E_L_E_T_ = ' '
 ORDER BY B8_PRODUTO, B8_LOTECTL    

-- 2. Gerar registro invent�rio itens com diferen�a local x lote - 28/12/2016 - Doc 281220162
SELECT * FROM SB7450 WHERE B7_FILIAL = '01' AND B7_DOC = '281220162' AND D_E_L_E_T_ = ' '
DELETE FROM SB7450 WHERE B7_FILIAL = '01' AND B7_DOC = '281220162'

INSERT INTO SB7450(B7_FILIAL, B7_COD, B7_LOCAL, B7_TIPO, B7_DOC, B7_QUANT, B7_DATA, B7_STATUS, R_E_C_N_O_)
SELECT B9_FILIAL, B9_COD, B9_LOCAL, B1_TIPO, '281220162' AS B7_DOC, 0 AS B7_QUANT, '20161228' AS B7_DATA, 
       '1' AS B7_STATUS, 
	   ROW_NUMBER() OVER(ORDER BY B9_COD) + (SELECT MAX(R_E_C_N_O_) FROM SB7450) AS R_E_C_N_O_
  FROM SB9450 SB9
  JOIN (SELECT BJ_COD, BJ_LOCAL, SUM(BJ_QINI) AS BJ_QINI
          FROM SBJ450
		 WHERE BJ_FILIAL = '01' AND BJ_DATA = '20161130' AND D_E_L_E_T_ = ' '
		 GROUP BY BJ_COD, BJ_LOCAL) SBJ ON SBJ.BJ_COD = B9_COD AND SBJ.BJ_LOCAL = B9_LOCAL
  LEFT JOIN SB1450 SB1 ON B1_FILIAL = B9_FILIAL AND B1_COD = B9_COD AND SB1.D_E_L_E_T_ = ' '
 WHERE B9_FILIAL = '01' AND B9_DATA = '20161130' AND (B9_QINI <> BJ_QINI) 
   AND SB9.D_E_L_E_T_ = ' '
 ORDER BY B9_COD

-- Indica que o produto n�o tem controle de rastro/retorna 
UPDATE SB1450 
   SET B1_RASTRO = 'L'
 WHERE B1_FILIAL = '01' 
   AND B1_COD IN (SELECT B7_COD FROM SB7450 SB7 JOIN SB1450 SB1 ON B1_FILIAL = B7_FILIAL AND B1_COD = B7_COD
                     AND SB1.D_E_L_E_T_ = ' '
				   WHERE B7_FILIAL = '01' AND B7_DOC = '281220162' 
                     AND SB7.D_E_L_E_T_ = ' ')

-- 3. Produtos com saldo
SELECT * FROM SB7450 WHERE B7_FILIAL = '01' AND B7_DOC = '281220163' AND D_E_L_E_T_ = ' '
DELETE FROM SB7450 WHERE B7_FILIAL = '01' AND B7_DOC = '281220163'

INSERT INTO SB7450(B7_FILIAL, B7_COD, B7_LOCAL, B7_TIPO, B7_DOC, B7_QUANT, B7_DATA, B7_STATUS, R_E_C_N_O_)
SELECT B2_FILIAL, B2_COD, B2_LOCAL, B1_TIPO, '281220163' AS B7_DOC, 0 AS B7_QUANT, '20161228' AS B7_DATA, 
       '1' AS B7_STATUS,
	   ROW_NUMBER() OVER(ORDER BY B2_COD) + (SELECT MAX(R_E_C_N_O_) FROM SB7450) AS R_E_C_N_O_
  FROM SB2450 SB2
  LEFT JOIN SB1450 SB1 ON B1_FILIAL = B2_FILIAL AND B1_COD = B2_COD AND SB1.D_E_L_E_T_ = ' '
 WHERE B2_FILIAL = '01' AND B2_QFIM > 0 AND SB2.D_E_L_E_T_ = ' '
 ORDER BY B2_COD

UPDATE SB1450 
   SET B1_RASTRO = 'N'
 WHERE B1_FILIAL = '01' 
   AND B1_COD IN (SELECT B7_COD FROM SB7450 SB7 JOIN SB1450 SB1 ON B1_FILIAL = B7_FILIAL AND B1_COD = B7_COD
                     AND SB1.D_E_L_E_T_ = ' '
				   WHERE B7_FILIAL = '01' AND B7_DOC = '281220163' 
                     AND SB7.D_E_L_E_T_ = ' ')

-- 4. Sele��o corrige B1_RASTRO
SELECT B1_COD, B1_DESC, B1_RASTRO,
       COALESCE((SELECT MIN('L') FROM SB8450 WHERE B8_FILIAL = SB1450.B1_FILIAL
                    AND B8_PRODUTO = SB1450.B1_COD AND D_E_L_E_T_ = ' '
		       GROUP BY B8_PRODUTO), 'N') AS B1_RASTRO_C
  FROM SB1450
 WHERE B1_FILIAL = '01' AND D_E_L_E_T_ = ' '
   AND B1_RASTRO <> COALESCE((SELECT MIN('L') FROM SB8450 WHERE B8_FILIAL = SB1450.B1_FILIAL
                                 AND B8_PRODUTO = SB1450.B1_COD AND D_E_L_E_T_ = ' '
						       GROUP BY B8_PRODUTO), 'N')
								
-- 4. Update corrige B1_RASTRO
UPDATE SB1450
  SET B1_RASTRO = COALESCE((SELECT MIN('L') FROM SB8450 WHERE B8_FILIAL = SB1450.B1_FILIAL
                               AND B8_PRODUTO = SB1450.B1_COD AND D_E_L_E_T_ = ' '
		                  GROUP BY B8_PRODUTO), 'N')
 WHERE B1_FILIAL = '01' AND D_E_L_E_T_ = ' '
   AND B1_RASTRO <> COALESCE((SELECT MIN('L') FROM SB8450 WHERE B8_FILIAL = SB1450.B1_FILIAL
                                 AND B8_PRODUTO = SB1450.B1_COD AND D_E_L_E_T_ = ' '
						       GROUP BY B8_PRODUTO), 'N')