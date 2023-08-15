SELECT C5_XCC, * FROM SC5010 WHERE C5_NUM = '005723';
SELECT C6_XCC, * FROM SC6010 WHERE C6_NUM = '005723';
SELECT D2_XCC, * FROM SD2010 WHERE D_E_L_E_T_ = ' ' AND D2_PEDIDO = '005723';

SELECT C5_XCC, * FROM SC5010 WHERE D_E_L_E_T_ = ' ' AND C5_NUM = '005262';
SELECT C6_XCC, * FROM SC6010 WHERE D_E_L_E_T_ = ' ' AND C6_NUM = '005262';
SELECT D2_XCC, * FROM SD2010 WHERE D_E_L_E_T_ = ' ' AND D2_PEDIDO = '005262';

SELECT R_E_C_N_O_, D_E_L_E_T_, D2_XCC, * FROM SD2010 WHERE D2_PEDIDO = '005723';

SELECT * FROM SD2010 WHERE D_E_L_E_T_ = ' ' AND D2_PEDIDO <> '' AND D2_XCC = '';
SELECT * FROM SD2010 WHERE D_E_L_E_T_ = ' ' AND D2_PEDIDO <> '' AND D2_XCC <> '';

SELECT SD2.* FROM SD2010 SD2 
  JOIN SC5010 SC5 ON SC5.D_E_L_E_T_ = ' ' AND SC5.C5_NUM = SD2.D2_PEDIDO
 WHERE SD2.D_E_L_E_T_ = ' ' AND SD2.D2_PEDIDO <> '' AND SD2.D2_XCC = '' AND SC5.C5_XCC <> '';

SELECT SD2.D2_EMISSAO, SD2.* FROM SD2010 SD2 
  JOIN SC5010 SC5 ON SC5.D_E_L_E_T_ = ' ' AND SC5.C5_NUM = SD2.D2_PEDIDO
 WHERE SD2.D_E_L_E_T_ = ' ' AND SD2.D2_FILIAL = '01' AND SD2.D2_PEDIDO <> '' AND SD2.D2_XCC = SC5.C5_XCC
 ORDER BY SD2.D2_EMISSAO;

SELECT * FROM SC6010 SC6
  JOIN SC5010 SC5 ON SC5.D_E_L_E_T_ = ' ' AND SC5.C5_FILIAL = '01' AND SC5.C5_NUM = SC6.C6_NUM
 WHERE SC6.D_E_L_E_T_ = ' ' AND SC6.C6_FILIAL = '01' AND SC6.C6_XCC = SC5.C5_XCC;
 
-- Centro de custo n�o preenchido no item da nota
SELECT SC5.C5_NUM, SC5.C5_XCC, SD2.D2_XCC, SD2.D2_EMISSAO, SD2.* FROM SD2010 SD2 
  JOIN SC5010 SC5 ON SC5.D_E_L_E_T_ = ' ' AND SC5.C5_NUM = SD2.D2_PEDIDO AND SC5.C5_XCC <> ''
 WHERE SD2.D_E_L_E_T_ = ' ' AND SD2.D2_FILIAL = '01' AND SD2.D2_PEDIDO <> '' AND SD2.D2_XCC <> SC5.C5_XCC
 ORDER BY SD2.D2_EMISSAO;
 
UPDATE SD2010
   SET D2_XCC = SC5.C5_XCC
  FROM SC5010 SC5
 WHERE SD2010.D_E_L_E_T_ = ' ' AND SD2010.D2_FILIAL = '01' AND SD2010.D2_PEDIDO <> '' 
   AND SD2010.D2_PEDIDO = SC5.C5_NUM AND SC5.C5_XCC <> '' AND SD2010.D2_XCC <> SC5.C5_XCC;
   
-- Centro de custo n�o preenchido no item do pedido
SELECT * FROM SC6010 SC6
  JOIN SC5010 SC5 ON SC5.D_E_L_E_T_ = ' ' AND SC5.C5_FILIAL = '01' AND SC5.C5_NUM = SC6.C6_NUM
 WHERE SC6.D_E_L_E_T_ = ' ' AND SC6.C6_FILIAL = '01' AND SC6.C6_XCC <> SC5.C5_XCC;
 
UPDATE SC6010
   SET C6_XCC = SC5.C5_XCC
  FROM SC5010 SC5
 WHERE SC6010.D_E_L_E_T_ = ' ' AND SC6010.C6_FILIAL = '01'
   AND SC6010.C6_NUM = SC5.C5_NUM AND SC5.C5_XCC <> '' AND SC6010.C6_XCC <> SC5.C5_XCC;