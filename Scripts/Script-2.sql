USE [BdSIAI]
GO

IF NOT EXISTS( SELECT * FROM sys.indexes WHERE name='IX_Anexo38_EditalAnexo_IdEditalLicitacaoDispensada' AND object_id = OBJECT_ID('Anexo38_EditalAnexo') )
BEGIN
	CREATE INDEX [IX_Anexo38_EditalAnexo_IdEditalLicitacaoDispensada] ON [BdSIAI].[dbo].[Anexo38_EditalAnexo] ([IdEditalLicitacaoDispensada])
END
ELSE
	SELECT 1

IF NOT EXISTS( SELECT * FROM sys.indexes WHERE name='IX_Anexo38_EditalAnexo_IdEditalSRP' AND object_id = OBJECT_ID('dbo.Anexo38_EditalAnexo') )
BEGIN
	CREATE INDEX [IX_Anexo38_EditalAnexo_IdEditalSRP] ON [BdSIAI].[dbo].[Anexo38_EditalAnexo] ([IdEditalSRP]) INCLUDE ([IdEditalAnexo], [IdEditalLicitacaoPublica], [IdEditalLicitacaoDispensada], [IdEditalLicitacaoRegimeEstatal], [IdEditalLicitacaoInaplicabilidade], [NomeArquivoAnexo], [HashArquivoAnexo], [IdTipoDocumentacao], [Ativo], [DataInclusao], [IdSessao], [IdSessaoOperacao])
END

IF NOT EXISTS( SELECT * FROM sys.indexes WHERE name='IX_Anexo38_EditalAnexo_IdEditalLicitacaoRegimeEstatal' AND object_id = OBJECT_ID('dbo.Anexo38_EditalAnexo') )
BEGIN
	CREATE INDEX [IX_Anexo38_EditalAnexo_IdEditalLicitacaoRegimeEstatal] ON [BdSIAI].[dbo].[Anexo38_EditalAnexo] ([IdEditalLicitacaoRegimeEstatal]) INCLUDE ([IdEditalAnexo], [IdEditalLicitacaoPublica], [IdEditalLicitacaoDispensada], [IdEditalSRP], [IdEditalLicitacaoInaplicabilidade], [NomeArquivoAnexo], [HashArquivoAnexo], [IdTipoDocumentacao], [Ativo], [DataInclusao], [IdSessao], [IdSessaoOperacao])
END


