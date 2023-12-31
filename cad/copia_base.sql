-- PROJETOS
DELETE FROM AF8010;
INSERT INTO AF8010(       AF8_FILIAL
      ,AF8_PROJET
      ,AF8_DATA
      ,AF8_XCODSR
      ,AF8_DESCRI
      ,AF8_CLIENT
      ,AF8_LOJA
      ,AF8_XNOMCL
      ,AF8_REVISA
      ,AF8_GETTRF
      ,AF8_TPPRJ
      ,AF8_ORCAME
      ,AF8_STATUS
      ,AF8_START
      ,AF8_FINISH
      ,AF8_DTATUI
      ,AF8_DTATUF
      ,AF8_CALEND
      ,AF8_LOCPAD
      ,AF8_CODMEM
      ,AF8_FASE
      ,AF8_PRJREV
      ,AF8_CTRUSR
      ,AF8_TPPERI
      ,AF8_INIPER
      ,AF8_FIMPER
      ,AF8_TPCUS
      ,AF8_CNVPRV
      ,AF8_DTCONV
      ,AF8_DELIM
      ,AF8_MASCAR
      ,AF8_NMAX
      ,AF8_NMAXF3
      ,AF8_RECALC
      ,AF8_ULMES
      ,AF8_TRUNCA
      ,AF8_BDI
      ,AF8_VALBDI
      ,AF8_REALOC
      ,AF8_PRIREA
      ,AF8_BDIPAD
      ,AF8_AUTCUS
      ,AF8_ENCPRJ
      ,AF8_CUSOP
      ,AF8_CUSOPE
      ,AF8_REAFIX
      ,AF8_PAR002
      ,AF8_PAR001
      ,AF8_PAR003
      ,AF8_XREPRE
      ,AF8_XCOMIS
      ,AF8_XVENDE
      ,AF8_XRESP1
      ,AF8_XRESP2
      ,AF8_XPROP
      ,AF8_XVLACO
      ,AF8_XDOORC
      ,AF8_XDOREA
      ,AF8_XPRJOR
      ,AF8_XNMAPR
      ,AF8_XDTAPR
      ,AF8_XHRAPR
      ,AF8_XDESP
      ,D_E_L_E_T_
      ,R_E_C_N_O_
      ,R_E_C_D_E_L_) 
SELECT        AF8_FILIAL
      ,AF8_PROJET
      ,AF8_DATA
      ,AF8_XCODSR
      ,AF8_DESCRI
      ,AF8_CLIENT
      ,AF8_LOJA
      ,AF8_XNOMCL
      ,AF8_REVISA
      ,AF8_GETTRF
      ,AF8_TPPRJ
      ,AF8_ORCAME
      ,AF8_STATUS
      ,AF8_START
      ,AF8_FINISH
      ,AF8_DTATUI
      ,AF8_DTATUF
      ,AF8_CALEND
      ,AF8_LOCPAD
      ,AF8_CODMEM
      ,AF8_FASE
      ,AF8_PRJREV
      ,AF8_CTRUSR
      ,AF8_TPPERI
      ,AF8_INIPER
      ,AF8_FIMPER
      ,AF8_TPCUS
      ,AF8_CNVPRV
      ,AF8_DTCONV
      ,AF8_DELIM
      ,AF8_MASCAR
      ,AF8_NMAX
      ,AF8_NMAXF3
      ,AF8_RECALC
      ,AF8_ULMES
      ,AF8_TRUNCA
      ,AF8_BDI
      ,AF8_VALBDI
      ,AF8_REALOC
      ,AF8_PRIREA
      ,AF8_BDIPAD
      ,AF8_AUTCUS
      ,AF8_ENCPRJ
      ,AF8_CUSOP
      ,AF8_CUSOPE
      ,AF8_REAFIX
      ,AF8_PAR002
      ,AF8_PAR001
      ,AF8_PAR003
      ,AF8_XREPRE
      ,AF8_XCOMIS
      ,AF8_XVENDE
      ,AF8_XRESP1
      ,AF8_XRESP2
      ,AF8_XPROP
      ,AF8_XVLACO
      ,AF8_XDOORC
      ,AF8_XDOREA
      ,AF8_XPRJOR
      ,AF8_XNMAPR
      ,AF8_XDTAPR
      ,AF8_XHRAPR
      ,AF8_XDESP
      ,D_E_L_E_T_
      ,R_E_C_N_O_
      ,R_E_C_D_E_L_ FROM ZT8HTG.dbo.AF8010;

DELETE FROM AF9010;
INSERT INTO AF9010 SELECT * FROM ZT8HTG.dbo.AF9010;

-- EDT
DELETE FROM AFC010;
INSERT INTO AFC010 SELECT * FROM ZT8HTG.dbo.AFC010;

-- TAREFAS
DELETE FROM AFA010;
INSERT INTO AFA010 SELECT * FROM ZT8HTG.dbo.AFA010;

INSERT AF8010
SELECT * FROM recover.dbo.AF8010;

-- SC POR PROJETOS
DELETE FROM AFG010;
INSERT INTO AFG010 (
       AFG_FILIAL
      ,AFG_PROJET
      ,AFG_TAREFA
      ,AFG_NUMSC
      ,AFG_ITEMSC
      ,AFG_COD
      ,AFG_QUANT
      ,AFG_TRT
      ,AFG_QTSEGU
      ,AFG_REVISA
      ,AFG_PLANEJ
      ,D_E_L_E_T_
      ,R_E_C_N_O_
      ,R_E_C_D_E_L_
      ,AFG_AFAITE
      ,AFG_NATEND
      ,AFG_NATEN2
)      
SELECT 
       AFG_FILIAL
      ,AFG_PROJET
      ,AFG_TAREFA
      ,AFG_NUMSC
      ,AFG_ITEMSC
      ,AFG_COD
      ,AFG_QUANT
      ,AFG_TRT
      ,AFG_QTSEGU
      ,AFG_REVISA
      ,AFG_PLANEJ
      ,D_E_L_E_T_
      ,R_E_C_N_O_
      ,R_E_C_D_E_L_
      ,AFG_AFAITE
      ,AFG_NATEND
      ,AFG_NATEN2
  FROM ZT8HTG.dbo.AFG010;

DELETE FROM SC1010;
INSERT INTO SC1010 SELECT * FROM ZT8HTG.dbo.SC1010;

DELETE FROM SC7010;
INSERT INTO SC7010 SELECT * FROM ZT8HTG.dbo.SC7010;

DELETE FROM SD1010;
INSERT INTO SD1010 SELECT * FROM ZT8HTG.dbo.SD1010;

DELETE FROM SF1010;  --
INSERT INTO SF1010(
       F1_FILIAL
      ,F1_DOC
      ,F1_SERIE
      ,F1_FORNECE
      ,F1_LOJA
      ,F1_COND
      ,F1_DUPL
      ,F1_EMISSAO
      ,F1_EST
      ,F1_FRETE
      ,F1_PLACA
      ,F1_FIMP
      ,F1_DESPESA
      ,F1_BASEICM
      ,F1_VALICM
      ,F1_BASEIPI
      ,F1_VALIPI
      ,F1_VALMERC
      ,F1_VALBRUT
      ,F1_TIPO
      ,F1_DESCONT
      ,F1_DTDIGIT
      ,F1_CPROVA
      ,F1_BRICMS
      ,F1_ICMSRET
      ,F1_BASEFD
      ,F1_DTLANC
      ,F1_OK
      ,F1_ORIGLAN
      ,F1_TX
      ,F1_CONTSOC
      ,F1_IRRF
      ,F1_FORMUL
      ,F1_NFORIG
      ,F1_SERORIG
      ,F1_ESPECIE
      ,F1_IMPORT
      ,F1_II
      ,F1_REMITO
      ,F1_BASIMP2
      ,F1_BASIMP3
      ,F1_BASIMP4
      ,F1_BASIMP5
      ,F1_BASIMP6
      ,F1_VALIMP1
      ,F1_VALIMP2
      ,F1_VALIMP3
      ,F1_VALIMP4
      ,F1_VALIMP5
      ,F1_VALIMP6
      ,F1_ORDPAGO
      ,F1_HORA
      ,F1_INSS
      ,F1_ISS
      ,F1_BASIMP1
      ,F1_HAWB
      ,F1_TIPO_NF
      ,F1_IPI
      ,F1_ICMS
      ,F1_PESOL
      ,F1_FOB_R
      ,F1_SEGURO
      ,F1_CIF
      ,F1_MOEDA
      ,F1_PREFIXO
      ,F1_STATUS
      ,F1_VALEMB
      ,F1_BASEIR
      ,F1_BASEINS
      ,F1_RECBMTO
      ,F1_APROV
      ,F1_CTR_NFC
      ,F1_TXMOEDA
      ,F1_PEDVEND
      ,F1_TIPODOC
      ,F1_TIPOREM
      ,F1_VALPIS
      ,F1_GNR
      ,F1_VALCOFI
      ,F1_MSG_NF
      ,F1_VALCSLL
      ,F1_USERLGI
      ,F1_USERLGA
      ,F1_YNATU
      ,F1_NUMRA
      ,F1_DOCFOL
      ,F1_VERBAFO
      ,F1_BASEPS3
      ,F1_VALPS3
      ,F1_BASECF3
      ,F1_VALCF3
      ,F1_NFELETR
      ,F1_EMINFE
      ,F1_CODNFE
      ,F1_CREDNFE
      ,F1_VNAGREG
      ,F1_TPNFEXP
      ,F1_VALFDS
      ,F1_NUMRPS
      ,F1_RECISS
      ,F1_ESTCRED
      ,F1_CHVNFE
      ,F1_TRANSP
      ,F1_PLIQUI
      ,F1_PBRUTO
      ,F1_ESPECI1
      ,F1_VOLUME1
      ,F1_ESPECI2
      ,F1_VOLUME2
      ,F1_ESPECI3
      ,F1_VOLUME3
      ,F1_ESPECI4
      ,F1_VOLUME4
      ,F1_VALIRF
      ,F1_NUMMOV
      ,F1_FILORIG
      ,F1_NODIA
      ,F1_DIACTB
      ,F1_TPFRETE
      ,F1_VALFAB
      ,F1_VALFAC
      ,F1_VALFET
      ,F1_HORNFE
      ,F1_BASEFUN
      ,F1_VALPEDG
      ,F1_FORRET
      ,F1_LOJARET
      ,F1_VALINA
      ,F1_BASEINA
      ,F1_BASPIS
      ,F1_BASCOFI
      ,F1_BASCSLL
      ,F1_RECOPI
      ,D_E_L_E_T_
      ,R_E_C_N_O_
      ,R_E_C_D_E_L_)
      
 SELECT 
        F1_FILIAL
      ,F1_DOC
      ,F1_SERIE
      ,F1_FORNECE
      ,F1_LOJA
      ,F1_COND
      ,F1_DUPL
      ,F1_EMISSAO
      ,F1_EST
      ,F1_FRETE
      ,F1_PLACA
      ,F1_FIMP
      ,F1_DESPESA
      ,F1_BASEICM
      ,F1_VALICM
      ,F1_BASEIPI
      ,F1_VALIPI
      ,F1_VALMERC
      ,F1_VALBRUT
      ,F1_TIPO
      ,F1_DESCONT
      ,F1_DTDIGIT
      ,F1_CPROVA
      ,F1_BRICMS
      ,F1_ICMSRET
      ,F1_BASEFD
      ,F1_DTLANC
      ,F1_OK
      ,F1_ORIGLAN
      ,F1_TX
      ,F1_CONTSOC
      ,F1_IRRF
      ,F1_FORMUL
      ,F1_NFORIG
      ,F1_SERORIG
      ,F1_ESPECIE
      ,F1_IMPORT
      ,F1_II
      ,F1_REMITO
      ,F1_BASIMP2
      ,F1_BASIMP3
      ,F1_BASIMP4
      ,F1_BASIMP5
      ,F1_BASIMP6
      ,F1_VALIMP1
      ,F1_VALIMP2
      ,F1_VALIMP3
      ,F1_VALIMP4
      ,F1_VALIMP5
      ,F1_VALIMP6
      ,F1_ORDPAGO
      ,F1_HORA
      ,F1_INSS
      ,F1_ISS
      ,F1_BASIMP1
      ,F1_HAWB
      ,F1_TIPO_NF
      ,F1_IPI
      ,F1_ICMS
      ,F1_PESOL
      ,F1_FOB_R
      ,F1_SEGURO
      ,F1_CIF
      ,F1_MOEDA
      ,F1_PREFIXO
      ,F1_STATUS
      ,F1_VALEMB
      ,F1_BASEIR
      ,F1_BASEINS
      ,F1_RECBMTO
      ,F1_APROV
      ,F1_CTR_NFC
      ,F1_TXMOEDA
      ,F1_PEDVEND
      ,F1_TIPODOC
      ,F1_TIPOREM
      ,F1_VALPIS
      ,F1_GNR
      ,F1_VALCOFI
      ,F1_MSG_NF
      ,F1_VALCSLL
      ,F1_USERLGI
      ,F1_USERLGA
      ,F1_YNATU
      ,F1_NUMRA
      ,F1_DOCFOL
      ,F1_VERBAFO
      ,F1_BASEPS3
      ,F1_VALPS3
      ,F1_BASECF3
      ,F1_VALCF3
      ,F1_NFELETR
      ,F1_EMINFE
      ,F1_CODNFE
      ,F1_CREDNFE
      ,F1_VNAGREG
      ,F1_TPNFEXP
      ,F1_VALFDS
      ,F1_NUMRPS
      ,F1_RECISS
      ,F1_ESTCRED
      ,F1_CHVNFE
      ,F1_TRANSP
      ,F1_PLIQUI
      ,F1_PBRUTO
      ,F1_ESPECI1
      ,F1_VOLUME1
      ,F1_ESPECI2
      ,F1_VOLUME2
      ,F1_ESPECI3
      ,F1_VOLUME3
      ,F1_ESPECI4
      ,F1_VOLUME4
      ,F1_VALIRF
      ,F1_NUMMOV
      ,F1_FILORIG
      ,F1_NODIA
      ,F1_DIACTB
      ,F1_TPFRETE
      ,F1_VALFAB
      ,F1_VALFAC
      ,F1_VALFET
      ,F1_HORNFE
      ,F1_BASEFUN
      ,F1_VALPEDG
      ,F1_FORRET
      ,F1_LOJARET
      ,F1_VALINA
      ,F1_BASEINA
      ,F1_BASPIS
      ,F1_BASCOFI
      ,F1_BASCSLL
      ,F1_RECOPI
      ,D_E_L_E_T_
      ,R_E_C_N_O_
      ,R_E_C_D_E_L_
 FROM ZT8HTG.dbo.SF1010;

-- DESPESAS POR PROJETOS
DELETE FROM AFR010; --
INSERT INTO AFR010(
AFR_FILIAL
      ,AFR_PROJET
      ,AFR_TAREFA
      ,AFR_TIPOD
      ,AFR_PREFIX
      ,AFR_NUM
      ,AFR_PARCEL
      ,AFR_TIPO
      ,AFR_FORNEC
      ,AFR_LOJA
      ,AFR_VALOR1
      ,AFR_VALOR2
      ,AFR_VALOR3
      ,AFR_VALOR4
      ,AFR_VALOR5
      ,AFR_REVISA
      ,AFR_DATA
      ,AFR_VENREA
      ,D_E_L_E_T_
      ,R_E_C_N_O_
      ,AFR_XQTDE
      ,AFR_XVAL_C)
SELECT AFR_FILIAL
      ,AFR_PROJET
      ,AFR_TAREFA
      ,AFR_TIPOD
      ,AFR_PREFIX
      ,AFR_NUM
      ,AFR_PARCEL
      ,AFR_TIPO
      ,AFR_FORNEC
      ,AFR_LOJA
      ,AFR_VALOR1
      ,AFR_VALOR2
      ,AFR_VALOR3
      ,AFR_VALOR4
      ,AFR_VALOR5
      ,AFR_REVISA
      ,AFR_DATA
      ,AFR_VENREA
      ,D_E_L_E_T_
      ,R_E_C_N_O_
      ,AFR_XQTDE
      ,AFR_XVAL_C
  FROM ZT8HTG.dbo.AFR010;

-- CONTAS A PAGAR
DELETE FROM SE2010;
INSERT INTO SE2010 SELECT * FROM ZT8HTG.dbo.SE2010;

-- PRODUTOS
DELETE FROM SB1010;
INSERT INTO SB1010
(
       B1_FILIAL
      ,B1_COD
      ,B1_CODAUX
      ,B1_CODANTI
      ,B1_CODITE
      ,B1_DESC
      ,B1_DESC1
      ,B1_TIPO
      ,B1_UM
      ,B1_POSIPI
      ,B1_ESPECIE
      ,B1_EX_NCM
      ,B1_EX_NBM
      ,B1_LOCPAD
      ,B1_GRUPO
      ,B1_XCTROLE
      ,B1_PICM
      ,B1_IPI
      ,B1_ALIQISS
      ,B1_MSBLQL
      ,B1_CODISS
      ,B1_BITMAP
      ,B1_SEGUM
      ,B1_TE
      ,B1_TS
      ,B1_PICMRET
      ,B1_PICMENT
      ,B1_IMPZFRC
      ,B1_CONV
      ,B1_TIPCONV
      ,B1_FATYEA
      ,B1_LISTYEA
      ,B1_FATYEB
      ,B1_UCOM
      ,B1_LISTYEB
      ,B1_PRV1
      ,B1_ESTFOR
      ,B1_ALTER
      ,B1_QE
      ,B1_EMIN
      ,B1_CUSTD
      ,B1_UCALSTD
      ,B1_UPRC
      ,B1_MCUSTD
      ,B1_PESO
      ,B1_PESBRU
      ,B1_FORPRZ
      ,B1_PE
      ,B1_TIPE
      ,B1_LOJPROC
      ,B1_LE
      ,B1_LM
      ,B1_CONTA
      ,B1_TOLER
      ,B1_CC
      ,B1_ITEMCC
      ,B1_UREV
      ,B1_DATREF
      ,B1_FAMILIA
      ,B1_PROC
      ,B1_QB
      ,B1_APROPRI
      ,B1_DTREFP1
      ,B1_TIPODEC
      ,B1_ORIGEM
      ,B1_CLASFIS
      ,B1_FANTASM
      ,B1_RASTRO
      ,B1_CONINI
      ,B1_CONTSOC
      ,B1_FORAEST
      ,B1_CODBAR
      ,B1_GRADE
      ,B1_FORMLOT
      ,B1_COMIS
      ,B1_FPCOD
      ,B1_MONO
      ,B1_CONTRAT
      ,B1_DESC_P
      ,B1_DESC_GI
      ,B1_DESC_I
      ,B1_PERINV
      ,B1_GRTRIB
      ,B1_OPC
      ,B1_ANUENTE
      ,B1_CODOBS
      ,B1_MRP
      ,B1_NOTAMIN
      ,B1_FABRIC
      ,B1_PRVALID
      ,B1_NUMCOP
      ,B1_IRRF
      ,B1_LOCALIZ
      ,B1_PRODPAI
      ,B1_OPERPAD
      ,B1_VLREFUS
      ,B1_IMPORT
      ,B1_SITPROD
      ,B1_MODELO
      ,B1_SETOR
      ,B1_BALANCA
      ,B1_TECLA
      ,B1_TIPOCQ
      ,B1_NALNCCA
      ,B1_SOLICIT
      ,B1_GRUPCOM
      ,B1_NALSH
      ,B1_NUMCQPR
      ,B1_CONTCQP
      ,B1_REVATU
      ,B1_CODEMB
      ,B1_INSS
      ,B1_DATASUB
      ,B1_ESPECIF
      ,B1_MAT_PRI
      ,B1_REDINSS
      ,B1_ALADI
      ,B1_REDIRRF
      ,B1_TAB_IPI
      ,B1_GRUDES
      ,B1_REDPIS
      ,B1_REDCOF
      ,B1_PCSLL
      ,B1_PCOFINS
      ,B1_QTDSER
      ,B1_PPIS
      ,B1_MTBF
      ,B1_MTTR
      ,B1_FLAGSUG
      ,B1_CLASSVE
      ,B1_MIDIA
      ,B1_QTMIDIA
      ,B1_VLR_IPI
      ,B1_ENVOBR
      ,B1_SERIE
      ,B1_FAIXAS
      ,B1_NROPAG
      ,B1_ISBN
      ,B1_TITORIG
      ,B1_LINGUA
      ,B1_EDICAO
      ,B1_CORPRI
      ,B1_CORSEC
      ,B1_NICONE
      ,B1_ATRIB1
      ,B1_ATRIB2
      ,B1_ATRIB3
      ,B1_REGSEQ
      ,B1_OBSISBN
      ,B1_CLVL
      ,B1_ATIVO
      ,B1_EMAX
      ,B1_REQUIS
      ,B1_SELO
      ,B1_LOTVEN
      ,B1_OK
      ,B1_TIPCAR
      ,B1_ESTSEG
      ,B1_VLR_ICM
      ,B1_VLRSELO
      ,B1_CODNOR
      ,B1_CPOTENC
      ,B1_POTENCI
      ,B1_QTDACUM
      ,B1_QTDINIC
      ,B1_UMOEC
      ,B1_UVLRC
      ,B1_PIS
      ,B1_COFINS
      ,B1_CSLL
      ,B1_POSICAO
      ,B1_HIS_COD
      ,B1_USERLGI
      ,B1_USERLGA
      ,B1_CNAE
      ,B1_YOK
      ,B1_FRETISS
      ,B1_TPREG
      ,B1_RETOPER
      ,B1_CALCFET
      ,B1_PAUTFET
      ,B1_PRFDSUL
      ,B1_CLASSE
      ,B1_FECP
      ,B1_VLR_PIS
      ,B1_VLR_COF
      ,B1_CODANT
      ,B1_REGRISS
      ,B1_IVAAJU
      ,B1_ESCRIPI
      ,B1_BASTSC
      ,B1_FUSTF
      ,B1_PARCEI
      ,B1_QUADPRO
      ,B1_DESPIMP
      ,B1_AGREGCU
      ,B1_FRACPER
      ,B1_USAFEFO
      ,B1_INT_ICM
      ,B1_GCCUSTO
      ,B1_CCCUSTO
      ,B1_PMACNUT
      ,B1_PMICNUT
      ,B1_CODQAD
      ,B1_CRDEST
      ,B1_QBP
      ,B1_FETHAB
      ,B1_RPRODEP
      ,B1_SELOEN
      ,B1_ALFECOP
      ,B1_ALFECST
      ,B1_FECOP
      ,B1_CRICMS
      ,B1_PRODREC
      ,B1_TRIBMUN
      ,B1_VIGENC
      ,B1_CRDPRES
      ,B1_VEREAN
      ,B1_CFEM
      ,B1_CFEMS
      ,B1_CFEMA
      ,B1_ALFUMAC
      ,B1_DTCORTE
      ,B1_AFETHAB
      ,B1_AFACS
      ,B1_AFABOV
      ,B1_TFETHAB
      ,B1_REFBAS
      ,B1_TPPROD
      ,B1_PRN944I
      ,B1_PRDORI
      ,B1_RICM65
      ,B1_CODLAN
      ,B1_XCATEG
      ,B1_TNATREC
      ,B1_XTPSRV
      ,B1_CNATREC
      ,B1_PR43080
      ,B1_DCI
      ,B1_DCRE
      ,B1_DCR
      ,B1_DCRII
      ,B1_COEFDCR
      ,B1_CHASSI
      ,B1_REGESIM
      ,B1_GRPNATR
      ,B1_DTFIMNT
      ,B1_FECPBA
      ,B1_CRICMST
      ,B1_DIFCNAE
      ,B1_PRINCMG
      ,B1_ALFECRN
      ,B1_XPRJSOC
      ,D_E_L_E_T_
      ,R_E_C_N_O_
      ,R_E_C_D_E_L_
)
 SELECT 
        B1_FILIAL
      ,B1_COD
      ,B1_CODAUX
      ,B1_CODANTI
      ,B1_CODITE
      ,B1_DESC
      ,B1_DESC1
      ,B1_TIPO
      ,B1_UM
      ,B1_POSIPI
      ,B1_ESPECIE
      ,B1_EX_NCM
      ,B1_EX_NBM
      ,B1_LOCPAD
      ,B1_GRUPO
      ,B1_XCTROLE
      ,B1_PICM
      ,B1_IPI
      ,B1_ALIQISS
      ,B1_MSBLQL
      ,B1_CODISS
      ,B1_BITMAP
      ,B1_SEGUM
      ,B1_TE
      ,B1_TS
      ,B1_PICMRET
      ,B1_PICMENT
      ,B1_IMPZFRC
      ,B1_CONV
      ,B1_TIPCONV
      ,B1_FATYEA
      ,B1_LISTYEA
      ,B1_FATYEB
      ,B1_UCOM
      ,B1_LISTYEB
      ,B1_PRV1
      ,B1_ESTFOR
      ,B1_ALTER
      ,B1_QE
      ,B1_EMIN
      ,B1_CUSTD
      ,B1_UCALSTD
      ,B1_UPRC
      ,B1_MCUSTD
      ,B1_PESO
      ,B1_PESBRU
      ,B1_FORPRZ
      ,B1_PE
      ,B1_TIPE
      ,B1_LOJPROC
      ,B1_LE
      ,B1_LM
      ,B1_CONTA
      ,B1_TOLER
      ,B1_CC
      ,B1_ITEMCC
      ,B1_UREV
      ,B1_DATREF
      ,B1_FAMILIA
      ,B1_PROC
      ,B1_QB
      ,B1_APROPRI
      ,B1_DTREFP1
      ,B1_TIPODEC
      ,B1_ORIGEM
      ,B1_CLASFIS
      ,B1_FANTASM
      ,B1_RASTRO
      ,B1_CONINI
      ,B1_CONTSOC
      ,B1_FORAEST
      ,B1_CODBAR
      ,B1_GRADE
      ,B1_FORMLOT
      ,B1_COMIS
      ,B1_FPCOD
      ,B1_MONO
      ,B1_CONTRAT
      ,B1_DESC_P
      ,B1_DESC_GI
      ,B1_DESC_I
      ,B1_PERINV
      ,B1_GRTRIB
      ,B1_OPC
      ,B1_ANUENTE
      ,B1_CODOBS
      ,B1_MRP
      ,B1_NOTAMIN
      ,B1_FABRIC
      ,B1_PRVALID
      ,B1_NUMCOP
      ,B1_IRRF
      ,B1_LOCALIZ
      ,B1_PRODPAI
      ,B1_OPERPAD
      ,B1_VLREFUS
      ,B1_IMPORT
      ,B1_SITPROD
      ,B1_MODELO
      ,B1_SETOR
      ,B1_BALANCA
      ,B1_TECLA
      ,B1_TIPOCQ
      ,B1_NALNCCA
      ,B1_SOLICIT
      ,B1_GRUPCOM
      ,B1_NALSH
      ,B1_NUMCQPR
      ,B1_CONTCQP
      ,B1_REVATU
      ,B1_CODEMB
      ,B1_INSS
      ,B1_DATASUB
      ,B1_ESPECIF
      ,B1_MAT_PRI
      ,B1_REDINSS
      ,B1_ALADI
      ,B1_REDIRRF
      ,B1_TAB_IPI
      ,B1_GRUDES
      ,B1_REDPIS
      ,B1_REDCOF
      ,B1_PCSLL
      ,B1_PCOFINS
      ,B1_QTDSER
      ,B1_PPIS
      ,B1_MTBF
      ,B1_MTTR
      ,B1_FLAGSUG
      ,B1_CLASSVE
      ,B1_MIDIA
      ,B1_QTMIDIA
      ,B1_VLR_IPI
      ,B1_ENVOBR
      ,B1_SERIE
      ,B1_FAIXAS
      ,B1_NROPAG
      ,B1_ISBN
      ,B1_TITORIG
      ,B1_LINGUA
      ,B1_EDICAO
      ,B1_CORPRI
      ,B1_CORSEC
      ,B1_NICONE
      ,B1_ATRIB1
      ,B1_ATRIB2
      ,B1_ATRIB3
      ,B1_REGSEQ
      ,B1_OBSISBN
      ,B1_CLVL
      ,B1_ATIVO
      ,B1_EMAX
      ,B1_REQUIS
      ,B1_SELO
      ,B1_LOTVEN
      ,B1_OK
      ,B1_TIPCAR
      ,B1_ESTSEG
      ,B1_VLR_ICM
      ,B1_VLRSELO
      ,B1_CODNOR
      ,B1_CPOTENC
      ,B1_POTENCI
      ,B1_QTDACUM
      ,B1_QTDINIC
      ,B1_UMOEC
      ,B1_UVLRC
      ,B1_PIS
      ,B1_COFINS
      ,B1_CSLL
      ,B1_POSICAO
      ,B1_HIS_COD
      ,B1_USERLGI
      ,B1_USERLGA
      ,B1_CNAE
      ,B1_YOK
      ,B1_FRETISS
      ,B1_TPREG
      ,B1_RETOPER
      ,B1_CALCFET
      ,B1_PAUTFET
      ,B1_PRFDSUL
      ,B1_CLASSE
      ,B1_FECP
      ,B1_VLR_PIS
      ,B1_VLR_COF
      ,B1_CODANT
      ,B1_REGRISS
      ,B1_IVAAJU
      ,B1_ESCRIPI
      ,B1_BASTSC
      ,B1_FUSTF
      ,B1_PARCEI
      ,B1_QUADPRO
      ,B1_DESPIMP
      ,B1_AGREGCU
      ,B1_FRACPER
      ,B1_USAFEFO
      ,B1_INT_ICM
      ,B1_GCCUSTO
      ,B1_CCCUSTO
      ,B1_PMACNUT
      ,B1_PMICNUT
      ,B1_CODQAD
      ,B1_CRDEST
      ,B1_QBP
      ,B1_FETHAB
      ,B1_RPRODEP
      ,B1_SELOEN
      ,B1_ALFECOP
      ,B1_ALFECST
      ,B1_FECOP
      ,B1_CRICMS
      ,B1_PRODREC
      ,B1_TRIBMUN
      ,B1_VIGENC
      ,B1_CRDPRES
      ,B1_VEREAN
      ,B1_CFEM
      ,B1_CFEMS
      ,B1_CFEMA
      ,B1_ALFUMAC
      ,B1_DTCORTE
      ,B1_AFETHAB
      ,B1_AFACS
      ,B1_AFABOV
      ,B1_TFETHAB
      ,B1_REFBAS
      ,B1_TPPROD
      ,B1_PRN944I
      ,B1_PRDORI
      ,B1_RICM65
      ,B1_CODLAN
      ,B1_XCATEG
      ,B1_TNATREC
      ,B1_XTPSRV
      ,B1_CNATREC
      ,B1_PR43080
      ,B1_DCI
      ,B1_DCRE
      ,B1_DCR
      ,B1_DCRII
      ,B1_COEFDCR
      ,B1_CHASSI
      ,B1_REGESIM
      ,B1_GRPNATR
      ,B1_DTFIMNT
      ,B1_FECPBA
      ,B1_CRICMST
      ,B1_DIFCNAE
      ,B1_PRINCMG
      ,B1_ALFECRN
      ,B1_XPRJSOC
      ,D_E_L_E_T_
      ,R_E_C_N_O_
      ,R_E_C_D_E_L_
 FROM ZT8HTG.dbo.SB1010;