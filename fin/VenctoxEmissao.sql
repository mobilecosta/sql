-- Contas a Receber com data de emiss�o incorreta
SELECT SE1.E1_NUM, SE1.E1_PARCELA, SE1.E1_CLIENTE, SE1.E1_LOJA, SE1.E1_NOMCLI, SE1.E1_EMISSAO, SE1.E1_VENCTO,
       SE1.E1_VALOR, SE1.E1_BAIXA
  FROM SE1010 SE1 
 WHERE SE1.D_E_L_E_T_ = ' ' AND SE1.E1_VENCTO < SE1.E1_EMISSAO AND SE1.E1_TIPO = 'NF'
 ORDER BY SE1.E1_EMISSAO;
 
-- Contas a Pagar com data de vencimento incorreta
SELECT CAST(E2_VENCTO AS INTEGER) - CAST(E2_EMISSAO AS INTEGER), * FROM SE2010 WHERE D_E_L_E_T_ = ' ' AND E2_VENCTO < E2_EMISSAO;

SELECT E2_VENCTO, E2_EMISSAO, CAST(E2_VENCTO AS INTEGER) - CAST(E2_EMISSAO AS INTEGER), * FROM SE2010 WHERE D_E_L_E_T_ = ' ' AND E2_VENCTO > E2_EMISSAO;

SELECT SE2.E2_VENCTO,SE2.PRAZO, D2.*, F4.* 
 FROM SD2010 D2
 JOIN SF4010 F4 ON F4.F4_FILIAL = '01' AND D2.D2_TES = F4_CODIGO AND F4.F4_DUPLIC ='S' AND F4.F4_ESTOQUE ='S' AND F4.D_E_L_E_T_=' '
 LEFT JOIN (SELECT SE2.E2_FORNECE,SE2.E2_LOJA,SE2.E2_PREFIXO,SE2.E2_NUM, MIN(E2_VENCTO) AS E2_VENCTO,SUM(((CAST(E2_VENCTO AS INTEGER) - CAST(E2_EMISSAO AS INTEGER)) * E2_VALOR) / E2_VALOR) AS PRAZO FROM SE2010 SE2 WHERE SE2.E2_FILIAL='01' AND SE2.E2_TIPO='NF 'AND SE2.D_E_L_E_T_=' ' GROUP BY SE2.E2_FORNECE,SE2.E2_LOJA,SE2.E2_PREFIXO,SE2.E2_NUM) SE2 ON SE2.E2_FORNECE=D2.D2_CLIENTE AND SE2.E2_LOJA = D2.D2_LOJA AND SE2.E2_PREFIXO=D2.D2_SERIORI AND SE2.E2_NUM= D2.D2_NFORI 
WHERE D2.D2_FILIAL = '01' AND D2.D2_TIPO = 'D' AND D2.D2_EMISSAO >='20110101' AND D2.D2_EMISSAO <='20110831' AND D2.D_E_L_E_T_=' '; 

-- Devolu��o de Compras
SELECT SE2.E2_VENCTO,SE2.PRAZO,D2.*,F4.* 
  FROM SD2010 D2 
  JOIN SF4010 F4 ON F4.F4_FILIAL = '01' AND F4.F4_CODIGO = D2.D2_TES AND F4.F4_DUPLIC = 'S' AND F4.F4_ESTOQUE = 'S' AND F4.D_E_L_E_T_=' ' 
  LEFT JOIN (SELECT SE2.E2_FORNECE,SE2.E2_LOJA,SE2.E2_PREFIXO,SE2.E2_NUM,MIN(E2_VENCTO) AS E2_VENCTO,SUM(((CAST(E2_VENCTO AS INTEGER) - CAST(E2_EMISSAO AS INTEGER)) * E2_VALOR) / E2_VALOR) AS PRAZO FROM SE2010 SE2 WHERE SE2.E2_FILIAL='01' AND SE2.E2_TIPO='NF 'AND SE2.D_E_L_E_T_=' ' GROUP BY SE2.E2_FORNECE,SE2.E2_LOJA,SE2.E2_PREFIXO,SE2.E2_NUM)  SE2 ON SE2.E2_FORNECE=D2.D2_CLIENTE AND SE2.E2_LOJA = D2.D2_LOJA AND SE2.E2_PREFIXO=D2.D2_SERIORI AND SE2.E2_NUM=D2.D2_NFORI
 WHERE D2.D2_FILIAL = '01' AND D2.D2_TIPO = 'D' AND D2.D2_EMISSAO >='20110101' AND D2.D2_EMISSAO <='20110831' AND D2.D_E_L_E_T_=' ' ;
 
select WN_FOB_R,* from SWN010 where WN_HAWB = '000312/10'

select D1_TIPO_NF,D1_CUSTO,* from SD1010 where D1_DOC = '002442';