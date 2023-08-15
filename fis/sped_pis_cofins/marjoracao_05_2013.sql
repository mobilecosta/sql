-- Atualização do COFINS - 05/2013
select FT_NFISCAL As Nota, FT_ITEM as Item, 
       FT_ALIQCOF - 7.60 AS FT_MALQCOF, ROUND(FT_BASECOF * (FT_ALIQCOF - 7.60) / 100, 2) AS FT_MVALCOF,
       FT_MALQCOF, FT_MVALCOF
  from SFT010
 where D_E_L_E_T_ = ' ' and (FT_ALIQCOF - 7.60) > 0
   and (FT_ALIQCOF - 7.60 <> FT_MALQCOF or 
        ROUND(FT_BASECOF * (FT_ALIQCOF - 7.60) / 100, 2) <> FT_MVALCOF)
   and LEFT(FT_ENTRADA, 6) = '201305'

SELECT * INTO SFT010_052013_1 FROM SFT010
 where D_E_L_E_T_ = ' ' and (FT_ALIQCOF - 7.60) > 0
   and (FT_ALIQCOF - 7.60 <> FT_MALQCOF or 
        ROUND(FT_BASECOF * (FT_ALIQCOF - 7.60) / 100, 2) <> FT_MVALCOF)
   and LEFT(FT_ENTRADA, 6) = '201305'

UPDATE SFT010
   set FT_MALQCOF = FT_ALIQCOF - 7.60, 
       FT_MVALCOF = ROUND(FT_BASECOF * (FT_ALIQCOF - 7.60) / 100, 2)
 where D_E_L_E_T_ = ' ' and (FT_ALIQCOF - 7.60) > 0
   and (FT_ALIQCOF - 7.60 <> FT_MALQCOF or 
        ROUND(FT_BASECOF * (FT_ALIQCOF - 7.60) / 100, 2) <> FT_MVALCOF)
   and LEFT(FT_ENTRADA, 6) = '201305'
   
-- Atualização do PIS - 05/2013
select FT_NFISCAL As Nota, FT_ITEM As Item,
       ROUND(FT_BASEPIS * (1.65 / 100), 2) As PisRecalculado, FT_VALPIS As PisGerado
  from SFT010
 where D_E_L_E_T_ = ' ' and FT_ALIQPIS > 0
   and (FT_ALIQPIS <> 1.65 AND FT_ALIQPIS <> 0.65)
   and LEFT(FT_ENTRADA, 6) = '201305';

select * INTO SFT010_052013_PIS_1
  from SFT010
 where D_E_L_E_T_ = ' ' and FT_ALIQPIS > 0
   and (FT_ALIQPIS <> 1.65 AND FT_ALIQPIS <> 0.65)
   and LEFT(FT_ENTRADA, 6) = '201305';

update SFT010
   set FT_ALIQPIS = 1.65, FT_VALPIS = ROUND(FT_BASEPIS * (1.65 / 100), 2)
 where D_E_L_E_T_ = ' ' and FT_ALIQPIS > 0
   and (FT_ALIQPIS <> 1.65 AND FT_ALIQPIS <> 0.65)
   and LEFT(FT_ENTRADA, 6) = '201305';