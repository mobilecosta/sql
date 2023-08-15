select FT_NFISCAL, FT_MVALCOF, FT_ITEM, FT_BASECOF, FT_ALIQCOF - 7.60 AS FT_MALQCOF_C, FT_ALIQCOF, FT_ALIQPIS,
       FT_MALQCOF, FT_MVALCOF, *
  from SFT010
 where D_E_L_E_T_ = ' ' and FT_ALIQCOF > 0 and (FT_ALIQCOF <> 7.6 AND FT_ALIQCOF <> 3)
   and LEFT(FT_ENTRADA, 6) = '201209'
 order by FT_ENTRADA, FT_NFISCAL;

-- Copia dos registros afetados
select * into SFT010_PIS092012 from SFT010
 where D_E_L_E_T_ = ' ' and FT_ALIQCOF > 0 AND FT_ALIQPIS > 0
   and ((FT_ALIQPIS <> 1.65 AND FT_ALIQPIS <> 0.65) OR (FT_ALIQCOF <> 7.6 AND FT_ALIQCOF <> 3))
   and LEFT(FT_ENTRADA, 6) = '201209';

-- Atualização do COFINS - 09/2012
select FT_ALIQCOF - 7.60 AS FT_MALQCOF, ROUND(FT_BASECOF * (FT_ALIQCOF - 7.60) / 100, 2) AS FT_MVALCOF, * from SFT010
 where D_E_L_E_T_ = ' ' and FT_ALIQCOF > 0 and (FT_ALIQCOF <> 7.6 AND FT_ALIQCOF <> 3)
   and LEFT(FT_ENTRADA, 6) = '201209';

update SFT010
   set FT_MALQCOF = FT_ALIQCOF - 7.60, FT_MVALCOF = ROUND(FT_BASECOF * (FT_ALIQCOF - 7.60) / 100, 2)
  from SFT010
 where D_E_L_E_T_ = ' ' and FT_ALIQCOF > 0 and (FT_ALIQCOF <> 7.6 AND FT_ALIQCOF <> 3)
   and LEFT(FT_ENTRADA, 6) = '201209';

-- Atualização do PIS - 09/2012
select ROUND(FT_BASEPIS * (1.65 / 100), 2) as FT_VALPIS_C, FT_VALPIS, * from SFT010
 where D_E_L_E_T_ = ' ' and FT_ALIQPIS > 0
   and (FT_ALIQPIS <> 1.65 AND FT_ALIQPIS <> 0.65)
   and LEFT(FT_ENTRADA, 6) = '201209';

update SFT010
   set FT_ALIQPIS = 1.65, FT_VALPIS = ROUND(FT_BASEPIS * (1.65 / 100), 2)
 where D_E_L_E_T_ = ' ' and FT_ALIQPIS > 0
   and (FT_ALIQPIS <> 1.65 AND FT_ALIQPIS <> 0.65)
   and LEFT(FT_ENTRADA, 6) = '201209';