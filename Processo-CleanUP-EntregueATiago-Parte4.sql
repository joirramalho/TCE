-- parte 4

IF EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'dbo.FK_IrregularidadesProcesso_processos') AND parent_object_id = OBJECT_ID(N'dbo.IrregularidadesProcesso') )
  BEGIN
    ALTER TABLE [dbo].[IrregularidadesProcesso] DROP CONSTRAINT [FK_IrregularidadesProcesso_processos];


    ALTER TABLE [dbo].[IrregularidadesProcesso]  WITH CHECK ADD  CONSTRAINT [FK_IrregularidadesProcesso_processos] FOREIGN KEY([IdProcesso])
    REFERENCES [dbo].[Processos] ([IdProcesso]);

    ALTER TABLE [dbo].[IrregularidadesProcesso] CHECK CONSTRAINT [FK_IrregularidadesProcesso_processos];
END




IF NOT EXISTS( SELECT * FROM sys.indexes WHERE name='IX_Itens_Lote_ano_processo_numero_processo' AND object_id = OBJECT_ID('dbo.Itens_Lote') )
BEGIN
    CREATE INDEX [IX_Itens_Lote_ano_processo_numero_processo] ON [Processo].[dbo].[Itens_Lote] ([ano_processo],[numero_processo]) INCLUDE ([numero_lote], [ano_lote], [recebido_em])
END




IF NOT EXISTS( SELECT * FROM sys.indexes WHERE name='IX_Itens_Lote_numero_processo_ano_processo' AND object_id = OBJECT_ID('dbo.Itens_Lote') )
BEGIN
	CREATE INDEX [IX_Itens_Lote_numero_processo_ano_processo] ON [Processo].[dbo].[Itens_Lote] ([numero_processo], [ano_processo]) INCLUDE ([numero_lote], [ano_lote], [recebido_em])
END

