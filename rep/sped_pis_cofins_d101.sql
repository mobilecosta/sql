-- Atualizar o tipo de frete a partir da tes nos itens da nota
SELECT SFT.R_E_C_N_O_, SFT.FT_INDNTFR, SF4.F4_INDNTFR, SFT.FT_PRODUTO, * 
  FROM SFT010 SFT 
  JOIN SD1010 SD1 ON SD1.D1_FILIAL = SFT.FT_FILIAL AND SD1.D1_DOC = SFT.FT_NFISCAL 
   AND SD1.D1_SERIE = SFT.FT_SERIE AND SD1.D1_ITEM = SFT.FT_ITEM AND SD1.D_E_L_E_T_ = ' '
  JOIN SF4010 SF4 ON SF4.F4_FILIAL = SFT.FT_FILIAL AND SF4.D_E_L_E_T_ = ' ' AND SF4.F4_CODIGO = SD1.D1_TES 
   AND SF4.F4_INDNTFR <> ''
 WHERE SFT.FT_FILIAL = '01' AND SFT.D_E_L_E_T_ = ' ' AND SFT.FT_INDNTFR = '';

-- Preenche a indica��o 
UPDATE SFT010  
   SET FT_INDNTFR = UPD.F4_INDNTFR
  FROM (
SELECT SFT.R_E_C_N_O_, SF4.F4_INDNTFR
  FROM SFT010 SFT 
  JOIN SD1010 SD1 ON SD1.D1_FILIAL = SFT.FT_FILIAL AND SD1.D1_DOC = SFT.FT_NFISCAL 
   AND SD1.D1_SERIE = SFT.FT_SERIE AND SD1.D1_ITEM = SFT.FT_ITEM AND SD1.D_E_L_E_T_ = ' '
  JOIN SF4010 SF4 ON SF4.F4_FILIAL = SFT.FT_FILIAL AND SF4.D_E_L_E_T_ = ' ' AND SF4.F4_CODIGO = SD1.D1_TES 
   AND SF4.F4_INDNTFR <> ''
 WHERE SFT.FT_FILIAL = '01' AND SFT.D_E_L_E_T_ = ' ' AND SFT.FT_INDNTFR = ''
) UPD 
WHERE SFT010.R_E_C_N_O_ = UPD.R_E_C_N_O_;