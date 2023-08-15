-- Situação do ativo
create view situacao_ativo as
select SN3.N3_CCDEPR, sum(SN3.N3_VRDACM1) as N3_VRDACM1
  from SN3010 SN3
 where SN3.D_E_L_E_T_ = ' ' and SN3.N3_CCDEPR <> ''
 group by SN3.N3_CCDEPR
-- order by SN3.N3_CCDEPR

-- Detalhe dos eventos por ativo
create view eventos_ativo as
select N4_CONTA, SUM(N4_VLROC1) as N4_VLROC1
  from SN4010
 where D_E_L_E_T_ = ' ' AND N4_CONTA <> ''
 group by N4_CONTA
-- order by N4_CONTA;

-- Detalhe dos conta contábil
create view resumo_contas_ativo as
select N5_CONTA, SUM(N5_VALOR1) as N5_VALOR1
  from SN5010
 where D_E_L_E_T_ = ' ' AND N5_CONTA <> ''
 group by N5_CONTA
-- order by N5_CONTA;

-- Apresenta as diferenças
select atf.N3_CCDEPR, atf.N3_VRDACM1, res.N5_VALOR1
  from situacao_ativo atf
  join resumo_contas_ativo res on res.N5_CONTA = atf.N3_CCDEPR
 where round(atf.N3_VRDACM1, 2) <> round(res.N5_VALOR1, 2);

-- Diferenças SN5 por conta
select atf.N3_CCDEPR, atf.N3_VRDACM1, res.N5_VALOR1
  from (select SN3.N3_CCDEPR, sum(SN3.N3_VRDACM1) as N3_VRDACM1
          from SN3010 SN3
         where SN3.D_E_L_E_T_ = ' ' and SN3.N3_CCDEPR <> ''
         group by SN3.N3_CCDEPR) atf
  join (select N5_CONTA, SUM(N5_VALOR1) as N5_VALOR1
          from SN5010
         where D_E_L_E_T_ = ' ' AND N5_CONTA <> ''
          group by N5_CONTA) res on res.N5_CONTA = atf.N3_CCDEPR
 where round(atf.N3_VRDACM1, 2) <> round(res.N5_VALOR1, 2);

-- Diferenças SN4 por conta
select atf.N3_CCDEPR, atf.N3_VRDACM1, res.N4_VLROC1
  from (select SN3.N3_CCDEPR, sum(SN3.N3_VRDACM1) as N3_VRDACM1
          from SN3010 SN3
         where SN3.D_E_L_E_T_ = ' ' and SN3.N3_CCDEPR <> ''
         group by SN3.N3_CCDEPR) atf
  join (select N4_CONTA, SUM(N4_VLROC1) as N4_VLROC1
          from SN4010
          where D_E_L_E_T_ = ' ' AND N4_CONTA <> ''
          group by N4_CONTA) res on res.N4_CONTA = atf.N3_CCDEPR
 where round(atf.N3_VRDACM1, 2) <> round(res.N4_VLROC1, 2);

 -- Diferenças SN4 por bem
select atf.N3_CBASE, atf.N3_ITEM, atf.N3_CCDEPR, atf.N3_VRDACM1, res.N4_VLROC1
  from (select SN3.N3_CBASE, SN3.N3_ITEM, SN3.N3_CCDEPR, sum(SN3.N3_VRDACM1) as N3_VRDACM1
          from SN3010 SN3
         where SN3.D_E_L_E_T_ = ' ' and SN3.N3_CCDEPR <> '' and SN3.N3_DTBAIXA = ''
         group by SN3.N3_CBASE, SN3.N3_CCDEPR, SN3.N3_ITEM) atf
  join (select N4_CBASE, N4_ITEM, N4_CONTA, SUM(N4_VLROC1) as N4_VLROC1
          from SN4010
          where D_E_L_E_T_ = ' ' AND N4_CONTA <> ''
          group by N4_CBASE, N4_ITEM, N4_CONTA) res on res.N4_CBASE = atf.N3_CBASE and res.N4_ITEM = atf.N3_ITEM
   and res.N4_CONTA = atf.N3_CCDEPR
 where round(atf.N3_VRDACM1, 2) <> round(res.N4_VLROC1, 2)
 order by atf.N3_CBASE;