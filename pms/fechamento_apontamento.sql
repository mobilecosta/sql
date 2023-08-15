-- Função STRZERO
CREATE FUNCTION strzero(@in_num integer, @in_zeros integer)
Returns VarChar(510)
As
Begin
   Declare @xText VarChar(510)

   If @in_num Is Null
      Set @in_num = 0
   Set @xText = ''
   While Len(@xText) < @In_Zeros
   Begin
      Set @xText= @xText + '0000000000'
   End
   Set @xText = @xText + Convert(VarChar, @In_Num)
   Return Right( @xText, @in_zeros )
End
GO
--

-- Fechamento 00:00 a 08:00
SELECT * FROM AFU010 
 WHERE AFU_DATA = dbo.strzero(Year(CURRENT_TIMESTAMP), 4) + dbo.strzero(Month(CURRENT_TIMESTAMP), 2) + dbo.strzero(Day(CURRENT_TIMESTAMP), 2) 
   AND AFU_HORAF = '' AND AFU_HORAI between '00:00' and '08:00';

UPDATE AFU010   
   SET AFU_HORAF = '08:00', 
       AFU_HQUANT = CAST(8 - ((CAST(LEFT(AFU_HORAI, 2)  as INTEGER))) AS INTEGER) +
                              (CAST(RIGHT(AFU_HORAI, 2) as FLOAT) / 60)
 WHERE AFU_DATA = dbo.strzero(Year(CURRENT_TIMESTAMP), 4) + dbo.strzero(Month(CURRENT_TIMESTAMP), 2) + dbo.strzero(Day(CURRENT_TIMESTAMP), 2) 
   AND AFU_HORAF = '' AND AFU_HORAI between '00:00' and '08:00';

-- Fechamento 08:00 a 12:00 - Recno 1604 e 1605
SELECT CAST(12 - ((CAST(LEFT(AFU_HORAI, 2)  as INTEGER))) AS INTEGER) +
                  (CAST(RIGHT(AFU_HORAI, 2) as FLOAT) / 60) as AFU_HORAF_F, * 
  FROM AFU010 
 WHERE AFU_DATA = dbo.strzero(Year(CURRENT_TIMESTAMP), 4) + dbo.strzero(Month(CURRENT_TIMESTAMP), 2) + 
                  dbo.strzero(Day(CURRENT_TIMESTAMP), 2) 
   AND AFU_HORAF = '' AND AFU_HORAI between '08:00' and '12:00';

UPDATE AFU010   
   SET AFU_HORAF = '12:00', 
       AFU_HQUANT = CAST(12 - ((CAST(LEFT(AFU_HORAI, 2)  as INTEGER))) AS INTEGER) +
                               (CAST(RIGHT(AFU_HORAI, 2) as FLOAT) / 60)
 WHERE AFU_DATA = dbo.strzero(Year(CURRENT_TIMESTAMP), 4) + dbo.strzero(Month(CURRENT_TIMESTAMP), 2) + dbo.strzero(Day(CURRENT_TIMESTAMP), 2) 
   AND AFU_HORAF = '' AND AFU_HORAI between '08:00' and '12:00';

-- Fechamento 13:00 a 18:00
SELECT * FROM AFU010 
 WHERE AFU_DATA = dbo.strzero(Year(CURRENT_TIMESTAMP), 4) + dbo.strzero(Month(CURRENT_TIMESTAMP), 2) + dbo.strzero(Day(CURRENT_TIMESTAMP), 2) 
   AND AFU_HORAF = '' AND AFU_HORAI between '13:00' and '18:00';

UPDATE AFU010   
   SET AFU_HORAF = '18:00', 
       AFU_HQUANT = CAST(18 - ((CAST(LEFT(AFU_HORAI, 2)  as INTEGER))) AS INTEGER) +
                               (CAST(RIGHT(AFU_HORAI, 2) as FLOAT) / 60)
 WHERE AFU_DATA = dbo.strzero(Year(CURRENT_TIMESTAMP), 4) + dbo.strzero(Month(CURRENT_TIMESTAMP), 2) + dbo.strzero(Day(CURRENT_TIMESTAMP), 2) 
   AND AFU_HORAF = '' AND AFU_HORAI between '13:00' and '18:00';

-- Fechamento 18:00 a 24:00
SELECT * FROM AFU010 
 WHERE AFU_DATA = dbo.strzero(Year(CURRENT_TIMESTAMP), 4) + dbo.strzero(Month(CURRENT_TIMESTAMP), 2) + dbo.strzero(Day(CURRENT_TIMESTAMP), 2) 
   AND AFU_HORAF = '' AND  AFU_HORAI between '18:00' and  '24:00';
   
UPDATE AFU010   
   SET AFU_HORAF = '23:59', 
       AFU_HQUANT = CAST(24 - ((CAST(LEFT(AFU_HORAI, 2)  as INTEGER))) AS INTEGER) +
                               (CAST(RIGHT(AFU_HORAI, 2) as FLOAT) / 60)
 WHERE AFU_DATA = dbo.strzero(Year(CURRENT_TIMESTAMP), 4) + dbo.strzero(Month(CURRENT_TIMESTAMP), 2) + dbo.strzero(Day(CURRENT_TIMESTAMP), 2) 
   AND AFU_HORAF = '' AND AFU_HORAI between '18:00' and '23:59';

If OBJECT_ID('dt_pmsendaponta') > 0
   DROP procedure dt_pmsendaponta
GO
create procedure dt_pmsendaponta(@in_data varchar(8), @in_horai varchar(5), @in_horaf varchar(5)) AS
begin
  declare @hora integer
  
  Set @hora = CAST(LEFT(@in_horaf, 2) as integer)

  UPDATE AFU010   
     SET AFU_HORAF = case when @in_horaf = '24:00' then '23:59' else @in_horaf end,
         AFU_HQUANT = CAST(@hora - ((CAST(LEFT(AFU_HORAI, 2)  as INTEGER))) AS INTEGER) +
                                    (CAST(RIGHT(AFU_HORAI, 2) as FLOAT) / 60)
   WHERE AFU_DATA = @in_data
     AND AFU_HORAF = '' AND AFU_HORAI between @in_horai and @in_horaf

END
go

DECLARE @data varchar(8);
Set @data = dbo.strzero(Year(CURRENT_TIMESTAMP), 4) + dbo.strzero(Month(CURRENT_TIMESTAMP), 2) + 
            dbo.strzero(Day(CURRENT_TIMESTAMP), 2);

EXECUTE dbo.dt_pmsendaponta @data, '08:00', '12:00';

update AFU010 set AFU_HORAF = '', AFU_HQUANT = -1
 where R_E_C_N_O_ in (1604, 1605)
 
select * from AFU010
 where R_E_C_N_O_ in (1604, 1605) 
 
alter table AFU010 ADD AFU_XTIPO VARCHAR(1); 
alter table AFU010 DROP COLUMN AFU_XTIPO; 

UPDATE AFU010 
   SET AFU_HORAF = '', AFU_HQUANT = -1
 WHERE AFU_DATA = '20120411' AND R_E_C_N_O_ >= 1618;
 
SELECT CURRENT_TIMESTAMP 