select SUM(PROVENTO) AS PROVENTO, SUM(DESCONTOS) AS DESCONTOS
  from (
select SRZ.RZ_MAT, SUM(CASE WHEN SRV.RV_TIPOCOD = '1' then SRZ.RZ_VAL else 0 end) as PROVENTO,
                   SUM(CASE WHEN SRV.RV_TIPOCOD = '2' then SRZ.RZ_VAL else 0 end) as DESCONTOS
  from SRZ010 SRZ
  join SRV010 SRV ON SRV.RV_FILIAL = '  ' AND SRV.D_E_L_E_T_ = ' ' AND SRV.RV_COD = SRZ.RZ_PD and SRV.RV_TIPOCOD in ('1', '2')
 where SRZ.RZ_MAT <> 'zzzzzz' and SRZ.RZ_MAT <> ''
 group by SRZ.RZ_MAT
) tab 

 order by SRZ.RZ_MAT
 
select RZ_PD, SUM(RZ_VAL) AS RZ_VAL 
  from SRZ010 SRZ
 where SRZ.RZ_MAT <> 'zzzzzz' and SRZ.RZ_MAT <> ''
 group by RZ_PD
 order by RZ_PD
 
191	34006,56 
318	337481,14
411	4100,80
415	2770,41
417	22933,66 X 22368,64 - 565,02
419	61749,48
705	404471,75
747	91337,0999999999
753	22534,16 x 21969,14 - 565,02

select * from SRZ010 

select SUM(RZ_VAL) from SRZ010
 where D_E_L_E_T_ = ' ' AND RZ_PD = '417' and RZ_MAT <> 'zzzzzz' and RZ_MAT <> '';

select SUM(RD_VALOR) from SRD010
 where D_E_L_E_T_ = ' ' AND RD_PD = '417' and RD_DATPGT = '20120930';

select SRD.RD_VALOR, SRZ.* 
  from SRZ010 SRZ
  LEFT JOIN SRD010 SRD ON SRD.D_E_L_E_T_ = ' ' AND SRD.RD_MAT = SRZ.RZ_MAT AND SRD.RD_PD = SRZ.RZ_PD 
   and SRD.RD_DATARQ = '201209' 
 where SRZ.D_E_L_E_T_ = ' ' and SRZ.RZ_VAL <> COALESCE(SRD.RD_VALOR, 0)
   and SRZ.RZ_MAT <> 'zzzzzz' and SRZ.RZ_MAT <> ''
 order by SRZ.RZ_MAT;
 
select * from SRD010 WHERE RD_MAT = '3053'; 


select SUM(case when CTK_DEBITO <> '' then CTK_VLR01 else 0 end) AS DEBITO,
       SUM(case when CTK_CREDIT <> '' then CTK_VLR01 else 0 end) AS CREDITO 
  from CTK010
 where D_E_L_E_T_ = ' ' and CTK_DATA = '20120930' and CTK_ROTINA = 'GPEM110' and CTK_VLR01 > 0
-- and R_E_C_N_O_ BETWEEN 406188 AND 406206; -- 101
   and R_E_C_N_O_ BETWEEN 406207 AND 406239; -- 201

select CTK_DEBITO, CTK_CREDIT, CTK_VLR01, CTK_HIST 
  from CTK010
 where D_E_L_E_T_ = ' ' and CTK_DATA = '20120930' and CTK_ROTINA = 'GPEM110' and CTK_VLR01 > 0
   and R_E_C_N_O_ BETWEEN 406207 AND 406239; -- 201
   
   and R_E_C_N_O_ BETWEEN 406207 AND 406239; -- 205

-- Seleciona os registros de contra prova
update CTK010
   set D_E_L_E_T_ = '*'
 where D_E_L_E_T_ = ' ' and CTK_DATA = '20120930' and CTK_ROTINA = 'GPEM110' and CTK_VLR01 > 0;

-- Totalização dos registros de contra-prova
select CTK_DEBITO, CTK_CREDIT, CTK_CCC, CTK_CCD, 
       SUM(case when CTK_DEBITO <> '' then CTK_VLR01 else 0 end) AS DEBITO,
       SUM(case when CTK_CREDIT <> '' then CTK_VLR01 else 0 end) AS CREDITO
  from CTK010
 where D_E_L_E_T_ = ' ' and CTK_DATA = '20120930' and CTK_ROTINA = 'GPEM110' and CTK_VLR01 > 0
 group by CTK_DEBITO, CTK_CREDIT, CTK_CCC, CTK_CCD
having SUM(case when CTK_DEBITO <> '' then CTK_VLR01 else 0 end) > 0 and 
       SUM(case when CTK_CREDIT <> '' then CTK_VLR01 else 0 end) > 0 and
       SUM(case when CTK_DEBITO <> '' then CTK_VLR01 else 0 end) =
       SUM(case when CTK_CREDIT <> '' then CTK_VLR01 else 0 end)
 order by CTK_DEBITO, CTK_CREDIT, CTK_CCC, CTK_CCD;

select SUM(CREDITO) AS CREDITO, SUM(DEBITO) AS DEBITO
  from (

select *
  from (
select CTK_DEBITO, CTK_CREDIT, CTK_CCC, CTK_CCD, 
       SUM(case when CTK_DEBITO <> '' then CTK_VLR01 else 0 end) AS DEBITO,
       SUM(case when CTK_CREDIT <> '' then CTK_VLR01 else 0 end) AS CREDITO
 from CTK010
where D_E_L_E_T_ = ' ' and CTK_DATA = '20120930' and CTK_ROTINA = 'GPEM110' and CTK_VLR01 > 0
group by CTK_DEBITO, CTK_CREDIT, CTK_CCC, CTK_CCD
) tab
order by CTK_CCC, CTK_CCD, CTK_DEBITO, CTK_CREDIT

having (SUM(case when CTK_DEBITO <> '' then CTK_VLR01 else 0 end) = 0 and 
        SUM(case when CTK_CREDIT <> '' then CTK_VLR01 else 0 end) > 0) or
       (SUM(case when CTK_DEBITO <> '' then CTK_VLR01 else 0 end) > 0 and 
        SUM(case when CTK_CREDIT <> '' then CTK_VLR01 else 0 end) = 0)

-- order by DEBITO
) tab

-- Filtro por Centro de Custos
select *
  from CTK010
 where D_E_L_E_T_ = ' ' and CTK_DATA = '20120930' and CTK_ROTINA = 'GPEM110' and CTK_VLR01 > 0
   and (CTK_CCC = '101' or CTK_CCD = '101');

-- Totalização por Centro de Custos
select SUM(case when CTK_DEBITO <> '' then CTK_VLR01 else 0 end) AS DEBITO,
       SUM(case when CTK_CREDIT <> '' then CTK_VLR01 else 0 end) AS CREDITO
  from CTK010
 where D_E_L_E_T_ = ' ' and CTK_DATA = '20120930' and CTK_ROTINA = 'GPEM110' and CTK_VLR01 > 0
   and (CTK_CCC = '101' or CTK_CCD = '101');
   
select * from SRZ010
 where R_E_C_N_O_ in (select CTK_RECORI from CTK010 
                       where D_E_L_E_T_ = ' ' and CTK_DATA = '20120930' and CTK_ROTINA = 'GPEM110' 
                         and CTK_VLR01 > 0 and CTK_TABORI = 'SRZ')
 order by RZ_MAT, RZ_PD;
 
select RZ_PD, SUM(RZ_VAL) AS RZ_VAL from SRZ010
 where D_E_L_E_T_ = ' '
   and RZ_MAT <> 'zzzzzz' and RZ_MAT <> ''
 group by RZ_PD
 order by RZ_PD;
 
select RD_PD, SUM(RD_VALOR) from SRD010
 where D_E_L_E_T_ = ' ' AND RD_DATARQ = '201209' 
 group by RD_PD
 order by RD_PD;
                             
select * from SRV010 where D_E_L_E_T_ = ' ' AND RV_LCTOP <> '';

SELECT TOP 1 * FROM SRZ010 

select * from SRZ010 WHERE R

select SRD.RD_PD, SUM(SRD.RD_VALOR) from SRD010 SRD
  join SRV010 SRV ON SRV.D_E_L_E_T_ = ' ' AND SRV.RV_COD = SRD.RD_PD AND SRV.RV_LCTOP <> ''
 where SRD.D_E_L_E_T_ = ' ' AND SRD.RD_DATARQ = '201209' AND SRD.RD_CC = '201'
 group by SRD.RD_PD
 order by SRD.RD_PD;

-- Funcionário com diferença
select * from SRD010 
 where D_E_L_E_T_ = ' ' and RD_MAT = '8007' and RD_DATARQ in ('201208', '201209') and RD_TIPO2 = 'I'
 order by RD_DATARQ, RD_PD;
 
select * from RC;