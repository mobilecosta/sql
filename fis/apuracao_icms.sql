-- Entradas x Saidas
SELECT SUM(CASE WHEN F3_CFO < '5000' THEN F3_VALICM ELSE 0 END) AS ENTRADAS,
       SUM(CASE WHEN F3_CFO > '5000' THEN F3_VALICM ELSE 0 END) AS SAIDAS
  FROM SF3010
 WHERE D_E_L_E_T_ = ' ' AND F3_DTCANC = ' ' AND F3_ENTRADA BETWEEN '20130601' AND '20130630'
   AND F3_TIPO <> 'S'

-- Apuração por Especie
SELECT Case When F3_ESPECIE = 'CA' then '10' Else
       Case When F3_ESPECIE ='CTA' Then '09' Else
       Case When F3_ESPECIE ='CTF' Then '11' Else
       Case When F3_ESPECIE ='CTR' Then '08' Else
       Case When F3_ESPECIE ='NFCEE' Then '06' Else
       Case When F3_ESPECIE ='NFE' Then '01' Else
       Case When F3_ESPECIE ='NFPS' Then '  ' Else
       Case When F3_ESPECIE ='NFS' Then '  ' Else
       Case When F3_ESPECIE ='NFST' Then '07' Else
       Case When F3_ESPECIE ='NFSC' Then '21' Else
       Case When F3_ESPECIE ='NTSC' Then '21' Else
       Case When F3_ESPECIE ='NTST' Then '22' Else
       Case When F3_ESPECIE ='NFCF' Then '02' Else
       Case When F3_ESPECIE ='NFP' Then '04' Else
       Case When F3_ESPECIE ='RMD' Then '18' Else
       Case When F3_ESPECIE ='CTM' Then '26' Else
       Case When F3_ESPECIE ='CF' Or F3_ESPECIE = 'ECF' Then '02' Else
       Case When F3_ESPECIE ='RPS' Then '  ' Else
       Case When F3_ESPECIE ='SPED' Then '55' Else
       Case When F3_ESPECIE ='NFFA' Then '29' Else
       Case When F3_ESPECIE ='NFCFG' Then '28' Else
       Case When F3_ESPECIE ='CTE' Then '57' Else
       Case When F3_ESPECIE ='NFA' Then '1B' Else '  ' End End End End End End End End End End End End End End End End End End End End End End End As Especie,
       SUM(CASE WHEN F3_CFO < '5000' THEN F3_VALICM ELSE 0 END) AS ENTRADAS, 
       SUM(CASE WHEN F3_CFO > '5000' THEN F3_VALICM ELSE 0 END) AS SAIDAS
  FROM SF3010
 WHERE D_E_L_E_T_ = ' ' AND F3_DTCANC = ' ' AND F3_ENTRADA BETWEEN '20130601' AND '20130630'
   AND F3_TIPO <> 'S'
 GROUP BY Case When F3_ESPECIE = 'CA' then '10' Else
       Case When F3_ESPECIE ='CTA' Then '09' Else
       Case When F3_ESPECIE ='CTF' Then '11' Else
       Case When F3_ESPECIE ='CTR' Then '08' Else
       Case When F3_ESPECIE ='NFCEE' Then '06' Else
       Case When F3_ESPECIE ='NFE' Then '01' Else
       Case When F3_ESPECIE ='NFPS' Then '  ' Else
       Case When F3_ESPECIE ='NFS' Then '  ' Else
       Case When F3_ESPECIE ='NFST' Then '07' Else
       Case When F3_ESPECIE ='NFSC' Then '21' Else
       Case When F3_ESPECIE ='NTSC' Then '21' Else
       Case When F3_ESPECIE ='NTST' Then '22' Else
       Case When F3_ESPECIE ='NFCF' Then '02' Else
       Case When F3_ESPECIE ='NFP' Then '04' Else
       Case When F3_ESPECIE ='RMD' Then '18' Else
       Case When F3_ESPECIE ='CTM' Then '26' Else
       Case When F3_ESPECIE ='CF' Or F3_ESPECIE = 'ECF' Then '02' Else
       Case When F3_ESPECIE ='RPS' Then '  ' Else
       Case When F3_ESPECIE ='SPED' Then '55' Else
       Case When F3_ESPECIE ='NFFA' Then '29' Else
       Case When F3_ESPECIE ='NFCFG' Then '28' Else
       Case When F3_ESPECIE ='CTE' Then '57' Else
       Case When F3_ESPECIE ='NFA' Then '1B' Else '  ' End End End End End End End End End End End End End End End End End End End End End End End