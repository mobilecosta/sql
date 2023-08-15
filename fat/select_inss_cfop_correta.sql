SELECT SD2.D2_COD, SD2.D2_CF, SD2.D2_BASEINS, SUM(SD2.D2_TOTAL) AS D2_TOTAL,  SD2.D2_VALINS, SF4.F4_DUPLIC, SB1.B1_INSS
      FROM SD2010 SD2
   JOIN SF4010 SF4 ON SF4.D_E_L_E_T_ = ' ' AND SF4.F4_FILIAL = SD2.D2_FILIAL AND SF4.F4_CF = SD2.D2_CF
   JOIN SB1010 SB1 ON SB1.D_E_L_E_T_ = ' ' AND SB1.B1_FILIAL = SD2.D2_FILIAL AND SB1.B1_COD = SD2.D2_COD AND SB1.B1_INSS = 'S'
      WHERE SD2.D2_VALINS > 0
         GROUP BY SD2.D2_COD, SD2.D2_CF, SD2.D2_BASEINS, SD2.D2_VALINS, SF4.F4_DUPLIC, SB1.B1_INSS
       HAVING SD2.D2_CF IN('5101', '6101',  '7101', '5111', '5122', '6118')
       
       
       
SELECT SD2.D2_COD, SD2.D2_CF, SD2.D2_BASEINS, SF2.F2_BASEINS, SUM(SD2.D2_TOTAL) AS D2_TOTAL,  SD2.D2_VALINS, SF2.F2_VALINSS, SF4.F4_DUPLIC, SB1.B1_INSS
      FROM SD2010 SD2
   JOIN SF4010 SF4 ON SF4.D_E_L_E_T_ = ' ' AND SF4.F4_FILIAL = SD2.D2_FILIAL AND SF4.F4_CODIGO = SD2.D2_TES
   JOIN SB1010 SB1 ON SB1.D_E_L_E_T_ = ' ' AND SB1.B1_FILIAL = SD2.D2_FILIAL AND SB1.B1_COD = SD2.D2_COD AND SB1.B1_INSS = 'S'
   JOIN SF2010 SF2 ON SF2.D_E_L_E_T_ = ' ' AND SF2.F2_FILIAL = SD2.D2_FILIAL AND SF2.F2_DOC = SD2.D2_DOC
      WHERE SD2.D2_VALINS > 0
         GROUP BY SD2.D2_COD, SD2.D2_CF, SD2.D2_BASEINS, SD2.D2_VALINS, SF4.F4_DUPLIC, SB1.B1_INSS, SF2.F2_VALINSS, SF2.F2_BASEINS
       HAVING SD2.D2_CF IN('5101', '6101',  '7101', '5111', '5122', '6118')
       
       
SELECT SD2.D2_DOC, SD2.D2_SERIE, SD2.D2_BASEINS, SUM(SD2.D2_VALINS) AS D2_VALINS, SF2.F2_BASEINS, SUM(SF2.F2_VALINSS) AS F2_VALINSS
    FROM SD2010 SD2
  JOIN SF2010 SF2 ON SF2.D_E_L_E_T_ = ' ' AND SF2.F2_FILIAL = SD2.D2_FILIAL AND SF2.F2_DOC = SD2.D2_DOC AND SF2.F2_SERIE = SD2.D2_SERIE
 WHERE SD2.D2_VALINS > 0
  GROUP BY SD2.D2_DOC, SD2.D2_SERIE, SD2.D2_BASEINS,  D2_VALINS, SF2.F2_BASEINS,  F2_VALINSS, F2_DOC       
  
  SELECT F2_DOC, F2_BASEINS, F2_VALINSS
 FROM SF2010 
   WHERE F2_VALINSS > 0 AND D_E_L_E_T_ = ' ' AND F2_DOC >= 059243
 ORDER BY F2_DOC

 SELECT D2_DOC, D2_BASEINS, D2_VALINS
 FROM SD2010
 WHERE D2_VALINS > 0 AND D_E_L_E_T_ = ' ' AND D2_DOC