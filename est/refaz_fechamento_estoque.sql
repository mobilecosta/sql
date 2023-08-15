select * into SB2010_092012_2 from SB2010 where D_E_L_E_T_ = ' ';
select * into SB9010_092012_2 from SB9010 where D_E_L_E_T_ = ' ' and B9_DATA = '20121231';
select * into SBJ010_092012_2 from SBJ010 where D_E_L_E_T_ = ' ' and BJ_DATA = '20121231';

delete from SB9010 where D_E_L_E_T_ = ' ' and B9_DATA = '20121231';
delete from SBJ010 where D_E_L_E_T_ = ' ' and BJ_DATA = '20121231';

select * from SD3010 WHERE D_E_L_E_T_ = ' ' AND D3_EMISSAO = '20130117';

select * from SD3010 WHERE D3_COD = 'CELROB004212A';

select * from SD3010 WHERE D3_COD = 'CELNAC004212A';

select * from SB9010 where D_E_L_E_T_ = ' ' and B9_DATA = '20121231';
select * from SBJ010 where D_E_L_E_T_ = ' ' and BJ_DATA = '20121231';

delete from SB9010 where D_E_L_E_T_ = ' ' and B9_DATA = '20130930';
delete from SBJ010 where D_E_L_E_T_ = ' ' and BJ_DATA = '20130930';
delete from SBK010 where D_E_L_E_T_ = ' ' and BK_DATA = '20130930';

select * from SB9010 where D_E_L_E_T_ = ' ' and B9_DATA = '20130930';
select * from SBJ010 where D_E_L_E_T_ = ' ' and BJ_DATA = '20130930';
select * from SBK010 where D_E_L_E_T_ = ' ' and BK_DATA = '20130930';

select * into SBJ010_201309 from SBJ010 where D_E_L_E_T_ = ' ' and BJ_DATA = '20130930';
select * into SBK010_201309 from SBK010 where D_E_L_E_T_ = ' ' and BK_DATA = '20130930';

DECLARE	@return_value int,
		@OUT_RESULTADO char(1)

EXEC	@return_value = [dbo].[MAT038_17_01]
		@IN_FILIALCOR = N'01',
		@IN_DATA = N'20130930',
		@IN_MV_RASTRO = N'S',
		@IN_MV_ULMES = N'20130831',
		@IN_MV_PAR02 = 0,
		@IN_MV_CUSZERO = N'S',
		@IN_300SALNEG = N'1',
		@IN_MV_CUSFIFO = N'0',
		@IN_MV_MOEDACM = N'2345',
		@IN_CFECHFIFO = N'0',
		@IN_MV_CUSMED = N'0',
		@IN_MV_CUSFIL = N'0',
		@IN_MV_CUSEMP = N'0',
		@IN_MV_PAR04 = 0,
		@IN_FILSEQ = 0,
		@OUT_RESULTADO = @OUT_RESULTADO OUTPUT

SELECT	@OUT_RESULTADO as N'@OUT_RESULTADO'

SELECT	'Return Value' = @return_value