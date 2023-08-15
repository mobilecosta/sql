select AFC_EDT, * from AFC010 
 WHERE D_E_L_E_T_ = ' ' 
   AND AFC_XPROD IN ('CELROB006712A', 'CELROB006712B', 'CELROB006712C', 'CELROB006712D', 'CELROB006712E');

-- CELROB006712A  
-- select * from SD3010 WHERE D_E_L_E_T_ = ' ' AND D3_OP = 'MSDJZY01001'
--  ORDER BY D3_COD;

-- CELROB006712B
-- select * from SD3010 WHERE D_E_L_E_T_ = ' ' AND D3_OP = 'MSDK0001001';

SELECT AFA_XESTRU, * FROM AFA010 
 WHERE D_E_L_E_T_ = ' ' AND AFA_PROJET = 'PMS006712A' 
   AND AFA_PRODUT IN ('PNCN.0027.01.MP', 'ENPF.1100.01.MP', 'CDH336N-P322', 'ELBO.0004.05.MP')

select * from SD3010 WHERE D_E_L_E_T_ = ' ' AND D3_OP = 'MSDJZY01001'
   and D3_COD IN ('PNCN.0027.01.MP', 'ENPF.1100.01.MP', 'CDH336N-P322', 'ELBO.0004.05.MP', '157148-1')

-- MSDJZY01001 -- CELROB006712A  
SELECT AFA.AFA_PRODUT, SUM(AFA.AFA_QUANT) AS AFA_QUANT, MIN(SD3.D3_QUANT) AS D3_QUANT 
  FROM AFA010 AFA
  LEFT JOIN SD3010 SD3 ON SD3.D_E_L_E_T_ = ' ' AND SD3.D3_OP = 'MSDJZY01001' AND SD3.D3_COD = AFA.AFA_PRODUT
 WHERE AFA.D_E_L_E_T_ = ' ' AND AFA_PROJET = 'PMS006712A' 
   AND AFA.AFA_XESTRU = 'S'
   AND AFA.AFA_TAREFA IN
(
  SELECT AF9.AF9_TAREFA
    FROM AF9010 AF9
   WHERE AF9.D_E_L_E_T_ = ' ' AND AF9.AF9_PROJET = 'PMS006712A' AND AF9.AF9_EDTPAI = '01'
)
 GROUP BY AFA.AFA_PRODUT
 ORDER BY AFA.AFA_PRODUT;

-- MSDK0301001 -- CELROB006712E  
SELECT AFA.AFA_PRODUT, SUM(AFA.AFA_QUANT) AS AFA_QUANT, MIN(SD3.D3_QUANT) AS D3_QUANT 
  FROM AFA010 AFA
  LEFT JOIN SD3010 SD3 ON SD3.D_E_L_E_T_ = ' ' AND SD3.D3_OP = 'MSDK0301001' AND SD3.D3_COD = AFA.AFA_PRODUT
 WHERE AFA.D_E_L_E_T_ = ' ' AND AFA_PROJET = 'ECO006712A' 
   AND AFA.AFA_XESTRU = 'S'
   AND AFA.AFA_TAREFA IN
(
  SELECT AF9.AF9_TAREFA
    FROM AF9010 AF9
   WHERE AF9.D_E_L_E_T_ = ' ' AND AF9.AF9_PROJET = 'ECO006712A' AND AF9.AF9_EDTPAI = '01'
)
 GROUP BY AFA.AFA_PRODUT
 ORDER BY AFA.AFA_PRODUT;