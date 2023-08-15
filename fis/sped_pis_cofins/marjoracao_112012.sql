select FT_ALIQCOF - 7.60 AS AliqMarjoC, ROUND(FT_BASECOF * (FT_ALIQCOF - 7.60) / 100, 2) AS ValorMarjoC,
       FT_NFISCAL As NotaFiscal, FT_ITEM as Item, FT_BASECOF As BaseCofins, FT_ALIQCOF As AliquotaCofins
  from SFT010
 where D_E_L_E_T_ = ' ' and FT_ALIQCOF > 0 and FT_ALIQCOF <> 7.6 AND FT_MVALCOF = 0
   and LEFT(FT_ENTRADA, 6) = '201211'
 order by FT_ENTRADA, FT_NFISCAL;

update SFT010
   set FT_MALQCOF = FT_ALIQCOF - 7.60, 
       FT_MVALCOF = ROUND(FT_BASECOF * (FT_ALIQCOF - 7.60) / 100, 2)
  from SFT010
 where D_E_L_E_T_ = ' ' and FT_ALIQCOF > 0 and FT_ALIQCOF <> 7.6 
   and FT_MVALCOF = 0
   and LEFT(FT_ENTRADA, 6) = '201211';

-- Notas Pis
select FT_NFISCAL As Nota, FT_ITEM As Item,
       ROUND(FT_BASEPIS * (1.65 / 100), 2) As Pis_165, FT_VALPIS As PisGerado
  from SFT010
 where D_E_L_E_T_ = ' ' and FT_ALIQPIS > 0
   and (FT_ALIQPIS <> 1.65 AND FT_ALIQPIS <> 0.65)
   and LEFT(FT_ENTRADA, 6) = '201211';

select LEN(FT_CHVNFE), FT_CFOP, * from SFT010 WHERE D_E_L_E_T_ = ' ' AND FT_NFISCAL in ('000006644', '000006646', '000006647')
select LEN(F3_CHVNFE), * from SF3010 WHERE D_E_L_E_T_ = ' ' AND F3_NFISCAL in ('000006644', '000006646', '000006647')

update SFT010 set FT_CHVNFE = '' WHERE D_E_L_E_T_ = ' ' AND FT_NFISCAL in ('000006644', '000006646', '000006647')
update SF3010 set F3_CHVNFE = '' WHERE D_E_L_E_T_ = ' ' AND F3_NFISCAL in ('000006644', '000006646', '000006647')

select * from SPED050 WHERE NFE_ID IN ('2  000006644', '2  000006646', '2  000006647');

-- Tira a marjoração se a alíquota do cofins for 7.6
SELECT FT_ALIQCOF - 7.60 AS AliqMarjoC, ROUND(FT_BASECOF * (FT_ALIQCOF - 7.60) / 100, 2) AS ValorMarjoC,
       FT_NFISCAL As NotaFiscal, FT_ITEM as Item, FT_BASECOF As BaseCofins, FT_ALIQCOF As AliquotaCofins
  from SFT010
 WHERE D_E_L_E_T_ = ' ' AND LEFT(FT_ENTRADA, 6) = '201211' AND FT_ALIQCOF = 7.6 AND FT_MALQCOF = 1; 

UPDATE SFT010 SET FT_MALQCOF = 0 
 WHERE D_E_L_E_T_ = ' ' AND LEFT(FT_ENTRADA, 6) = '201211' AND FT_ALIQCOF = 7.6 AND FT_MALQCOF = 1;
 