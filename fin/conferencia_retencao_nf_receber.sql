select SF2.F2_SERIE, SF2.F2_DOC, SF2.F2_EMISSAO, SF2.F2_VALBRUT,
       CASE WHEN SE1.E1_PIS > 0 THEN SE1.E1_PIS ELSE ROUND(SF2.F2_VALBRUT * (0.10 / 100), 2) END AS PIS,
       CASE WHEN SE1.E1_COFINS > 0 THEN SE1.E1_COFINS ELSE ROUND(SF2.F2_VALBRUT * (0.50 / 100), 2) END AS COFINS
  from SF2010 SF2
  left join (select SD2.D2_DOC, SD2.D2_SERIE
               from SD2010 SD2
               join SA1010 SA1 on SA1.D_E_L_E_T_ = ' ' AND SA1.A1_COD = SD2.D2_CLIENTE  AND SA1.A1_LOJA = SD2.D2_LOJA
                AND (SA1.A1_RECPIS = 'S' OR SA1.A1_RECCOFI = 'S')
               join SED010 SED on SED.D_E_L_E_T_ = ' ' AND SED.ED_CODIGO = SA1.A1_NATUREZ
                and (SED.ED_CALCPIS = 'S' OR SED.ED_CALCCOF = 'S')
               join SB1010 SB1 on SB1.D_E_L_E_T_ = ' ' AND SB1.B1_COD = SD2.D2_COD
                AND (SB1.B1_PIS = '1' OR SB1.B1_COFINS = '1')
               join SF4010 SF4 on SF4.D_E_L_E_T_ = ' ' AND SF4.F4_CODIGO = SD2.D2_TES AND SF4.F4_DUPLIC = 'S'
              group by SD2.D2_DOC, SD2.D2_SERIE) SD2 on SD2.D2_DOC = SF2.F2_DOC and SD2.D2_SERIE = SF2.F2_SERIE
  left join (select E1_NUM, E1_PREFIXO, SUM(E1_SALDO) AS E1_SALDO,
                    SUM(CASE WHEN E1_TIPO = 'CF-' THEN E1_VALOR ELSE 0 END) AS E1_PIS,
                    SUM(CASE WHEN E1_TIPO = 'PI-' THEN E1_VALOR ELSE 0 END) AS E1_COFINS,
                    MAX(CASE WHEN E1_TIPO = 'CF-'  AND E1_TITPAI <> ' ' THEN 1 ELSE 0 END) AS COFINS,
                    MAX(CASE WHEN E1_TIPO = 'PI-'  AND E1_TITPAI <> ' ' THEN 1 ELSE 0 END) AS PIS
               from SE1010
              where D_E_L_E_T_ = ' '
              group by E1_NUM, E1_PREFIXO) SE1 on SE1.E1_NUM = SF2.F2_DOC and SE1.E1_PREFIXO = SF2.F2_SERIE
 where SF2.D_E_L_E_T_ = ' ' AND SF2.F2_SERIE = '1' AND COALESCE(SE1.PIS, 0) + COALESCE(SE1.COFINS, 0) = 0
   AND SE1.E1_SALDO > 0
 order by SF2.F2_EMISSAO DESC, SF2.F2_DOC DESC