select * from EscInscricao where IdTurma = 508

--select * from EscInscricao_Turma_Dias where IdTurma = 508
--
--select * from EscTurma_Dias where IdTurma = 508 order by IdTurma 


--SELECT DiaMinistrado, EI.CPF, NOME, ORGAO, EMAIL 


SELECT NOME, EI.CPF, count(*)
FROM EscTurma_Dias td
left join EscInscricao_Turma_Dias itd ON td.idTurma = itd.IdTurma AND td.idEscTurma_Dias  = itd.IdEscTurma_Dias
left join EscInscricao ei ON ei.IdInscricao = itd.IdInscricao
LEFT JOIN EscPessoa p ON p.CPF = ei.CPF
where td.IdTurma = 508
	GROUP BY ei.CPF, NOME
	HAVING COUNT(*) >= 4
order by NOME


SELECT * from EscInscricao 	WHERE IdTurma = 508 AND CPF IN (
	SELECT EI.CPF
	FROM EscTurma_Dias td
	left join EscInscricao_Turma_Dias itd ON td.idTurma = itd.IdTurma AND td.idEscTurma_Dias  = itd.IdEscTurma_Dias
	left join EscInscricao ei ON ei.IdInscricao = itd.IdInscricao
	--LEFT JOIN EscPessoa p ON p.CPF = ei.CPF
	where td.IdTurma = 508
		GROUP BY ei.CPF
		HAVING COUNT(*) >= 4
	)

BEGIN TRAN 
	UPDATE EscInscricao
	set Concluido  = 1 
	WHERE IdTurma = 508 AND CPF IN (
	SELECT EI.CPF
	FROM EscTurma_Dias td
	left join EscInscricao_Turma_Dias itd ON td.idTurma = itd.IdTurma AND td.idEscTurma_Dias  = itd.IdEscTurma_Dias
	left join EscInscricao ei ON ei.IdInscricao = itd.IdInscricao
	--LEFT JOIN EscPessoa p ON p.CPF = ei.CPF
	where td.IdTurma = 508
		GROUP BY ei.CPF
		HAVING COUNT(*) >= 4
	)
--ROLLBACK
--COMMIT
	
--SELECT NOME, EI.CPF, td.DiaMinistrado 
--FROM EscTurma_Dias td
--left join EscInscricao_Turma_Dias itd ON td.idTurma = itd.IdTurma AND td.idEscTurma_Dias  = itd.IdEscTurma_Dias
--left join EscInscricao ei ON ei.IdInscricao = itd.IdInscricao
--LEFT JOIN EscPessoa p ON p.CPF = ei.CPF
--where td.IdTurma = 508
--order by NOME, td.DiaMinistrado