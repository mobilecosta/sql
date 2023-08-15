-- A00
SELECT A00_FILIAL,A00_CODTER,A00_CODAGR,A00_NIVAGR,A00_IDINT,COUNT(*)
  FROM A00000
 WHERE D_E_L_E_T_ = ' '
 GROUP BY A00_FILIAL,A00_CODTER,A00_CODAGR,A00_NIVAGR,A00_IDINT
HAVING COUNT(*) > 1

SELECT * FROM A00000
 WHERE D_E_L_E_T_ = ' ' 
   AND A00_FILIAL || A00_CODTER || A00_CODAGR || A00_NIVAGR || A00_IDINT IN (
SELECT A00_FILIAL || A00_CODTER || A00_CODAGR || A00_NIVAGR || A00_IDINT
  FROM A00000
 WHERE D_E_L_E_T_ = ' '
 GROUP BY A00_FILIAL,A00_CODTER,A00_CODAGR,A00_NIVAGR,A00_IDINT
HAVING COUNT(*) > 1
)
 ORDER BY A00_FILIAL, A00_CODTER, A00_CODAGR, A00_NIVAGR,A00_IDINT

DELETE FROM A00000
 WHERE D_E_L_E_T_ = ' ' 
   AND A00_FILIAL || A00_CODTER || A00_CODAGR || A00_NIVAGR IN (
SELECT A00_FILIAL || A00_CODTER || A00_CODAGR || A00_NIVAGR
  FROM A00000
 WHERE D_E_L_E_T_ = ' '
 GROUP BY A00_FILIAL,A00_CODTER,A00_CODAGR,A00_NIVAGR
HAVING COUNT(*) > 1
)
   AND R_E_C_N_O_ > (SELECT MIN(R_E_C_N_O_) FROM A00000 A00M WHERE D_E_L_E_T_ = ' '
   AND A00M.A00_FILIAL = A00000.A00_FILIAL AND A00M.A00_CODTER = A00000.A00_CODTER AND A00M.A00_CODAGR = A00000.A00_CODAGR AND A00M.A00_NIVAGR = A00000.A00_NIVAGR)

-- A09
SELECT A09_FILIAL,A09_CODTER,A09_TPMBRO,A09_CODMBR,COUNT(*)
  FROM A09000
 WHERE D_E_L_E_T_ = ' '
 GROUP BY A09_FILIAL,A09_CODTER,A09_TPMBRO,A09_CODMBR
HAVING COUNT(*) > 1

DELETE FROM A09000
 WHERE D_E_L_E_T_ = ' ' 
   AND A09_FILIAL||A09_CODTER||A09_TPMBRO||A09_CODMBR IN (
SELECT A09_FILIAL||A09_CODTER||A09_TPMBRO||A09_CODMBR
  FROM A09000
 WHERE D_E_L_E_T_ = ' '
 GROUP BY A09_FILIAL,A09_CODTER,A09_TPMBRO,A09_CODMBR
HAVING COUNT(*) > 1
)
   AND R_E_C_N_O_ > (SELECT MIN(R_E_C_N_O_) FROM A09000 DUP WHERE D_E_L_E_T_ = ' '
   AND DUP.A09_FILIAL = A09000.A09_FILIAL AND DUP.A09_CODTER = A09000.A09_CODTER AND DUP.A09_TPMBRO = A09000.A09_TPMBRO AND DUP.A09_CODMBR = A09000.A09_CODMBR)

-- AF9
SELECT AF9_FILIAL,AF9_PROJET,AF9_REVISA,AF9_TAREFA,COUNT(*)
  FROM AF9000
 WHERE D_E_L_E_T_ = ' '
 GROUP BY AF9_FILIAL,AF9_PROJET,AF9_REVISA,AF9_TAREFA
HAVING COUNT(*) > 1

DELETE FROM AF9000
 WHERE D_E_L_E_T_ = ' ' 
   AND AF9_FILIAL||AF9_PROJET||AF9_REVISA||AF9_TAREFA IN (
SELECT AF9_FILIAL||AF9_PROJET||AF9_REVISA||AF9_TAREFA
  FROM AF9000
 WHERE D_E_L_E_T_ = ' '
 GROUP BY AF9_FILIAL,AF9_PROJET,AF9_REVISA,AF9_TAREFA
HAVING COUNT(*) > 1
)
   AND R_E_C_N_O_ > (SELECT MIN(R_E_C_N_O_) FROM AF9000 DUP WHERE D_E_L_E_T_ = ' '
   AND DUP.AF9_FILIAL = AF9000.AF9_FILIAL AND DUP.AF9_PROJET = AF9000.AF9_PROJET AND DUP.AF9_REVISA = AF9000.AF9_REVISA AND DUP.AF9_TAREFA = AF9000.AF9_TAREFA)

-- AFA
SELECT AFA_FILIAL,AFA_PROJET,AFA_REVISA,AFA_TAREFA,AFA_ITEM,AFA_PRODUT,AFA_RECURS,COUNT(*)
  FROM AFA000
 WHERE D_E_L_E_T_ = ' '
 GROUP BY AFA_FILIAL,AFA_PROJET,AFA_REVISA,AFA_TAREFA,AFA_ITEM,AFA_PRODUT,AFA_RECURS
HAVING COUNT(*) > 1

DELETE FROM AFA000
 WHERE D_E_L_E_T_ = ' ' 
   AND AFA_FILIAL||AFA_PROJET||AFA_REVISA||AFA_TAREFA||AFA_ITEM||AFA_PRODUT||AFA_RECURS IN (
SELECT AFA_FILIAL||AFA_PROJET||AFA_REVISA||AFA_TAREFA||AFA_ITEM||AFA_PRODUT||AFA_RECURS
  FROM AFA000
 WHERE D_E_L_E_T_ = ' '
 GROUP BY AFA_FILIAL,AFA_PROJET,AFA_REVISA,AFA_TAREFA,AFA_ITEM,AFA_PRODUT,AFA_RECURS
HAVING COUNT(*) > 1
)
   AND R_E_C_N_O_ > (SELECT MIN(R_E_C_N_O_) FROM AFA000 DUP WHERE D_E_L_E_T_ = ' '
   AND DUP.AFA_FILIAL = AFA000.AFA_FILIAL AND DUP.AFA_PROJET = AFA000.AFA_PROJET AND DUP.AFA_REVISA = AFA000.AFA_REVISA AND DUP.AFA_TAREFA = AFA000.AFA_TAREFA
   AND DUP.AFA_ITEM = AFA000.AFA_ITEM AND DUP.AFA_PRODUT = AFA000.AFA_PRODUT AND DUP.AFA_RECURS = AFA000.AFA_RECURS)

-- AFC
SELECT AFC_FILIAL,AFC_PROJET,AFC_REVISA,AFC_EDT,COUNT(*)
  FROM AFC000
 WHERE D_E_L_E_T_ = ' '
 GROUP BY AFC_FILIAL,AFC_PROJET,AFC_REVISA,AFC_EDT
HAVING COUNT(*) > 1

DELETE FROM AFC000
 WHERE D_E_L_E_T_ = ' ' 
   AND AFC_FILIAL||AFC_PROJET||AFC_REVISA||AFC_EDT IN (
SELECT AFC_FILIAL||AFC_PROJET||AFC_REVISA||AFC_EDT
  FROM AFC000
 WHERE D_E_L_E_T_ = ' '
 GROUP BY AFC_FILIAL,AFC_PROJET,AFC_REVISA,AFC_EDT
HAVING COUNT(*) > 1
)
   AND R_E_C_N_O_ > (SELECT MIN(R_E_C_N_O_) FROM AFC000 DUP WHERE D_E_L_E_T_ = ' '
   AND DUP.AFC_FILIAL = AFC000.AFC_FILIAL AND DUP.AFC_PROJET = AFC000.AFC_PROJET AND DUP.AFC_REVISA = AFC000.AFC_REVISA AND DUP.AFC_EDT = AFC000.AFC_EDT)

-- AFD
SELECT AFD_FILIAL,AFD_PROJET,AFD_REVISA,AFD_TAREFA,AFD_ITEM,COUNT(*)
  FROM AFD000
 WHERE D_E_L_E_T_ = ' '
 GROUP BY AFD_FILIAL,AFD_PROJET,AFD_REVISA,AFD_TAREFA,AFD_ITEM
HAVING COUNT(*) > 1

DELETE FROM AFD000
 WHERE D_E_L_E_T_ = ' ' 
   AND AFD_FILIAL||AFD_PROJET||AFD_REVISA||AFD_TAREFA||AFD_ITEM IN (
SELECT AFD_FILIAL||AFD_PROJET||AFD_REVISA||AFD_TAREFA||AFD_ITEM
  FROM AFD000
 WHERE D_E_L_E_T_ = ' '
 GROUP BY AFD_FILIAL,AFD_PROJET,AFD_REVISA,AFD_TAREFA,AFD_ITEM
HAVING COUNT(*) > 1
)
   AND R_E_C_N_O_ > (SELECT MIN(R_E_C_N_O_) FROM AFD000 DUP WHERE D_E_L_E_T_ = ' '
   AND DUP.AFD_FILIAL = AFD000.AFD_FILIAL AND DUP.AFD_PROJET = AFD000.AFD_PROJET AND DUP.AFD_REVISA = AFD000.AFD_REVISA AND DUP.AFD_TAREFA = AFD000.AFD_TAREFA
   AND DUP.AFD_ITEM = AFD000.AFD_ITEM)

-- AFX
SELECT AFX_FILIAL,AFX_PROJET,AFX_REVISA,AFX_EDT,AFX_USER,AFX_GRPUSR,AFX_FASE,COUNT(*)
  FROM AFX000
 WHERE D_E_L_E_T_ = ' '
 GROUP BY AFX_FILIAL,AFX_PROJET,AFX_REVISA,AFX_EDT,AFX_USER,AFX_GRPUSR,AFX_FASE
HAVING COUNT(*) > 1

DELETE FROM AFX000
 WHERE D_E_L_E_T_ = ' ' 
   AND AFX_FILIAL||AFX_PROJET||AFX_REVISA||AFX_EDT||AFX_USER||AFX_GRPUSR||AFX_FASE IN (
SELECT AFX_FILIAL||AFX_PROJET||AFX_REVISA||AFX_EDT||AFX_USER||AFX_GRPUSR||AFX_FASE
  FROM AFX000
 WHERE D_E_L_E_T_ = ' '
 GROUP BY AFX_FILIAL,AFX_PROJET,AFX_REVISA,AFX_EDT,AFX_USER,AFX_GRPUSR,AFX_FASE
HAVING COUNT(*) > 1
)
   AND R_E_C_N_O_ > (SELECT MIN(R_E_C_N_O_) FROM AFX000 DUP WHERE D_E_L_E_T_ = ' '
   AND DUP.AFX_FILIAL = AFX000.AFX_FILIAL AND DUP.AFX_PROJET = AFX000.AFX_PROJET AND DUP.AFX_REVISA = AFX000.AFX_REVISA AND DUP.AFX_EDT = AFX000.AFX_EDT
   AND DUP.AFX_USER = AFX000.AFX_USER AND DUP.AFX_GRPUSR = AFX000.AFX_GRPUSR AND DUP.AFX_FASE = AFX000.AFX_FASE)

-- AZ7
SELECT AZ7_FILIAL,AZ7_CODROD,AZ7_CODFLA,AZ7_TPMEM,AZ7_CODMEM,COUNT(*)
  FROM AZ7000
 WHERE D_E_L_E_T_ = ' '
 GROUP BY AZ7_FILIAL,AZ7_CODROD,AZ7_CODFLA,AZ7_TPMEM,AZ7_CODMEM
HAVING COUNT(*) > 1

DELETE FROM AZ7000
 WHERE D_E_L_E_T_ = ' ' 
   AND AZ7_FILIAL || AZ7_CODROD || AZ7_CODFLA || AZ7_TPMEM || AZ7_CODMEM IN (
SELECT AZ7_FILIAL || AZ7_CODROD || AZ7_CODFLA || AZ7_TPMEM || AZ7_CODMEM
  FROM AZ7000
 WHERE D_E_L_E_T_ = ' '
 GROUP BY AZ7_FILIAL,AZ7_CODROD,AZ7_CODFLA,AZ7_TPMEM,AZ7_CODMEM
HAVING COUNT(*) > 1
)
   AND R_E_C_N_O_ > (SELECT MIN(R_E_C_N_O_) FROM AZ7000 AZ7M WHERE D_E_L_E_T_ = ' '
   AND AZ7M.AZ7_FILIAL = AZ7000.AZ7_FILIAL AND AZ7M.AZ7_CODROD = AZ7000.AZ7_CODROD AND AZ7M.AZ7_CODFLA = AZ7000.AZ7_CODFLA AND AZ7M.AZ7_TPMEM = AZ7000.AZ7_TPMEM
   AND AZ7M.AZ7_CODMEM = AZ7000.AZ7_CODMEM)
