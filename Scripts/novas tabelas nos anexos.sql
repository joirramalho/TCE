--28set21
	-- CGU_Exportacao_BdSIAI
SELECT sob.name AS Table_Name FROM sysobjects sob 
WHERE sob.xtype='u'  
AND LEFT( name, 7 ) IN ('Anexo01', 'Anexo03','Anexo04','Anexo05','Anexo06','Anexo07','Anexo08','Anexo09','Anexo10','Anexo11','Anexo12','Anexo13', 'Anexo14','Anexo15','Anexo16','Anexo17','Anexo18','Anexo19','Anexo23','Anexo38','Anexo42') 
--AND LEFT( name, 5 ) = 'Envio'
AND NOT EXISTS ( SELECT NAME FROM CGU_Exportacao_BdSIAI.dbo.sysobjects CGU WHERE sob.name = CGU.name )
ORDER BY Table_Name
