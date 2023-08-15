-- Produtos
B1_COD
B1_DESC
B1_CODISS

-- Clientes
A1_COD
A1_LOJA
A1_NOME
A1_NREDUZ
A1_EMAIL
A1_TEL
A1_FAX
A1_PESSOA
A1_CGC
A1_INSCR
A1_DTNASC
A1_CEP
A1_END
A1_COMPLEM
A1_BAIRRO

-- Notas
F2_FILIAL
F2_DOC
F2_SERIE
F2_EMISSAO
F2_CLIENTE
F2_LOJA
F2_PREFIXO
F2_DUPL
F2_FRETE

-- Itens de Nota
D2_FILIAL
D2_DOC
D2_SERIE
D2_COD
D2_CLIENTE
D2_LOJA
D2_EMISSAO
D2_TIPO
D2_QUANT
D2_PRCVEN
D2_TOTAL

-- Titulos a receber
E1_FILIAL
E1_PREFIXO
E1_NUM
E1_PARCELA
E1_VENCTO
E1_VENCREA
E1_VALOR

-- Prepara��o de Status
UPDATE <ADVPL>aQuery[1][2]:cArqTrb</ADVPL> 
   SET STATUS = CASE WHEN EXISTS(SELECT 1 FROM <ADVPL>RetSqlName("SF2")</ADVPL> SF2 
                                     WHERE F2_FILIAL = '<ADVPL>xFilial("SF2")</ADVPL>' AND F2_SERIE = '<ADVPL>mv_par01</ADVPL>'
                                       AND F2_DOC = <ADVPL>aQuery[1][2]:cArqTrb</ADVPL>.NFINICIAL AND F2_ESPECIE = 'NFS'
                                       AND D_E_L_E_T_ = ' ') THEN '3' 
                     WHEN NOT EXISTS(SELECT 1 FROM <ADVPL>RetSqlName("SB1")</ADVPL> SB1
                                      WHERE B1_FILIAL = '<ADVPL>xFilial("SB1")</ADVPL>' AND B1_CODISS = <ADVPL>aQuery[1][2]:cArqTrb</ADVPL>.ATIVIDADE
                                        AND D_E_L_E_T_ = ' ') THEN '2' ELSE '1' END, 
       A1_COD = COALESCE((SELECT MAX(A1_COD) FROM <ADVPL>RetSqlName("SA1")</ADVPL> SA1 
	                   WHERE SA1.A1_FILIAL = '<ADVPL>xFilial("SA1")</ADVPL>' AND SA1.A1_CGC = <ADVPL>aQuery[1][2]:cArqTrb</ADVPL>.CNPJ 
                             AND SA1.D_E_L_E_T_ = ' ' ), ' ')


-- Gera��o da Nota
INSERT INTO <ADVPL>RetSqlName("SA1")</ADVPL>(A1_FILIAL, A1_COD, A1_LOJA, A1_NOME, A1_NREDUZ, A1_CGC, A1_PESSOA, A1_TIPO, A1_DTNASC, A1_END, A1_COMPLEM, 
       A1_CEP, A1_BAIRRO, A1_COD_MUN, A1_MUN, A1_EST, R_E_C_N_O_)
SELECT '<ADVPL>xFilial("SA1")</ADVPL>', 
       STRZERO((<ADVPL>__A1_COD</ADVPL> + ROW_NUMBER() OVER (ORDER BY TMP.CNPJ))::numeric, 6) AS A1_COD, '01' AS A1_LOJA, MIN(RAZAO) AS A1_NOME, 
       SUBSTRING(MIN(RAZAO), 1, 20) AS A1_NEDUZ, CNPJ, CASE WHEN LENGTH(CNPJ) = 14 THEN 'J' ELSE 'F' END AS A1_PESSOA, 'F', '<ADVPL>Dtos(dDataBase)</ADVPL>',
       RTRIM(LTRIM(MIN(ENDERECO))) || CASE WHEN MIN(NUMERO) <> ' ' THEN ', ' || MIN(NUMERO) ELSE '' END AS A1_END, MIN(COMPLEME), MIN(CEP), MIN(BAIRRO), 
       MIN(CC2_CODMUN) AS A1_COD_MUN, UPPER(MIN(CIDADE)), UPPER(MIN(ESTADO)), 
       ROW_NUMBER() OVER (ORDER BY TMP.CNPJ) + COALESCE((SELECT MAX(R_E_C_N_O_) FROM <ADVPL>RetSqlName("SA1")</ADVPL>), 0) AS R_E_C_N_O_
  FROM <ADVPL>aQuery[1][2]:cArqTrb</ADVPL> TMP
  LEFT JOIN <ADVPL>RetSqlName("CC2")</ADVPL> CC2 ON CC2_FILIAL = '<ADVPL>xFilial("CC2")</ADVPL>' AND CC2_EST = ESTADO AND CC2_MUN = CIDADE AND CC2.D_E_L_E_T_ = ''
 WHERE STATUS = '1' AND A1_COD = ' ' AND CNPJ <> ' '
 GROUP BY CNPJ
 ORDER BY TMP.CNPJ;;
<ADVPL>U_ParserADV(M->PQ6_GSQL)</ADVPL>;;
INSERT INTO <ADVPL>RetSqlName("SF2")</ADVPL>(F2_FILIAL, F2_DOC, F2_SERIE, F2_EMISSAO, F2_CLIENTE, F2_LOJA, F2_PREFIXO, F2_DUPL, F2_ESPECIE, F2_VAlBRUT,
            F2_BASEISS, F2_VALISS, R_E_C_N_O_)
SELECT '<ADVPL>xFilial("SF2")</ADVPL>' AS F2_FILIAL, NFINICIAL AS F2_DOC, '<ADVPL>mv_par01</ADVPL>' AS F2_SERIE, 
       '<ADVPL>Right(mv_par02, 4) + Left(mv_par02, 2)</ADVPL>' || STRZERO(DIA::NUMERIC, 2) AS F2_EMISSAO, A1_COD AS F2_CLIENTE, '01' AS F2_LOJA, 
       '<ADVPL>mv_par01</ADVPL>' AS F2_PREFIXO, NFINICIAL AS F2_DUPL, 'NFS' AS F2_ESPECIE, RECEITA AS F2_VALBRUT, BASE AS F2_BASEISS, IMPOSTO AS F2_VALISS,
       ROW_NUMBER() OVER (ORDER BY TMP.NFINICIAL) + COALESCE((SELECT MAX(R_E_C_N_O_) FROM <ADVPL>RetSqlName("SF2")</ADVPL>), 0) AS R_E_C_N_O_
  FROM <ADVPL>aQuery[1][2]:cArqTrb</ADVPL> TMP
 WHERE STATUS = '1' AND A1_COD <> ' '
 ORDER BY NFINICIAL;;
INSERT INTO <ADVPL>RetSqlName("SD2")</ADVPL>(D2_FILIAL, D2_DOC, D2_SERIE, D2_TIPO, D2_EMISSAO, D2_CLIENTE, D2_LOJA, D2_COD, D2_ITEM, D2_QUANT, D2_PRCVEN, D2_TOTAL, 
       D2_CODISS,D2_BASEISS, D2_ALIQISS, D2_VALISS, R_E_C_N_O_)
SELECT '<ADVPL>xFilial("SD2")</ADVPL>' AS D2_FILIAL, NFINICIAL AS D2_DOC, '<ADVPL>mv_par01</ADVPL>' AS D2_SERIE, 'N' AS D2_TIPO,
       '<ADVPL>Right(mv_par02, 4) + Left(mv_par02, 2)</ADVPL>' || STRZERO(DIA::NUMERIC, 2) AS F2_EMISSAO, A1_COD AS D2_CLIENTE, '01' AS D2_LOJA, B1_COD, 
       '01' AS D2_ITEM, 1 AS D2_QUANT, RECEITA AS D2_PRCVEN, RECEITA AS D2_TOTAL, ATIVIDADE AS D2_CODISS, BASE AS D2_BASEISS, ALIQUOTA AS D2_ALIQISS, 
       IMPOSTO AS D2_VALISS, ROW_NUMBER() OVER (ORDER BY TMP.NFINICIAL) + COALESCE((SELECT MAX(R_E_C_N_O_) FROM <ADVPL>RetSqlName("SD2")</ADVPL>), 0) AS R_E_C_N_O_
  FROM <ADVPL>aQuery[1][2]:cArqTrb</ADVPL> TMP
  JOIN <ADVPL>RetSqlName("SB1")</ADVPL> SB1 ON B1_FILIAL = '<ADVPL>xFilial("SB1")</ADVPL>' AND B1_CODISS = TMP.ATIVIDADE AND SB1.D_E_L_E_T_ = ' '
 WHERE STATUS = '1' AND A1_COD <> ' '
 ORDER BY NFINICIAL;;
INSERT INTO <ADVPL>RetSqlName("SE1")</ADVPL>(E1_FILIAL, E1_NUM, E1_PREFIXO, E1_EMISSAO, E1_CLIENTE, E1_LOJA, E1_VALOR, E1_VLCRUZ, E1_SALDO, 
       E1_VENCTO, E1_VENCREA, E1_VENCORI, E1_STATUS, E1_ISS, E1_SERIE, E1_SDOC, E1_ORIGEM, R_E_C_N_O_)
SELECT '<ADVPL>xFilial("SE1")</ADVPL>' AS E1_FILIAL, NFINICIAL AS E1_NUM, '<ADVPL>mv_par01</ADVPL>' AS E1_PREFIXO, 
       '<ADVPL>Right(mv_par02, 4) + Left(mv_par02, 2)</ADVPL>' || STRZERO(DIA::NUMERIC, 2) AS E1_EMISSAO, A1_COD AS E1_CLIENTE, '01' AS E1_LOJA, 
       RECEITA AS E1_VALOR, RECEITA AS E1_VLRCRUZ, RECEITA AS E1_SALDO, 
       '<ADVPL>Right(mv_par02, 4) + Left(mv_par02, 2)</ADVPL>' || STRZERO(DIA::NUMERIC, 2) AS E1_VENCTO, 
       '<ADVPL>Right(mv_par02, 4) + Left(mv_par02, 2)</ADVPL>' || STRZERO(DIA::NUMERIC, 2) AS E1_VENCREA, 
       '<ADVPL>Right(mv_par02, 4) + Left(mv_par02, 2)</ADVPL>' || STRZERO(DIA::NUMERIC, 2) AS E1_VENCORI, 'A' AS E1_STATUS, IMPOSTO AS E1_ISS, 
       '<ADVPL>mv_par01</ADVPL>' AS E1_SERIE, '<ADVPL>mv_par01</ADVPL>' AS E1_SDOC, 'MATA460' AS E1_ORIGEM,
       ROW_NUMBER() OVER (ORDER BY TMP.NFINICIAL) + COALESCE((SELECT MAX(R_E_C_N_O_) FROM <ADVPL>RetSqlName("SE1")</ADVPL>), 0) AS R_E_C_N_O_
  FROM <ADVPL>aQuery[1][2]:cArqTrb</ADVPL> TMP
 WHERE STATUS = '1' AND A1_COD <> ' '
 ORDER BY NFINICIAL;;