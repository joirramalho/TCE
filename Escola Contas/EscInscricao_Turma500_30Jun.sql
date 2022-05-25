SELECT * FROM esccurso where idcurso = 427


SELECT * FROM [Processo].[dbo].[EscInscricao] where IdTurma = 516 AND IdInscricao = 42230
SELECT * FROM [Processo].[dbo].[EscInscricao] where IdTurma = 500 AND Concluido = 1 AND DataValidacao > '2021-06-23' ORDER BY DataValidacao


begin tran
INSERT INTO  [Processo].[dbo].EscInscricao_Turma500_30Jun -- 23JUN
	SELECT * FROM [Processo].[dbo].[EscInscricao] where IdTurma = 500 AND Concluido = 1 -- AND DataValidacao > '2021-06-23' 
		ORDER BY DataValidacao
-- commit

-- SELECT * FROM [Processo].[dbo].EscInscricao_Turma500_30Jun ORDER BY DataValidacao
-- begin tran
-- -- TRUNCATE TABLE [Processo].[dbo].EscInscricao_Turma500_28Jun -- 28JUN


	---- 
	--begin tran
	--UPDATE [Processo].[dbo].[EscInscricao] 
	--set Concluido = 0, DataValidacao = NULL 
	--where IdTurma = 500 AND Concluido = 1 AND DataValidacao IS NOT NULL
	----commit