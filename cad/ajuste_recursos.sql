select * from AE8010 order by AE8_RECURS;

-- Canela
select '60' + RIGHT(LTRIM(RTRIM(AE8_RECURS)), 2) AE8_RECURS_NEW, * from AE8010 
 where left(AE8_RECURS, 6) = 'CANELA';

update AE8010 set AE8_RECURS = '60' + RIGHT(LTRIM(RTRIM(AE8_RECURS)), 2)
 where left(AE8_RECURS, 6) = 'CANELA';

-- MainPower
select '70' + RIGHT(LTRIM(RTRIM(AE8_RECURS)), 2) AE8_RECURS_NEW, * from AE8010 
 where left(AE8_RECURS, 9) = 'MAINPOWER';

update AE8010 set AE8_RECURS = '70' + RIGHT(LTRIM(RTRIM(AE8_RECURS)), 2)
 where left(AE8_RECURS, 9) = 'MAINPOWER';
 
-- Outros
select '80' + dbo.strzero(ROW_NUMBER() OVER(ORDER BY AE8_RECURS DESC), 2) AE8_RECURS_NEW, R_E_C_N_O_ from AE8010
 where left(AE8_RECURS, 4) > '9999';

select AE8_NEW.AE8_RECURS_NEW, AE8010.* from AE8010 ,
(
select '80' + dbo.strzero(ROW_NUMBER() OVER(ORDER BY AE8_RECURS DESC), 2) AE8_RECURS_NEW, R_E_C_N_O_ from AE8010 
 where left(AE8_RECURS, 4) > '9999'
) AE8_NEW
where AE8010.R_E_C_N_O_ = AE8_NEW.R_E_C_N_O_; 
 
update AE8010 
   set AE8_RECURS = AE8_NEW.AE8_RECURS_NEW
  from 
(
select '80' + dbo.strzero(ROW_NUMBER() OVER(ORDER BY AE8_RECURS DESC), 2) AE8_RECURS_NEW, R_E_C_N_O_ from AE8010 
 where left(AE8_RECURS, 4) > '9999'
) AE8_NEW
 where AE8010.R_E_C_N_O_ = AE8_NEW.R_E_C_N_O_; 

-- Apontamentos 
update AFU010 set AFU_RECURS = '60' + RIGHT(LTRIM(RTRIM(AFU_RECURS)), 2)
 where left(AFU_RECURS, 6) = 'CANELA';

 update AFU010 set AFU_RECURS = '70' + RIGHT(LTRIM(RTRIM(AFU_RECURS)), 2)
 where left(AFU_RECURS, 9) = 'MAINPOWER';

update AFU010 
   set AFU_RECURS = AFU_NEW.AFU_RECURS_NEW
  from 
(
select '80' + dbo.strzero(ROW_NUMBER() OVER(ORDER BY AFU_RECURS DESC), 2) AFU_RECURS_NEW, R_E_C_N_O_ from AFU010 
 where left(AFU_RECURS, 4) > '9999'
) AFU_NEW
 where AFU010.R_E_C_N_O_ = AFU_NEW.R_E_C_N_O_; 