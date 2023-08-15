select * from ZT8HTG.dbo.SZ8010 order by R_E_C_N_O_

select * from SZ8010 order by R_E_C_N_O_;

delete from SZ8010;

insert into SZ8010(Z8_FILIAL, Z8_DESPESA, Z8_DESCRI, Z8_TIPO, Z8_COBRAR, Z8_CUSTO, Z8_VALOR_C, Z8_MARGEM,
                   D_E_L_E_T_, R_E_C_N_O_, Z8_MSBLQL)
            select Z8_FILIAL, Z8_DESPESA, Z8_DESCRI, '2' as Z8_TIPO, 
                   case when Z8_DESCRI like '%(NAO)%' then '2' else '1' end as Z8_COBRAR, 0 as Z8_CUSTO, 
                   0 as Z8_VALOR_C, 0 as Z8_MARGEM, ' ' as D_E_L_E_T_, R_E_C_N_O_, ' ' as Z8_MSBLQL
              from ZT8HTG.dbo.SZ8010 
             order by R_E_C_N_O_;