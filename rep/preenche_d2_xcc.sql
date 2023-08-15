SELECT D2_PEDIDO, * FROM SD2010 WHERE D2_XCC <> ''
 ORDER BY D2_PEDIDO

-- Registros a serem atualizados
SELECT D2_XCC, SC6010.C6_XCC, * 
  FROM SD2010, SC6010
 WHERE SD2010.D2_FILIAL = '01' AND SD2010.D_E_L_E_T_ = ' ' AND SD2010.D2_XCC = '' 
   AND SC6010.C6_FILIAL = '01' AND SC6010.D_E_L_E_T_ = ' ' AND SD2010.D2_PEDIDO = SC6010.C6_NUM 
   AND SC6010.C6_XCC <> '';

-- Instrução de atualização 
UPDATE SD2010 
   SET D2_XCC = SC6010.C6_XCC
  FROM SC6010
 WHERE SD2010.D2_FILIAL = '01' AND SD2010.D_E_L_E_T_ = ' ' AND SD2010.D2_XCC = ''
   AND SC6010.C6_FILIAL = '01' AND SC6010.D_E_L_E_T_ = ' ' AND SD2010.D2_PEDIDO = SC6010.C6_NUM 
   AND SC6010.C6_XCC <> '';