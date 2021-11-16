--SELECT d21.cpf, d23.CPF --, COUNT(*) 
--FROM [Processo].[dbo].EscInscricao_Turma500_21Jun d21
--LEFT JOIN [Processo].[dbo].EscInscricao_Turma500_23Jun d23 ON d21.CPF = d23.CPF



--SELECT * INTO #Frequencia
--    FROM [Processo].[dbo].EscInscricao_Turma500_21Jun d21



--INSERT INTO #Frequencia
--        SELECT * FROM [Processo].[dbo].EscInscricao_Turma500_30Jun
s

CREATE TABLE #Resumo ( CPF char(11), Nome char(50), Qtde INT )

INSERT #Resumo  (  CPF, NOME, QTDE )
	SELECT f.CPF, UPPER( Nome ), DataValidacao --, COUNT(*)
	FROM #Frequencia f
	LEFT JOIN EscPessoa p ON f.CPF = p.CPF
	where f.CPF = '86760041100'
	GROUP BY f.CPF, Nome
	HAVING COUNT(*) > 2
	ORDER BY f.CPF


SELECT distinct i.CPF,
	(SELECT TOP 1 CAST(DataValidacao AS smalldatetime ) FROM  [Processo].[dbo].EscInscricao_Turma500_21Jun d21 WHERE d21.CPF = i.CPF),
	(SELECT TOP 1 CAST(DataValidacao AS smalldatetime ) FROM  [Processo].[dbo].EscInscricao_Turma500_23Jun d23 WHERE d23.CPF = i.CPF),
	(SELECT TOP 1 CAST(DataValidacao AS smalldatetime ) FROM  [Processo].[dbo].EscInscricao_Turma500_28Jun d28 WHERE d28.CPF = i.CPF),
	(SELECT TOP 1 CAST(DataValidacao AS smalldatetime ) FROM  [Processo].[dbo].EscInscricao_Turma500_30Jun d30 WHERE d30.CPF = i.CPF)
FROM EscInscricao i
--GROUP BY f.CPF, Nome
--HAVING COUNT(*) > 2
WHERE EXISTS (SELECT * FROM #Resumo R WHERE r.CPF = i.CPF COLLATE SQL_Latin1_General_CP1_CI_AI )
ORDER BY i.CPF

