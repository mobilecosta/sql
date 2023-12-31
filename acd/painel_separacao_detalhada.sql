ALTER TABLE SC5990 ADD C5_XHORA VARCHAR(8);
ALTER TABLE SF2990 ADD F2_DAUTNFE VARCHAR(8);
ALTER TABLE SF2990 ADD F2_HAUTNFE VARCHAR(5);

-- SELECT VALIDA��O
DECLARE @C5_FILIAL VARCHAR(2);
SET @C5_FILIAL = '01';
-- SET @C5_FILIAL = '010101';

DECLARE @A1_FILIAL VARCHAR(2);
SET @A1_FILIAL = '  ';
-- SET @A1_FILIAL = '01';

DECLARE @CB1_FILIAL VARCHAR(2);
SET @CB1_FILIAL = '01';
-- SET @CB1_FILIAL = '  ;'

DECLARE @CB8_FILIAL VARCHAR(2);
SET @CB8_FILIAL = '01';
-- SET @CB8_FILIAL = '010101;'

DECLARE @CB9_FILIAL VARCHAR(2);
SET @CB9_FILIAL = '01';
-- SET @CB9_FILIAL = '010101;'

DECLARE @CBG_FILIAL VARCHAR(2);
SET @CBG_FILIAL = '01';
-- SET @CBG_FILIAL = '010101;'

DECLARE @I_C5_EMISSAO VARCHAR(8);
SET @I_C5_EMISSAO = '20130101';
DECLARE @F_C5_EMISSAO VARCHAR(8);
SET @F_C5_EMISSAO = '20141231';

SELECT SC5.C5_NUM, SC5.C5_CLIENTE, SC5.C5_LOJACLI, SA1.A1_NOME, SC5.C5_EMISSAO, SC5.C5_XHORA, SC5.C6_TOTAL,
      CASE WHEN SC5.C9_BLEST > 0 THEN 'Bloqueio Estoque' ELSE
      CASE WHEN SC5.C9_BLCRED > 0 THEN 'Bloqueio Cr�dito' ELSE
      CASE WHEN SC5.C6_SALDO = 0 THEN 'Atendido Total' ELSE
	  CASE WHEN CB7.CB7_ORDSEP IS NULL THEN 'Aguardando OS' ELSE
	  CASE WHEN SC5.C6_SALDO <> SC5.C6_QTDVEN THEN 'Atendido Parcialmente' ELSE 'Na Expedi��o' END END END END END AS C5_STATUS,
      CB7.CB7_ORDSEP, CB7.CB7_DTEMIS, CB7.CB7_HREMIS, CB7.CB7_CODOPE, CB7.CB1_NOME,
      CAST(CASE WHEN CB7.CB7_STATUS = '0' Then '0-OS Gerada      ' ELSE
           CASE WHEN CB7.CB7_STATUS = '1' Then '1-Separando      ' ELSE
           CASE WHEN CB7.CB7_STATUS = '2' Then '2-Separa��o Final' ELSE
           CASE WHEN CB7.CB7_STATUS = '3' Then '3-Embalando      ' ELSE
           CASE WHEN CB7.CB7_STATUS = '4' Then '4-Volume Montado ' ELSE
           CASE WHEN CB7.CB7_STATUS = '5' Then '5-Nota Gerada    ' ELSE
           CASE WHEN CB7.CB7_STATUS = '6' Then '6-Nota Impressa  ' ELSE
           CASE WHEN CB7.CB7_STATUS = '7' Then '7-Volume Impresso' ELSE
           CASE WHEN CB7.CB7_STATUS = '8' Then '8-Embarcado      ' ELSE
           CASE WHEN CB7.CB7_STATUS = '9' Then '9-Finalizado     ' ELSE '' END END END END END END END END END END AS VARCHAR(20)) AS CB7_STATUS,
      COALESCE(CB7.CB9_DISPID, '') AS CB9_DISPID, COALESCE(CB7.CB9_VOLUME, '') AS CB9_VOLUME, CB9.CBG_CODOPE AS CB1_OPE_V, CB9.CB1_NOME AS CB1_NOME_V, CB9.CBG_DATAI, CB9.CBG_HORAI, CB9.CB9_QTESEP, CB9.CB9_QTEEMB,
      CB9.CB9_ITESEP, CB9.CB9_ITEEMB, CB7.CB6_VOLUME, CB7.CB6_XIMP, CB9.CBG_DATAF, CB9.CBG_HORAF,
      CB9.CBG_DATAFI, CB9.CBG_HORAFI, CB9.CBG_DATAFF, CB9.CBG_HORAFF, CB9.CB9_NUMSER, CB9.CB9_DOC, SF2.F2_DAUTNFE, SF2.F2_HAUTNFE,
      SF2.F2_VOLUME1 + SF2.F2_VOLUME2 + SF2.F2_VOLUME3 + SF2.F2_VOLUME4 AS F2_VOLUME, SF2.F2_VALMERC
  FROM (SELECT SC5.C5_FILIAL, SC5.C5_NUM, MIN(SC5.C5_CLIENTE) AS C5_CLIENTE, MIN(SC5.C5_LOJACLI) AS C5_LOJACLI,
               MIN(SC5.C5_EMISSAO) AS C5_EMISSAO, MIN(SC5.C5_XHORA) AS C5_XHORA, SUM(ROUND(SC6.C6_VALOR, 2)) AS C6_TOTAL, SUM(SC6.C6_QTDVEN) AS C6_QTDVEN,
			   SUM(CASE WHEN SC6.C6_BLQ <> 'R' THEN SC6.C6_QTDVEN - SC6.C6_QTDENT ELSE 0 END) AS C6_SALDO,
			   SUM(CASE WHEN SC9.C9_BLEST <> '  ' AND SC9.C9_BLEST <> '10' AND SC9.C9_NFISCAL = ' ' THEN SC9.C9_QTDLIB ELSE 0 END) AS C9_BLEST,
			   SUM(CASE WHEN SC9.C9_BLCRED <> '  ' AND SC9.C9_BLCRED <> '10' AND SC9.C9_NFISCAL = ' ' THEN SC9.C9_QTDLIB ELSE 0 END) AS C9_BLCRED
          FROM SC5990 SC5
		  JOIN SC6990 SC6 ON SC6.D_E_L_E_T_ = ' ' AND SC6.C6_FILIAL = SC5.C5_FILIAL AND SC6.C6_NUM = SC5.C5_NUM
		  JOIN SC9990 SC9 ON SC9.D_E_L_E_T_ = ' ' AND SC9.C9_FILIAL = SC5.C5_FILIAL AND SC9.C9_PEDIDO = SC5.C5_NUM
		 WHERE SC5.D_E_L_E_T_ = ' ' AND SC5.C5_FILIAL = @C5_FILIAL AND SC5.C5_EMISSAO BETWEEN @I_C5_EMISSAO AND @F_C5_EMISSAO
		 GROUP BY SC5.C5_FILIAL, SC5.C5_NUM) SC5
  LEFT JOIN SA1990 SA1 ON SA1.D_E_L_E_T_ = ' ' AND SA1.A1_FILIAL = @A1_FILIAL AND SA1.A1_COD = SC5.C5_CLIENTE AND SA1.A1_LOJA = SC5.C5_LOJACLI
  LEFT JOIN (SELECT CB7.CB7_FILIAL, CB7.CB7_ORDSEP, MAX(CB8_PEDIDO) CB8_PEDIDO, MIN(CB7.CB7_STATUS) AS CB7_STATUS,
                    MIN(CB7.CB7_DTEMIS) AS CB7_DTEMIS, MIN(CB7.CB7_HREMIS) AS CB7_HREMIS, MIN(CB7.CB7_CODOPE) AS CB7_CODOPE,
		 	        MIN(CB1.CB1_NOME) AS CB1_NOME, MIN(CB9.CB9_VOLUMES) AS CB9_VOLUME, MIN(CB9.CB9_DISPIDS) AS CB9_DISPID,
					MIN(CB6.CB6_VOLUMES) AS CB6_VOLUME, MIN(CB6.CB6_XIMP) AS CB6_XIMP 
               FROM CB8990 CB8
		       JOIN CB7990 CB7 ON CB8.D_E_L_E_T_ = ' ' AND CB7.CB7_FILIAL = CB8.CB8_FILIAL AND CB7.CB7_ORDSEP = CB8.CB8_ORDSEP
               LEFT JOIN CB1990 CB1 ON CB1.D_E_L_E_T_ = ' ' AND CB1.CB1_FILIAL = @CB1_FILIAL AND CB1.CB1_CODOPE = CB7.CB7_CODOPE
               LEFT JOIN (SELECT CB9.CB9_FILIAL, CB9.CB9_ORDSEP, CB9.CB9_DOC,
                                 CAST(LEFT(CB9_VOLUMES, LEN(CB9_VOLUMES) - 1) AS VARCHAR(255)) AS CB9_VOLUMES,
	                             CAST(LEFT(CB9_DISPIDS, LEN(CB9_DISPIDS) - 1) AS VARCHAR(255)) AS CB9_DISPIDS
                           FROM CB9990 CB9
                          CROSS APPLY (SELECT CB9_VOLUME + ','
                                         FROM CB9990 AS CB9C
                                        WHERE D_E_L_E_T_ = ' ' AND CB9_FILIAL = @CB9_FILIAL AND CB9_VOLUME <> '' AND CB9_QTESEP > 0
                                          AND CB9C.CB9_FILIAL = CB9.CB9_FILIAL AND CB9C.CB9_ORDSEP = CB9.CB9_ORDSEP
                                          AND CB9C.CB9_DOC = CB9.CB9_DOC
                                        GROUP BY CB9_VOLUME
                                          FOR XML PATH('')) CB9_VOL (CB9_VOLUMES)
                          CROSS APPLY (SELECT CB9_DISPID + ','
                                         FROM CB9990 AS CB9C
                                        WHERE D_E_L_E_T_ = ' ' AND CB9_FILIAL = @CB9_FILIAL AND CB9_DISPID <> '' AND CB9_QTESEP > 0
                                          AND CB9C.CB9_FILIAL = CB9.CB9_FILIAL AND CB9C.CB9_ORDSEP = CB9.CB9_ORDSEP
                                          AND CB9C.CB9_DOC = CB9.CB9_DOC
                                        GROUP BY CB9_DISPID
                                          FOR XML PATH('')) CB9_DISPID (CB9_DISPIDS)
                          WHERE D_E_L_E_T_ = ' ' AND CB9.CB9_FILIAL = @CB9_FILIAL AND CB9_QTESEP > 0
                       GROUP BY CB9_FILIAL, CB9_ORDSEP, CB9_DOC, CB9_VOLUMES, CB9_DISPIDS) CB9 ON CB9.CB9_FILIAL = CB7.CB7_FILIAL AND CB9.CB9_ORDSEP = CB7.CB7_ORDSEP
               LEFT JOIN (SELECT CB9.CB9_FILIAL, CB9.CB9_ORDSEP, COUNT(*) AS CB6_VOLUMES,
                                 COUNT(CASE WHEN CB6.CB6_XIMP = '1' THEN 1 ELSE NULL END) AS CB6_XIMP
                            FROM (SELECT CB9_FILIAL, CB9_ORDSEP, CB9_VOLUME FROM CB9990
                                   WHERE D_E_L_E_T_ = ' ' AND CB9_FILIAL = @CB9_FILIAL AND CB9_VOLUME <> '' AND CB9_QTESEP > 0
                                   GROUP BY CB9_FILIAL, CB9_ORDSEP, CB9_VOLUME) CB9
                            JOIN CB6990 CB6 ON CB6.CB6_FILIAL = CB9.CB9_FILIAL AND CB6.CB6_VOLUME = CB9.CB9_VOLUME
                            GROUP BY CB9.CB9_FILIAL, CB9.CB9_ORDSEP) CB6 ON CB6.CB9_FILIAL = CB7.CB7_FILIAL AND CB6.CB9_ORDSEP = CB7.CB7_ORDSEP
			     WHERE CB8.D_E_L_E_T_ = ' ' AND CB8.CB8_FILIAL = @CB8_FILIAL
	           GROUP BY CB7.CB7_FILIAL, CB7.CB7_ORDSEP) CB7 ON CB7.CB7_FILIAL = SC5.C5_FILIAL AND CB7.CB8_PEDIDO = SC5.C5_NUM
  LEFT JOIN (SELECT CB9.CB9_FILIAL, CB9.CB9_ORDSEP, MIN(CBG.CBG_CODOPE) AS CBG_CODOPE, MIN(CBG.CB1_NOME) AS CB1_NOME,
                    COUNT(CB9.CB9_QTESEP) AS CB9_ITESEP, COUNT(CASE WHEN CB9.CB9_QTEEMB > 0 THEN 1 ELSE NULL END) AS CB9_ITEEMB,
					SUM(CB9.CB9_QTESEP) AS CB9_QTESEP, SUM(CB9.CB9_QTEEMB) AS CB9_QTEEMB,
					MAX(LEFT(CBG.CBG_DTHRI, 8)) AS CBG_DATAI, MAX(RIGHT(CBG.CBG_DTHRI, 8)) AS CBG_HORAI,
					MAX(LEFT(CBG.CBG_DTHRF, 8)) AS CBG_DATAF, MAX(RIGHT(CBG.CBG_DTHRF, 8)) AS CBG_HORAF,
					CB9.CB9_NUMSER, CB9.CB9_DOC,
					MAX(LEFT(CBG.CBG_DTHRINF, 8)) AS CBG_DATAFI, MAX(RIGHT(CBG.CBG_DTHRINF, 8)) AS CBG_HORAFI,
					MAX(LEFT(CBG.CBG_DTHRFNF, 8)) AS CBG_DATAFF, MAX(RIGHT(CBG.CBG_DTHRFNF, 8)) AS CBG_HORAFF
               FROM CB9990 CB9
		    LEFT JOIN (SELECT CBG.CBG_FILIAL, CBG.CBG_ORDSEP, MIN(CBG.CBG_CODOPE) AS CBG_CODOPE, MIN(CB1.CB1_NOME) AS CB1_NOME,
			                   MIN(CBG_63.CBG_DTHRI) AS CBG_DTHRI, MIN(CBG_64.CBG_DTHRF) AS CBG_DTHRF,
			                   MIN(CBG_54.CBG_DTHRINF) AS CBG_DTHRINF, MAX(CBG_54.CBG_DTHRFNF) AS CBG_DTHRFNF
			              FROM CBG990 CBG
                       LEFT JOIN CB1990 CB1 ON CB1.D_E_L_E_T_ = ' ' AND CB1.CB1_FILIAL = @CB1_FILIAL AND CB1.CB1_CODOPE = CBG.CBG_CODOPE
					   LEFT JOIN (SELECT CBG_FILIAL, CBG_ORDSEP, MIN(CBG_DATA + CBG_HORA) AS CBG_DTHRINF, MAX(CBG_DATA + CBG_HORA) AS CBG_DTHRFNF
					                FROM CBG990
					               WHERE D_E_L_E_T_ = ' ' AND CBG_FILIAL = @CBG_FILIAL AND CBG_EVENTO = '54'
								   GROUP BY CBG_FILIAL, CBG_ORDSEP) CBG_54 ON CBG_54.CBG_FILIAL = CBG.CBG_FILIAL AND CBG_54.CBG_ORDSEP = CBG.CBG_ORDSEP
					   LEFT JOIN (SELECT CBG_FILIAL, CBG_ORDSEP, MIN(CBG_DATA + CBG_HORA) AS CBG_DTHRI
					                FROM CBG990
					               WHERE D_E_L_E_T_ = ' ' AND CBG_FILIAL = @CBG_FILIAL AND CBG_EVENTO = '63'
								   GROUP BY CBG_FILIAL, CBG_ORDSEP) CBG_63 ON CBG_63.CBG_FILIAL = CBG.CBG_FILIAL AND CBG_63.CBG_ORDSEP = CBG.CBG_ORDSEP
					   LEFT JOIN (SELECT CBG_FILIAL, CBG_ORDSEP, MAX(CBG_DATA + CBG_HORA) AS CBG_DTHRF
					                FROM CBG990
					               WHERE D_E_L_E_T_ = ' ' AND CBG_FILIAL = @CBG_FILIAL AND CBG_EVENTO = '64'
								   GROUP BY CBG_FILIAL, CBG_ORDSEP) CBG_64 ON CBG_64.CBG_FILIAL = CBG.CBG_FILIAL AND CBG_64.CBG_ORDSEP = CBG.CBG_ORDSEP
					       WHERE CBG.D_E_L_E_T_ = ' ' AND CBG.CBG_FILIAL = @CBG_FILIAL AND CBG.CBG_EVENTO IN ('63', '64', '54')
						 GROUP BY CBG.CBG_FILIAL, CBG.CBG_ORDSEP) CBG ON CBG.CBG_FILIAL = CB9.CB9_FILIAL AND CBG.CBG_ORDSEP = CB9.CB9_ORDSEP
              WHERE CB9.D_E_L_E_T_ = ' ' AND CB9.CB9_FILIAL = @CB9_FILIAL AND CB9.CB9_DISPID <> '' AND CB9.CB9_QTESEP > 0
              GROUP BY CB9.CB9_FILIAL, CB9.CB9_ORDSEP, CB9.CB9_NUMSER, CB9.CB9_DOC) CB9 ON CB9.CB9_FILIAL = SC5.C5_FILIAL AND CB9.CB9_ORDSEP = CB7.CB7_ORDSEP
  LEFT JOIN SF2990 SF2 ON SF2.D_E_L_E_T_ = ' ' AND SF2.F2_FILIAL = CB9.CB9_FILIAL AND SF2.F2_SERIE = CB9.CB9_NUMSER AND SF2.F2_DOC = CB9.CB9_DOC;

-- INSTRU��O PARA SUBSTITUI��O
SELECT SC5.C5_NUM, SC5.C5_CLIENTE, SC5.C5_LOJACLI, SA1.A1_NOME, SC5.C5_EMISSAO, SC5.C5_XHORA, SC5.C6_TOTAL,
       CASE WHEN SC5.C9_BLEST > 0 THEN 'Bloqueio Estoque' ELSE
       CASE WHEN SC5.C9_BLCRED > 0 THEN 'Bloqueio Cr�dito' ELSE
       CASE WHEN SC5.C6_SALDO = 0 THEN 'Atendido Total' ELSE
	   CASE WHEN CB7.CB7_ORDSEP IS NULL THEN 'Aguardando OS' ELSE
	   CASE WHEN SC5.C6_SALDO <> SC5.C6_QTDVEN THEN 'Atendido Parcialmente' ELSE 'Na Expedi��o' END END END END END AS C5_STATUS,
       CB7.CB7_ORDSEP, CB7.CB7_DTEMIS, CB7.CB7_HREMIS, CB7.CB7_CODOPE, CB7.CB1_NOME,
       CAST(CASE WHEN CB7.CB7_STATUS = '0' Then '0-OS Gerada      ' ELSE
            CASE WHEN CB7.CB7_STATUS = '1' Then '1-Separando      ' ELSE
            CASE WHEN CB7.CB7_STATUS = '2' Then '2-Separa��o Final' ELSE
            CASE WHEN CB7.CB7_STATUS = '3' Then '3-Embalando      ' ELSE
            CASE WHEN CB7.CB7_STATUS = '4' Then '4-Volume Montado ' ELSE
            CASE WHEN CB7.CB7_STATUS = '5' Then '5-Nota Gerada    ' ELSE
            CASE WHEN CB7.CB7_STATUS = '6' Then '6-Nota Impressa  ' ELSE
            CASE WHEN CB7.CB7_STATUS = '7' Then '7-Volume Impresso' ELSE
            CASE WHEN CB7.CB7_STATUS = '8' Then '8-Embarcado      ' ELSE
            CASE WHEN CB7.CB7_STATUS = '9' Then '9-Finalizado     ' ELSE '' END END END END END END END END END END AS VARCHAR(20)) AS CB7_STATUS,
       COALESCE(CB7.CB9_DISPID, '') AS CB9_DISPID, COALESCE(CB7.CB9_VOLUME, '') AS CB9_VOLUME, CB9.CBG_CODOPE AS CB1_OPE_V, CB9.CB1_NOME AS CB1_NOME_V, CB9.CBG_DATAI, CB9.CBG_HORAI, CB9.CB9_QTESEP, CB9.CB9_QTEEMB,
       CB9.CB9_ITESEP, CB9.CB9_ITEEMB, CB7.CB6_VOLUME, CB7.CB6_XIMP, CB9.CBG_DATAF, CB9.CBG_HORAF,
       CB9.CBG_DATAFI, CB9.CBG_HORAFI, CB9.CBG_DATAFF, CB9.CBG_HORAFF, CB9.CB9_NUMSER, CB9.CB9_DOC, SF2.F2_DAUTNFE, SF2.F2_HAUTNFE,
       SF2.F2_VOLUME1 + SF2.F2_VOLUME2 + SF2.F2_VOLUME3 + SF2.F2_VOLUME4 AS F2_VOLUME, SF2.F2_VALMERC
  FROM (SELECT SC5.C5_FILIAL, SC5.C5_NUM, MIN(SC5.C5_CLIENTE) AS C5_CLIENTE, MIN(SC5.C5_LOJACLI) AS C5_LOJACLI,
               MIN(SC5.C5_EMISSAO) AS C5_EMISSAO, MIN(SC5.C5_XHORA) AS C5_XHORA, SUM(ROUND(SC6.C6_VALOR, 2)) AS C6_TOTAL, SUM(SC6.C6_QTDVEN) AS C6_QTDVEN,
			   SUM(CASE WHEN SC6.C6_BLQ <> 'R' THEN SC6.C6_QTDVEN - SC6.C6_QTDENT ELSE 0 END) AS C6_SALDO,
			   SUM(CASE WHEN SC9.C9_BLEST <> '  ' AND SC9.C9_BLEST <> '10' AND SC9.C9_NFISCAL = ' ' THEN SC9.C9_QTDLIB ELSE 0 END) AS C9_BLEST,
			   SUM(CASE WHEN SC9.C9_BLCRED <> '  ' AND SC9.C9_BLCRED <> '10' AND SC9.C9_NFISCAL = ' ' THEN SC9.C9_QTDLIB ELSE 0 END) AS C9_BLCRED
          FROM <ADVPL>RetSqlName("SC5")</ADVPL> SC5
		  JOIN <ADVPL>RetSqlName("SC6")</ADVPL> SC6 ON SC6.D_E_L_E_T_ = ' ' AND SC6.C6_FILIAL = SC5.C5_FILIAL AND SC6.C6_NUM = SC5.C5_NUM
		  JOIN <ADVPL>RetSqlName("SC9")</ADVPL> SC9 ON SC9.D_E_L_E_T_ = ' ' AND SC9.C9_FILIAL = SC5.C5_FILIAL AND SC9.C9_PEDIDO = SC5.C5_NUM
		 WHERE SC5.D_E_L_E_T_ = ' ' AND SC5.C5_FILIAL = '<ADVPL>xFilial("SC5")</ADVPL>' AND SC5.C5_EMISSAO BETWEEN @I_C5_EMISSAO@ AND @F_C5_EMISSAO@
		 GROUP BY SC5.C5_FILIAL, SC5.C5_NUM) SC5
  LEFT JOIN <ADVPL>RetSqlName("SA1")</ADVPL> SA1 ON SA1.D_E_L_E_T_ = ' ' AND SA1.A1_FILIAL = '<ADVPL>xFilial("SA1")</ADVPL>' AND SA1.A1_COD = SC5.C5_CLIENTE AND SA1.A1_LOJA = SC5.C5_LOJACLI
  LEFT JOIN (SELECT CB7.CB7_FILIAL, CB7.CB7_ORDSEP, MAX(CB8_PEDIDO) CB8_PEDIDO, MIN(CB7.CB7_STATUS) AS CB7_STATUS,
                    MIN(CB7.CB7_DTEMIS) AS CB7_DTEMIS, MIN(CB7.CB7_HREMIS) AS CB7_HREMIS, MIN(CB7.CB7_CODOPE) AS CB7_CODOPE,
		 	        MIN(CB1.CB1_NOME) AS CB1_NOME, MIN(CB9.CB9_VOLUMES) AS CB9_VOLUME, MIN(CB9.CB9_DISPIDS) AS CB9_DISPID,
					MIN(CB6.CB6_VOLUMES) AS CB6_VOLUME, MIN(CB6.CB6_XIMP) AS CB6_XIMP 
               FROM <ADVPL>RetSqlName("CB8")</ADVPL> CB8
		       JOIN <ADVPL>RetSqlName("CB7")</ADVPL> CB7 ON CB8.D_E_L_E_T_ = ' ' AND CB7.CB7_FILIAL = CB8.CB8_FILIAL AND CB7.CB7_ORDSEP = CB8.CB8_ORDSEP
               LEFT JOIN <ADVPL>RetSqlName("CB1")</ADVPL> CB1 ON CB1.D_E_L_E_T_ = ' ' AND CB1.CB1_FILIAL = '<ADVPL>xFilial("CB1")</ADVPL>' AND CB1.CB1_CODOPE = CB7.CB7_CODOPE
               LEFT JOIN (SELECT CB9.CB9_FILIAL, CB9.CB9_ORDSEP, CB9.CB9_DOC,
                                 CAST(LEFT(CB9_VOLUMES, LEN(CB9_VOLUMES) - 1) AS VARCHAR(255)) AS CB9_VOLUMES,
	                             CAST(LEFT(CB9_DISPIDS, LEN(CB9_DISPIDS) - 1) AS VARCHAR(255)) AS CB9_DISPIDS
                           FROM <ADVPL>RetSqlName("CB9")</ADVPL> CB9
                          CROSS APPLY (SELECT CB9_VOLUME + ','
                                         FROM <ADVPL>RetSqlName("CB9")</ADVPL> AS CB9C
                                        WHERE D_E_L_E_T_ = ' ' AND CB9_FILIAL = '<ADVPL>xFilial("CB1")</ADVPL>' AND CB9_VOLUME <> '' AND CB9_QTESEP > 0
                                          AND CB9C.CB9_FILIAL = CB9.CB9_FILIAL AND CB9C.CB9_ORDSEP = CB9.CB9_ORDSEP
                                          AND CB9C.CB9_DOC = CB9.CB9_DOC
                                        GROUP BY CB9_VOLUME
                                          FOR XML PATH('')) CB9_VOL (CB9_VOLUMES)
                          CROSS APPLY (SELECT CB9_DISPID + ','
                                         FROM <ADVPL>RetSqlName("CB9")</ADVPL> AS CB9C
                                        WHERE D_E_L_E_T_ = ' ' AND CB9_FILIAL = '<ADVPL>xFilial("CB9")</ADVPL>' AND CB9_DISPID <> '' AND CB9_QTESEP > 0
                                          AND CB9C.CB9_FILIAL = CB9.CB9_FILIAL AND CB9C.CB9_ORDSEP = CB9.CB9_ORDSEP
                                          AND CB9C.CB9_DOC = CB9.CB9_DOC
                                        GROUP BY CB9_DISPID
                                          FOR XML PATH('')) CB9_DISPID (CB9_DISPIDS)
                          WHERE D_E_L_E_T_ = ' ' AND CB9.CB9_FILIAL = '<ADVPL>xFilial("CB9")</ADVPL>' AND CB9_QTESEP > 0
                       GROUP BY CB9_FILIAL, CB9_ORDSEP, CB9_DOC, CB9_VOLUMES, CB9_DISPIDS) CB9 ON CB9.CB9_FILIAL = CB7.CB7_FILIAL AND CB9.CB9_ORDSEP = CB7.CB7_ORDSEP
               LEFT JOIN (SELECT CB9.CB9_FILIAL, CB9.CB9_ORDSEP, COUNT(*) AS CB6_VOLUMES,
                                 COUNT(CASE WHEN CB6.CB6_XIMP = '1' THEN 1 ELSE NULL END) AS CB6_XIMP
                            FROM (SELECT CB9_FILIAL, CB9_ORDSEP, CB9_VOLUME FROM <ADVPL>RetSqlName("CB9")</ADVPL>
                                   WHERE D_E_L_E_T_ = ' ' AND CB9_FILIAL = '<ADVPL>xFilial("CB9")</ADVPL>' AND CB9_VOLUME <> '' AND CB9_QTESEP > 0
                                   GROUP BY CB9_FILIAL, CB9_ORDSEP, CB9_VOLUME) CB9
                            JOIN <ADVPL>RetSqlName("CB6")</ADVPL> CB6 ON CB6.CB6_FILIAL = CB9.CB9_FILIAL AND CB6.CB6_VOLUME = CB9.CB9_VOLUME
                            GROUP BY CB9.CB9_FILIAL, CB9.CB9_ORDSEP) CB6 ON CB6.CB9_FILIAL = CB7.CB7_FILIAL AND CB6.CB9_ORDSEP = CB7.CB7_ORDSEP
			     WHERE CB8.D_E_L_E_T_ = ' ' AND CB8.CB8_FILIAL = '<ADVPL>xFilial("CB8")</ADVPL>'
	           GROUP BY CB7.CB7_FILIAL, CB7.CB7_ORDSEP) CB7 ON CB7.CB7_FILIAL = SC5.C5_FILIAL AND CB7.CB8_PEDIDO = SC5.C5_NUM
  LEFT JOIN (SELECT CB9.CB9_FILIAL, CB9.CB9_ORDSEP, MIN(CBG.CBG_CODOPE) AS CBG_CODOPE, MIN(CBG.CB1_NOME) AS CB1_NOME,
                    COUNT(CB9.CB9_QTESEP) AS CB9_ITESEP, COUNT(CASE WHEN CB9.CB9_QTEEMB > 0 THEN 1 ELSE NULL END) AS CB9_ITEEMB,
					SUM(CB9.CB9_QTESEP) AS CB9_QTESEP, SUM(CB9.CB9_QTEEMB) AS CB9_QTEEMB,
					MAX(LEFT(CBG.CBG_DTHRI, 8)) AS CBG_DATAI, MAX(RIGHT(CBG.CBG_DTHRI, 8)) AS CBG_HORAI,
					MAX(LEFT(CBG.CBG_DTHRF, 8)) AS CBG_DATAF, MAX(RIGHT(CBG.CBG_DTHRF, 8)) AS CBG_HORAF,
					CB9.CB9_NUMSER, CB9.CB9_DOC,
					MAX(LEFT(CBG.CBG_DTHRINF, 8)) AS CBG_DATAFI, MAX(RIGHT(CBG.CBG_DTHRINF, 8)) AS CBG_HORAFI,
					MAX(LEFT(CBG.CBG_DTHRFNF, 8)) AS CBG_DATAFF, MAX(RIGHT(CBG.CBG_DTHRFNF, 8)) AS CBG_HORAFF
               FROM <ADVPL>RetSqlName("CB9")</ADVPL> CB9
		    LEFT JOIN (SELECT CBG.CBG_FILIAL, CBG.CBG_ORDSEP, MIN(CBG.CBG_CODOPE) AS CBG_CODOPE, MIN(CB1.CB1_NOME) AS CB1_NOME,
			                   MIN(CBG_63.CBG_DTHRI) AS CBG_DTHRI, MIN(CBG_64.CBG_DTHRF) AS CBG_DTHRF,
			                   MIN(CBG_54.CBG_DTHRINF) AS CBG_DTHRINF, MAX(CBG_54.CBG_DTHRFNF) AS CBG_DTHRFNF
			              FROM <ADVPL>RetSqlName("CBG")</ADVPL> CBG
                       LEFT JOIN <ADVPL>RetSqlName("CB1")</ADVPL> CB1 ON CB1.D_E_L_E_T_ = ' ' AND CB1.CB1_FILIAL = '<ADVPL>xFilial("CB1")</ADVPL>' AND CB1.CB1_CODOPE = CBG.CBG_CODOPE
					   LEFT JOIN (SELECT CBG_FILIAL, CBG_ORDSEP, MIN(CBG_DATA + CBG_HORA) AS CBG_DTHRINF, MAX(CBG_DATA + CBG_HORA) AS CBG_DTHRFNF
					                FROM <ADVPL>RetSqlName("CBG")</ADVPL>
					               WHERE D_E_L_E_T_ = ' ' AND CBG_FILIAL = '<ADVPL>xFilial("CBG")</ADVPL>' AND CBG_EVENTO = '54'
								   GROUP BY CBG_FILIAL, CBG_ORDSEP) CBG_54 ON CBG_54.CBG_FILIAL = CBG.CBG_FILIAL AND CBG_54.CBG_ORDSEP = CBG.CBG_ORDSEP
					   LEFT JOIN (SELECT CBG_FILIAL, CBG_ORDSEP, MIN(CBG_DATA + CBG_HORA) AS CBG_DTHRI
					                FROM <ADVPL>RetSqlName("CBG")</ADVPL>
					               WHERE D_E_L_E_T_ = ' ' AND CBG_FILIAL = '<ADVPL>xFilial("CBG")</ADVPL>' AND CBG_EVENTO = '63'
								   GROUP BY CBG_FILIAL, CBG_ORDSEP) CBG_63 ON CBG_63.CBG_FILIAL = CBG.CBG_FILIAL AND CBG_63.CBG_ORDSEP = CBG.CBG_ORDSEP
					   LEFT JOIN (SELECT CBG_FILIAL, CBG_ORDSEP, MAX(CBG_DATA + CBG_HORA) AS CBG_DTHRF
					                FROM <ADVPL>RetSqlName("CBG")</ADVPL>
					               WHERE D_E_L_E_T_ = ' ' AND CBG_FILIAL = '<ADVPL>xFilial("CBG")</ADVPL>' AND CBG_EVENTO = '64'
								   GROUP BY CBG_FILIAL, CBG_ORDSEP) CBG_64 ON CBG_64.CBG_FILIAL = CBG.CBG_FILIAL AND CBG_64.CBG_ORDSEP = CBG.CBG_ORDSEP
					       WHERE CBG.D_E_L_E_T_ = ' ' AND CBG.CBG_FILIAL = '<ADVPL>xFilial("CBG")</ADVPL>' AND CBG.CBG_EVENTO IN ('63', '64', '54')
						 GROUP BY CBG.CBG_FILIAL, CBG.CBG_ORDSEP) CBG ON CBG.CBG_FILIAL = CB9.CB9_FILIAL AND CBG.CBG_ORDSEP = CB9.CB9_ORDSEP
              WHERE CB9.D_E_L_E_T_ = ' ' AND CB9.CB9_FILIAL = '<ADVPL>xFilial("CB9")</ADVPL>' AND CB9.CB9_DISPID <> '' AND CB9.CB9_QTESEP > 0
              GROUP BY CB9.CB9_FILIAL, CB9.CB9_ORDSEP, CB9.CB9_NUMSER, CB9.CB9_DOC) CB9 ON CB9.CB9_FILIAL = SC5.C5_FILIAL AND CB9.CB9_ORDSEP = CB7.CB7_ORDSEP
  LEFT JOIN <ADVPL>RetSqlName("SF2")</ADVPL> SF2 ON SF2.D_E_L_E_T_ = ' ' AND SF2.F2_FILIAL = CB9.CB9_FILIAL AND SF2.F2_SERIE = CB9.CB9_NUMSER AND SF2.F2_DOC = CB9.CB9_DOC;