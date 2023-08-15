-- Quebra por Situação de PIS/Ocorrência
select case when LEFT(FT_CFOP, 1) = '3' then '108' else '101' end as tipo, FT_CSTPIS, FT_CODBCC,
       SUM(FT_BASEPIS) as FT_BASEPIS
  from SFT010
 where D_E_L_E_T_ = ' ' and FT_FILIAL = '01' and FT_ENTRADA between '20120501' and '20120531'
   and FT_BASEPIS > 0 and left(FT_CFOP, 1) < '5'
 group by case when LEFT(FT_CFOP, 1) = '3' then '108' else '101' end, FT_CSTPIS, FT_CODBCC
 order by case when LEFT(FT_CFOP, 1) = '3' then '108' else '101' end, FT_CSTPIS, FT_CODBCC;
 
select FT_NFISCAL, SUM(FT_BASEPIS) as FT_BASEPIS, SUM(FT_VALCONT) as FT_VALCONT
  from SFT010
 where D_E_L_E_T_ = ' ' and FT_FILIAL = '01' and FT_ENTRADA between '20120401' and '20120431'
   and FT_BASEPIS > 0 and left(FT_CFOP, 1) < '5' and FT_CODBCC = '03'
   group by FT_NFISCAL
   order by FT_NFISCAL;  


select case when LEFT(FT_CFOP, 1) = '3' then '108' else '101' end as tipo, FT_CFOP, FT_CSTPIS, FT_CODBCC,
       SUM(FT_BASEPIS) as FT_BASEPIS
  from SFT010
 where D_E_L_E_T_ = ' ' and FT_FILIAL = '01' and FT_ENTRADA between '20120501' and '20120531'
   and FT_BASEPIS > 0 and left(FT_CFOP, 1) < '5'
 group by case when LEFT(FT_CFOP, 1) = '3' then '108' else '101' end, FT_CFOP, FT_CSTPIS, FT_CODBCC
 order by case when LEFT(FT_CFOP, 1) = '3' then '108' else '101' end, FT_CFOP, FT_CSTPIS, FT_CODBCC;

SELECT FT_NFISCAL, SUM(FT_BASEPIS) AS FT_BASEPIS, SUM(FT_VALPIS) AS FT_VALPIS FROM SFT010
 where D_E_L_E_T_ = ' ' and FT_FILIAL = '01' and FT_ENTRADA between '20120501' and '20120531'
   and FT_BASEPIS > 0 and left(FT_CFOP, 1) < '5' AND FT_CODBCC = '03'
 GROUP BY FT_NFISCAL 
 ORDER BY FT_NFISCAL;