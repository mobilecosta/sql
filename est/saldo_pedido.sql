select * from SCQ010
where D_E_L_E_T_ = ' ' AND CQ_PRODUTO = '142313-1';

select * from SC1010
where D_E_L_E_T_ = ' ' AND C1_PRODUTO = '142313-1';

select * from SC7010
where D_E_L_E_T_ = ' ' AND C7_PRODUTO = '142313-1';

select * from SD1010
where D_E_L_E_T_ = ' ' AND D1_COD = '142313-1' AND D1_QUANT > 0;

select * from SD1010
where D_E_L_E_T_ = ' ' AND D1_COD = '142313-1' AND D1_QUANT > 0 AND D1_TES = '';

select D_E_L_E_T_, * from SD1010
where D1_COD = '142313-1' AND D1_QUANT > 0 AND D1_TES = '';

SELECT B2_SALPEDI, B2_NAOCLAS, * FROM SB2010 WHERE B2_COD = '142313-1'