USE [Processo]
GO

IF EXISTS( SELECT * FROM sys.indexes WHERE name='IX_Itens_Lote_numero_processo_ano_processo' AND object_id = OBJECT_ID('dbo.Itens_Lote') )
BEGIN
	DROP INDEX [IX_Itens_Lote_numero_processo_ano_processo] ON [dbo].[Itens_Lote
]
END

---


IF NOT EXISTS( SELECT * FROM sys.indexes WHERE name='IX_Req_Destino_IdRequerimento' AND object_id = OBJECT_ID('dbo.Req_Destino') )
BEGIN
	CREATE INDEX [IX_Req_Destino_IdRequerimento] ON [Processo].[dbo].[Req_Destino] ([IdRequerimento]) INCLUDE ([IdSetorDestino])
END


--

IF NOT EXISTS( SELECT * FROM sys.indexes WHERE name='IX_Cit_Certidao_Numero_processo_Ano_processo' AND object_id = OBJECT_ID('dbo.Cit_Certidao') )
BEGIN
    CREATE INDEX [IX_Cit_Certidao_Numero_processo_Ano_processo] ON [Processo].[dbo].[Cit_Certidao] ([Numero_processo], [Ano_processo])
END

---

IF NOT EXISTS( SELECT * FROM sys.indexes WHERE name='IX_Mem_Tramitacao_idTramitacaoProxima_IdSetorDestino_DataRecebimento_RecebidoPor' AND object_id = OBJECT_ID('dbo.Mem_Tramitacao') )
BEGIN
CREATE INDEX [IX_Mem_Tramitacao_idTramitacaoProxima_IdSetorDestino_DataRecebimento_RecebidoPor] ON [Processo].[dbo].[Mem_Tramitacao] ([idTramitacaoProxima], [IdSetorDestino],[DataRecebimento], [RecebidoPor]) INCLUDE ([IdTramitacao], [IdMemorando], [IdSetorEnvio], [DataInclusao])
END

---

IF NOT EXISTS( SELECT * FROM sys.indexes WHERE name='IX_Lrf_Distribuicao_data_fim_analise' AND object_id = OBJECT_ID('dbo.Lrf_Distribuicao') )
BEGIN
CREATE INDEX [IX_Lrf_Distribuicao_data_fim_analise] ON [Processo].[dbo].[Lrf_Distribuicao] ([data_fim_analise])
END







