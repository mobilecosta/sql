-- Notas Cofins
select FT_ALIQCOF - 7.60 AS AliqMarjoC, ROUND(FT_BASECOF * (FT_ALIQCOF - 7.60) / 100, 2) AS ValorMarjoC,
       FT_NFISCAL As NotaFiscal, FT_ITEM as Item, FT_BASECOF As BaseCofins, FT_ALIQCOF As AliquotaCofins
  from SFT010
 where D_E_L_E_T_ = ' ' and FT_ALIQCOF > 0 and FT_ALIQCOF <> 7.6 AND FT_MVALCOF > 0
   and LEFT(FT_ENTRADA, 6) = '201212'
 order by FT_ENTRADA, FT_NFISCAL;

update SFT010
   set FT_MALQCOF = FT_ALIQCOF - 7.60, 
       FT_MVALCOF = ROUND(FT_BASECOF * (FT_ALIQCOF - 7.60) / 100, 2)
  from SFT010
 where D_E_L_E_T_ = ' ' and FT_ALIQCOF > 0 and FT_ALIQCOF <> 7.6
   and LEFT(FT_ENTRADA, 6) = '201212';

-- Notas Pis
select FT_NFISCAL As Nota, FT_ITEM As Item,
       ROUND(FT_BASEPIS * (1.65 / 100), 2) As Pis_165, FT_VALPIS As PisGerado, FT_ALIQPIS, FT_OBSERV
  from SFT010
 where D_E_L_E_T_ = ' ' and FT_ALIQPIS > 0
   and ((FT_ALIQPIS <> 1.65 AND FT_ALIQPIS <> 0.65) OR FT_OBSERV LIKE '%PIS 2.3%')
   and LEFT(FT_ENTRADA, 6) = '201212' AND FT_DTCANC = '';

update SFT010
   set FT_VALPIS = ROUND(FT_BASEPIS * (1.65 / 100), 2), FT_ALIQPIS = 1.65,
       FT_OBSERV = 'PIS 2.3%'
 where D_E_L_E_T_ = ' ' and FT_ALIQPIS > 0
   and (FT_ALIQPIS <> 1.65 AND FT_ALIQPIS <> 0.65)
   and LEFT(FT_ENTRADA, 6) = '201212' AND FT_DTCANC = '';