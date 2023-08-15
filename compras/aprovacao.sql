SELECT * FROM SCR010 WHERE CR_NUM = '009645';

SELECT * FROM SCR010 WHERE D_E_L_E_T_ = ' ' AND CR_NUM in ('009645', '010409', '010690', '011707', '011746', '011747')
 ORDER BY CR_NUM, R_E_C_N_O_;
 
SELECT * FROM SCR010 WHERE CR_NUM = '009645' ORDER BY R_E_C_N_O_;

UPDATE SCR010 
   SET CR_USERLIB = '000158', CR_LIBAPRO = CASE WHEN R_E_C_N_O_ = 8075 THEN '000002' ELSE '' END,
       CR_VALLIB =  CASE WHEN R_E_C_N_O_ = 8075 THEN 2249.78 ELSE 0 END,
       CR_TIPOLIM = CASE WHEN R_E_C_N_O_ = 8075 THEN 'D' ELSE '' END,
       CR_DATALIB = '20120402'
 WHERE R_E_C_N_O_ IN (8075, 8076);
 
UPDATE SCR010 
   SET CR_USERLIB = '000049', CR_LIBAPRO = CASE WHEN R_E_C_N_O_ = 8077 THEN '000003' ELSE '' END,
       CR_VALLIB =  CASE WHEN R_E_C_N_O_ = 8077 THEN 2249.78 ELSE 0 END,
       CR_TIPOLIM = CASE WHEN R_E_C_N_O_ = 8077 THEN 'D' ELSE '' END,
       CR_DATALIB = '20120402'
 WHERE R_E_C_N_O_ IN (8077,8078,8079);