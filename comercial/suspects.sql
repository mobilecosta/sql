SELECT CNPJ,NOME,FANTASIA,ENDERECO,NUMERO,BAIRRO,CEP,CIDADE,UF,CNAE,CC3_DESC,TELEFONE,EMAIL,ABERTURA,COMPLEMEN
  FROM CONTAS
  LEFT JOIN CC3000 CC3 ON CC3.CC3_COD = SUBSTR(CONTAS.CNAE, 1, 4) || '-' || SUBSTR(CONTAS.CNAE, 5, 1) || '/' || SUBSTR(CONTAS.CNAE, 6, 2)
 WHERE SITUACAO = 'ATIVA'  AND UF = 'SP'
   AND CIDADE IN ('MAUA', 'SANTO ANDRE', 'SAO BERNARDO DO CAMPO', 'SAO PAULO', 'GUARULHOS', 'DIADEMA', 'BRAGANCA PAULISTA', 'RIBEIRAO PIRES')
   AND (TELEFONE <> ' ' OR EMAIL <> ' ')
   AND (SELECT COUNT(*) FROM SUS000 WHERE US_CGC = CONTAS.CNPJ) = 0 AND (SELECT COUNT(*) FROM SA1000 WHERE A1_CGC = CONTAS.CNPJ) = 0
 ORDER BY CIDADE,ABERTURA,CNAE

SELECT COUNT(*) FROM CONTAS WHERE SITUACAO = 'ATIVA'  AND UF = 'SP' AND (TELEFONE <> ' ' OR EMAIL <> ' ')
   AND (SELECT COUNT(*) FROM SUS000 WHERE US_CGC = CONTAS.CNPJ) = 0 AND (SELECT COUNT(*) FROM SA1000 WHERE A1_CGC = CONTAS.CNPJ) = 0

