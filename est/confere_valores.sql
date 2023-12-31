SELECT SUM(SB2.B2_VFIM1) AS B2_VFIM1, MIN(KDX.CUSTO) AS CUSTO, MIN(SB9.B9_VINI) AS B9_VINI
  FROM SB2010 SB2
  JOIN (select SUM(CUSTO) AS CUSTO
          from KARDEX
         where DATA between '20120901' and '20120931' and B1_LOCAL = '01'
           and TIPO = 1
        having SUM(CUSTO) <> 0) KDX ON KDX.CUSTO = KDX.CUSTO
  JOIN (SELECT SUM(B9_VINI1) AS B9_VINI
          FROM SB9010
         WHERE D_E_L_E_T_ = ' ' AND B9_FILIAL = '01' AND B9_LOCAL = '01'
           AND B9_DATA = '20120831') SB9 ON SB9.B9_VINI = SB9.B9_VINI
 WHERE SB2.D_E_L_E_T_ = ' ' AND SB2.B2_FILIAL = '01' AND SB2.B2_LOCAL = '01'

select SUM(B9_VINI1) from SB9010 where D_E_L_E_T_ = ' ' AND B9_DATA = '20120930';

select SUM(B9_VINI1) from SB9010 where D_E_L_E_T_ = ' ' AND B9_DATA = '20120831';

select SUM(B2_VFIM1) from SB2010 where D_E_L_E_T_ = ' ' AND B2_FILIAL = '01' AND B2_LOCAL = '01';

select D_E_L_E_T_,  R_E_C_N_O_, D1_DTDIGIT, * from SD1010 where D1_DTDIGIT >= '20121001';
select D_E_L_E_T_,  R_E_C_N_O_, D2_EMISSAO, * from SD2010 where D2_EMISSAO >= '20121001';
select D_E_L_E_T_,  R_E_C_N_O_, D3_EMISSAO, * from SD3010 where D3_EMISSAO >= '20121001';