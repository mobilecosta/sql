SELECT SE1.* FROM SD2010 SD2 
 JOIN SC5010 SC5 ON SC5.D_E_L_E_T_ = ' ' AND SC5.C5_XPROJET = 'PMS004112A' AND SC5.C5_CODPED <> 'S/N' AND SD2.D2_PEDIDO = SC5.C5_NUM
 JOIN SF2010 SF2 ON SF2.D_E_L_E_T_ = ' ' AND SF2.F2_DOC = SD2.D2_DOC AND SF2.F2_SERIE = SD2.D2_SERIE
 JOIN SE1010 SE1 ON SE1.D_E_L_E_T_ = ' ' AND SE1.E1_NUM = SF2.F2_DUPL