SELECT AFA_XESTRU, AFA_QUANT, AFA_XQENTE, * FROM AFA010 WHERE  D_E_L_E_T_ = ' ' AND AFA_PROJET = 'PMS001313A' AND LEFT(AFA_TAREFA, 2) = '01'
   AND AFA_XESTRU = 'S'
   AND AFA_QUANT <> AFA_XQENTE
 ORDER BY AFA_TAREFA, AFA_ITEM;