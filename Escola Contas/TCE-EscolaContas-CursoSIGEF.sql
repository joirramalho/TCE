--SELECT
--	ei.CPF
--	,
--	((count(*) * 1.0)/(
--	select
--		count(*)
--	FROM
--		EscTurma_Dias etd
--	where
--		etd.idturma = ei.idturma))
--FROM
--	EscInscricao ei
--INNER JOIN EscInscricao_Turma_Dias itd ON	ei.idTurma = itd.IdTurma	AND ei.IdInscricao = itd.IdInscricao
--WHERE
--	ei.IdTurma = 508
--GROUP BY
--	ei.CPF,
--	ei.idturma
--HAVING
--	(((count(*)* 1.0)/(
--	select
--		count(*)
--	FROM
--		EscTurma_Dias etd
--	where
--		etd.idturma = ei.idturma)) / 0.75) > 0.98
--order BY
--	ei.CPF




BEGIN TRAN

update
	EscInscricao
set
	concluido = 1,
	dataValidacao = getdate()
where
	cpf in (
	SELECT
		ei.CPF
		--, ((count()*1.0)/(select count() FROM EscTurma_Dias etd where etd.idturma=ei.idturma))
	FROM
		EscInscricao ei
	INNER JOIN EscInscricao_Turma_Dias itd ON		ei.idTurma = itd.IdTurma	AND ei.IdInscricao = itd.IdInscricao
	WHERE 
		ei.IdTurma = 508
	GROUP BY
		ei.CPF,
		ei.idturma
	HAVING 
		(((count(*)* 1.0)/(
		SELECT
			count(*)
		FROM
			EscTurma_Dias etd
		where
			etd.idturma = ei.idturma)) / 0.75) > 0.98
--	order BY
--		ei.CPF
)
	and idturma = 508
	
	
-- COMMIT 
-- ROLLBACK 
	
--	SELECT top 50 * from Processo.dbo.EscInscricao where IdTurma  = 508 order by DataInclusao  DESC
--	SELECT top 50 * from Processo_Audit.dbo.EscInscricao_Audit order by DataConexao  DESC