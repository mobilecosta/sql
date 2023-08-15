SELECT * FROM AE8010;

SELECT * FROM AFU010 WHERE AFU_DATA = '20120412' ORDER BY AFU_RECURS, AFU_HORAI;

SELECT '3101' AS AFU_RECURS, '08:00' AS AFU_HORAI, '12:00' AS AFU_HORAF
 UNION ALL
SELECT '3101' AS AFU_RECURS, '13:00' AS AFU_HORAI, '18:00' AS AFU_HORAF 
 UNION ALL
SELECT AFU_RECURS, AFU_HORAI, AFU_HORAF 
  FROM AFU010 
 WHERE AFU_RECURS = '3101' AND AFU_DATA = '20120412'

If OBJECT_ID('AFU010_TMP') > 0
   DROP table AFU010_TMP
GO
CREATE TABLE AFU010_TMP(AFU_LOGIN varchar(10), AFU_PROJET varchar(10), A1_COD VARCHAR(6), 
                        A1_LOJA VARCHAR(6), A1_NOME VARCHAR(40), AFU_TAREFA varchar(12), 
                        AFU_RECURS varchar(15), AFU_DATA varchar(8), AFU_HORAI varchar(5), 
 	                    AFU_HORAF varchar(5), AFU_HQUANT float, AFU_XSBTSK varchar(12), 
 	                    R_E_C_N_O_ integer);

ALTER TABLE AFU010_TMP add SEQUENCIAL integer;

exec dt_pmsocioso '20120411', '20120423'

DELETE FROM AFU010_TMP

SELECT * FROM AFU010_TMP
 WHERE coalesce(AFU_LOGIN, '') = coalesce(null, '')

SELECT * FROM AFU010 WHERE AFU_DATA = '20120412' AND AFU_RECURS = '3101'
 ORDER BY AFU_RECURS, AFU_HORAI;

If OBJECT_ID('OCIOSIDADE') > 0
   DROP VIEW OCIOSIDADE;

CREATE VIEW OCIOSIDADE AS
  SELECT TMP.AFU_LOGIN, COALESCE(TMP.AFU_PROJET, TMP.AFU_XSBTSK) AS AFU_PROJET, 
         COALESCE(TMP.A1_COD, TMP.AFU_XSBTSK) AS A1_COD, TMP.A1_LOJA, 
         COALESCE(TMP.A1_NOME, TMP.AFU_XSBTSK) AS A1_NOME, TMP.AFU_TAREFA, 
         TMP.AFU_RECURS, AE8.AE8_DESCRI, TMP.AFU_DATA, TMP.AFU_HORAI, TMP.AFU_HORAF, TMP.AFU_HQUANT, 
         TMP.AFU_XSBTSK, COALESCE(SZ6.Z6_DESCRI, TMP.AFU_XSBTSK) AS Z6_DESCRI, SZ6.Z6_TIPO, 
         SZ5.Z5_DESCRI, SZ6.Z6_GRUPO1, SZ5_1.Z5_DESCRI AS Z5_DESCRI_1, SZ6.Z6_GRUPO2, 
         SZ5_2.Z5_DESCRI AS Z5_DESCRI_2, SZ6.Z6_GRUPO3, SZ5_3.Z5_DESCRI AS Z5_DESCRI_3
    FROM AFU010_TMP TMP
    JOIN AE8010 AE8 ON AE8.AE8_FILIAL = '01' AND AE8.D_E_L_E_T_ = ' ' AND AE8.AE8_RECURS = TMP.AFU_RECURS
    LEFT JOIN SZ6010 SZ6 ON SZ6.Z6_FILIAL = '  ' AND SZ6.D_E_L_E_T_ = ' ' AND SZ6.Z6_TAREFA = TMP.AFU_XSBTSK
    LEFT JOIN SZ5010 SZ5 ON SZ5.Z5_FILIAL = '  ' AND SZ5.D_E_L_E_T_ = ' ' AND SZ5.Z5_GRUPO = SZ6.Z6_TIPO
    LEFT JOIN SZ5010 SZ5_1 ON SZ5_1.Z5_FILIAL = '  ' AND SZ5_1.D_E_L_E_T_ = ' ' AND SZ5_1.Z5_GRUPO = SZ6.Z6_GRUPO1
    LEFT JOIN SZ5010 SZ5_2 ON SZ5_2.Z5_FILIAL = '  ' AND SZ5_2.D_E_L_E_T_ = ' ' AND SZ5_2.Z5_GRUPO = SZ6.Z6_GRUPO2
    LEFT JOIN SZ5010 SZ5_3 ON SZ5_3.Z5_FILIAL = '  ' AND SZ5_3.D_E_L_E_T_ = ' ' AND SZ5_3.Z5_GRUPO = SZ6.Z6_GRUPO3;
    
SELECT * FROM SA1010;    

SELECT * FROM OCIOSIDADE
 WHERE AFU_XSBTSK <> 'AUSENTE'
 ORDER BY AFU_RECURS, AFU_DATA, AFU_HORAI;

SELECT * FROM AFU010
 WHERE D_E_L_E_T_ = ' ' AND AFU_RECURS = '3084' AND AFU_DATA BETWEEN '20120410' AND '20120410'
 ORDER BY AFU_RECURS, AFU_DATA, AFU_HORAI;

SELECT * FROM OCIOSIDADE;

-- Horas Negativas
SELECT * FROM AFU010 WHERE D_E_L_E_T_ = ' ' AND AFU_HORAF <> '' AND AFU_HQUANT < 0 
   AND AFU_HORAI < AFU_HORAF

UPDATE AFU010 
   SET AFU_HQUANT = dbo.dt_difhora(AFU_HORAI, AFU_HORAF)
 WHERE D_E_L_E_T_ = ' ' AND AFU_HORAF <> '' AND AFU_HQUANT < 0 AND AFU_HORAI < AFU_HORAF
 
select dbo.dt_difhora('08:00', '09:30');
select dbo.dt_difhora('13:00', '13:15');

SELECT * FROM AFU010 WHERE AFU_DATA >= '20120411' AND AFU_HORAF = '';

SELECT dbo.strzero(Year(CURRENT_TIMESTAMP), 4) + dbo.strzero(Month(CURRENT_TIMESTAMP), 2) + 
       dbo.strzero(Day(CURRENT_TIMESTAMP), 2)

SELECT * FROM AFU010 WHERE AFU_RECURS = '3108' AND AFU_DATA = '20120417' AND D_E_L_E_T_ = ' ';

SELECT * INTO AFU010_180412 FROM AFU010;

UPDATE AFU010 
  SET AFU_DATA = '20120418'
 WHERE AFU_DATA = '20120417' AND R_E_C_N_O_ >= 1695;
 
SELECT * FROM AFU010 WHERE AFU_DATA = '20120418'; 