-- parte 1

IF NOT EXISTS( SELECT * FROM sys.indexes WHERE name='IX_SiaiDp_FpContraChequeItem_idfpcontracheque' AND object_id = OBJECT_ID('dbo.SiaiDp_FpContraChequeItem') )
BEGIN
    CREATE INDEX [IX_SiaiDp_FpContraChequeItem_idfpcontracheque] ON [Processo].[dbo].[SiaiDp_FpContraChequeItem] ([idfpcontracheque]) INCLUDE ([Idfpitemcontracheque], [valor], [mesref], [anoref])
END

-- parte 2

IF NOT EXISTS( SELECT * FROM sys.indexes WHERE name='IX_Lrf_Distribuicao_usuario_data_fim_analise' AND object_id = OBJECT_ID('dbo.SiaiDp_FpContraChequeItem') )
BEGIN
    CREATE INDEX [IX_Lrf_Distribuicao_usuario_data_fim_analise] ON [Processo].[dbo].[Lrf_Distribuicao] ([usuario], [data_fim_analise])
END

-- parte 3

IF NOT EXISTS( SELECT * FROM sys.indexes WHERE name='IX_Ata_Informacao_setor_IdModelo_Inativa' AND object_id = OBJECT_ID('dbo.Ata_Informacao') )
BEGIN
    CREATE INDEX [IX_Ata_Informacao_setor_IdModelo_Inativa] ON [Processo].[dbo].[Ata_Informacao] ([setor], [IdModelo], [Inativa]) INCLUDE ([numero_processo], [ano_processo], [idInformacao], [Publicado])
END

-- parte 4

IF EXISTS( SELECT * FROM sys.indexes WHERE name='[IX_Processos_setor_atual]' AND object_id = OBJECT_ID('dbo.Processos') )
BEGIN
	DROP INDEX [IX_Processos_setor_atual] ON [dbo].[Processos];

	DROP INDEX [porDataDigitalizacao] ON [dbo].[Processos];
END

IF NOT EXISTS( SELECT * FROM sys.indexes WHERE name='IX_Ata_Informacao_setor_IdModelo_Inativa' AND object_id = OBJECT_ID('dbo.Processos') )
BEGIN
    CREATE INDEX [IX_Processos_setor_atual_numero_apensador_Digitalizacao] ON [Processo].[dbo].[Processos] ([setor_atual], [numero_apensador],[Digitalizacao])
END

-- parte 5

IF NOT EXISTS( SELECT * FROM sys.indexes WHERE name='IX_Ger_Chamados_ProblemaRecorrente_Status' AND object_id = OBJECT_ID('dbo.Ger_Chamados') )
BEGIN
    CREATE INDEX [IX_Ger_Chamados_ProblemaRecorrente_Status] ON [Processo].[dbo].[Ger_Chamados] ([ProblemaRecorrente],[Status])
END

-- parte 6

-- MUDANCA de BANCO
-- ATENCAO
    -- [Processo_Archive].[dbo].[SysSessao_Archive]

IF NOT EXISTS( SELECT * FROM sys.indexes WHERE name='IX_SysSessao_Archive_IdSessao' AND object_id = OBJECT_ID('dbo.SysSessao_Archive') )
BEGIN
    CREATE INDEX [IX_SysSessao_Archive_IdSessao] ON [Processo_Archive].[dbo].[SysSessao_Archive] ([IdSessao])
END

-- parte 7

-- ATENCAO
    -- [TempWebProcesso].[dbo].[EscPessoaTemp]

IF NOT EXISTS( SELECT * FROM sys.indexes WHERE name='IX_EscPessoaTemp_Flag' AND object_id = OBJECT_ID('dbo.EscPessoaTemp') )
BEGIN
    CREATE INDEX [IX_EscPessoaTemp_Flag] ON [TempWebProcesso].[dbo].[EscPessoaTemp] ([Flag])
    CREATE INDEX [IX_Exe_Boleto_Temp_Flag] ON [TempWebProcesso].[dbo].[Exe_Boleto_Temp] ([Flag])
    CREATE INDEX [IX_Exe_Parcela_Temp_Flag] ON [TempWebProcesso].[dbo].[Exe_Parcela_Temp] ([Flag])
END

-- parte 8

IF NOT EXISTS( SELECT * FROM sys.indexes WHERE name='IX_Adm_Ponto_Just_usuario_DataInclusao' AND object_id = OBJECT_ID('dbo.Adm_Ponto_Just') )
BEGIN
    CREATE INDEX [IX_Adm_Ponto_Just_usuario_DataInclusao] ON [Processo].[dbo].[Adm_Ponto_Just] ([usuario],[DataInclusao]) INCLUDE ([id], [data], [HoraEntrada], [HoraSaidaAlmoco], [HoraVoltaAlmoco], [HoraSaida], [QtdHoras], [descricao], [IdMotivoAusencia], [ResultadoAvaliacao], [ObsDiretor], [Anexo], [qtdminutos])
END



IF EXISTS( SELECT * FROM sys.indexes WHERE name='PorMotivoAusencia' AND object_id = OBJECT_ID('dbo.Adm_Ponto_Just') )
BEGIN
	DROP INDEX [PorMotivoAusencia] ON [dbo].[Adm_Ponto_Just];
	DROP INDEX [por_setor] ON [dbo].[Adm_Ponto_Just];
    DROP INDEX [missing_index_161] ON [dbo].[Adm_Ponto_Just];
END