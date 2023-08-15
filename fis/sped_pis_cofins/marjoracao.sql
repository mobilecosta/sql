select FT_NFISCAL, FT_MVALCOF, FT_ITEM, FT_BASECOF, FT_ALIQCOF - 7.60 AS FT_MALQCOF_C, FT_ALIQCOF, FT_ALIQPIS, 
       FT_MALQCOF, FT_MVALCOF, * 
  from SFT010
 where D_E_L_E_T_ = ' ' and FT_ALIQCOF > 0 AND FT_ALIQPIS > 0
   and ((FT_ALIQPIS <> 1.65 AND FT_ALIQPIS <> 0.65) OR (FT_ALIQCOF <> 7.6 AND FT_ALIQCOF <> 3))
   and LEFT(FT_ENTRADA, 6) = '201208'
 order by FT_ENTRADA, FT_NFISCAL;

-- Marjoração do COFINS
update SFT010
   set FT_MALQCOF = FT_ALIQCOF - 7.60, FT_MVALCOF = FT_BASECOF * (FT_ALIQCOF - 7.60) / 100
  from SFT010
 where D_E_L_E_T_ = ' ' and FT_ALIQCOF > 0 AND FT_ALIQPIS > 0
   and ((FT_ALIQPIS <> 1.65 AND FT_ALIQPIS <> 0.65) OR (FT_ALIQCOF <> 7.6 AND FT_ALIQCOF <> 3))
   and LEFT(FT_ENTRADA, 6) = '201208';

-- Aliquota do PIS
select * into SFT010_PIS082012 from SFT010
 where D_E_L_E_T_ = ' ' and FT_ALIQPIS > 0
   and (FT_ALIQPIS <> 1.65 AND FT_ALIQPIS <> 0.65)
   and LEFT(FT_ENTRADA, 6) = '201208';   

-- Base Copiada
select FT_ITEM, FT_BASEPIS, FT_ALIQPIS, FT_VALPIS, * from SFT010_PIS082012;

-- Altera alíquotas diferente de 1.65
update SFT010 
   set FT_ALIQPIS = 1.65, FT_VALPIS = ROUND(FT_BASEPIS * (1.65 / 100), 2)
 where D_E_L_E_T_ = ' ' and FT_ALIQPIS > 0
   and (FT_ALIQPIS <> 1.65 AND FT_ALIQPIS <> 0.65)
   and LEFT(FT_ENTRADA, 6) = '201208';   

-- Conferencia
select FT_NFISCAL, FT_ITEM, FT_BASEPIS, FT_ALIQPIS, FT_VALPIS from SFT010
 where R_E_C_N_O_ in (select R_E_C_N_O_ from SFT010_PIS082012);

-- Arredondamento
update SFT010 
   set FT_VALPIS = ROUND(FT_VALPIS, 2)
 where R_E_C_N_O_ in (select R_E_C_N_O_ from SFT010_PIS082012);
   
select FT_MALQCOF, FT_MVALCOF, * from SFT010
 where FT_MALQCOF > 0;