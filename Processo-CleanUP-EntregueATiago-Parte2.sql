-- 1

IF NOT EXISTS( SELECT * FROM sys.indexes WHERE name='IX_Processos_sigla_origem_ano_referencia_mes_referencia' AND object_id = OBJECT_ID('dbo.Processos') )
BEGIN
    CREATE INDEX [IX_Processos_sigla_origem_ano_referencia_mes_referencia] ON [Processo].[dbo].[Processos] ([sigla_origem], [ano_referencia], [mes_referencia])
END

-- 2

IF EXISTS( SELECT * FROM sys.indexes WHERE name='PorSetor' AND object_id = OBJECT_ID('dbo.Apensados_Log') )
BEGIN
	DROP INDEX [PorSetor] ON [dbo].[Apensados_Log];

	DROP INDEX [PorUsuario] ON [dbo].[Apensados_Log];

	DROP INDEX [por_TIPO_OPERACAO] ON [dbo].[Apensados_Log];
END


IF NOT EXISTS( SELECT * FROM sys.indexes WHERE name='IX_Apensados_Log_idinformacao' AND object_id = OBJECT_ID('dbo.Apensados_Log') )
BEGIN
    CREATE INDEX [IX_Apensados_Log_idinformacao] ON [Processo].[dbo].[Apensados_Log] ([idinformacao]) INCLUDE ([NUMERO_PROCESSO], [ANO_PROCESSO], [NUMERO_APENSADOR], [ANO_APENSADOR], [IdApensadosLog])
END

-- 3

IF NOT EXISTS( SELECT * FROM sys.indexes WHERE name='IX_Comunicacao_EnvioProcessoAnexo_IdEnvioProcesso' AND object_id = OBJECT_ID('dbo.Comunicacao_EnvioProcessoAnexo') )
BEGIN
    CREATE INDEX [IX_Comunicacao_EnvioProcessoAnexo_IdEnvioProcesso] ON [Processo].[dbo].[Comunicacao_EnvioProcessoAnexo] ([IdEnvioProcesso])
END

-- 4

IF NOT EXISTS( SELECT * FROM sys.indexes WHERE name='IX_Req_Tramitacao_idTramitacaoProxima_DataRecebimento_RecebidoPor' AND object_id = OBJECT_ID('dbo.Req_Tramitacao') )
BEGIN
    CREATE INDEX [IX_Req_Tramitacao_idTramitacaoProxima_DataRecebimento_RecebidoPor] ON [Processo].[dbo].[Req_Tramitacao] ([idTramitacaoProxima],[DataRecebimento], [RecebidoPor])
END

-- 5

IF EXISTS( SELECT * FROM sys.indexes WHERE name='por_ProcessoDataResumoSetor' AND object_id = OBJECT_ID('dbo.Ata_Informacao') )
BEGIN
	DROP INDEX [ata_informacao_IdModelo] ON [dbo].[Ata_Informacao];

	DROP INDEX [ata_informacao_NomeInfNumProcAnoProc] ON [dbo].[Ata_Informacao];

	DROP INDEX [ata_informacao_SetorProcessoUsuarioDataUltima] ON [dbo].[Ata_Informacao];

	DROP INDEX [por_ProcessoDataResumoSetor] ON [dbo].[Ata_Informacao];

	DROP INDEX [por_setor_nome_informacao] ON [dbo].[Ata_Informacao];

	DROP INDEX [PorInformacaoSubstituida] ON [dbo].[Ata_Informacao];
END

-- 6

IF NOT EXISTS( SELECT * FROM sys.indexes WHERE name='IX_Ata_Informacao_setor_nome_informacao_Assinado_Publicado' AND object_id = OBJECT_ID('dbo.Ata_Informacao') )
BEGIN
    CREATE INDEX [IX_Ata_Informacao_setor_nome_informacao_Assinado_Publicado] ON [Processo].[dbo].[Ata_Informacao] ([setor], [nome_informacao], [Assinado], [Publicado]) INCLUDE ([numero_processo], [ano_processo], [DataInclusao])

    CREATE INDEX [IX_Ata_Informacao_IdInformacaoSubstituida] ON [Processo].[dbo].[Ata_Informacao] ([IdInformacaoSubstituida]) INCLUDE ([idInformacao])
END

-- 7

IF EXISTS( SELECT * FROM sys.indexes WHERE name='PorIdContraCheque' AND object_id = OBJECT_ID('dbo.SiaiDp_FpContraChequeItem') )
BEGIN
	DROP INDEX [PorIdContraCheque] ON [dbo].[SiaiDp_FpContraChequeItem];

    CREATE INDEX [IX_SiaiDp_FpContraChequeItem_Idfpitemcontracheque] ON [Processo].[dbo].[SiaiDp_FpContraChequeItem] ([Idfpitemcontracheque]) INCLUDE ([idfpcontracheque], [valor])
END

-- 8

IF EXISTS( SELECT * FROM sys.indexes WHERE name='PorIdPessoa' AND object_id = OBJECT_ID('dbo.Ger_ChamadoRespostaPessoa') )
BEGIN
	DROP INDEX [PorIdPessoa] ON [dbo].[Ger_ChamadoRespostaPessoa];

    CREATE INDEX [IX_Ger_ChamadoRespostaPessoa_IdPessoa_Visualizado] ON [Processo].[dbo].[Ger_ChamadoRespostaPessoa] ([IdPessoa], [Visualizado]) INCLUDE ([IdChamadosRespostas])
END

-- 9

IF NOT EXISTS( SELECT * FROM sys.indexes WHERE name='IX_Cer_CertidaoLiberacaoCritica_CodigoOrgao_IdCertidaoLiberacaoCriticaTipo_Ativo_AnoInicial_DataInicial' AND object_id = OBJECT_ID('dbo.Cer_CertidaoLiberacaoCritica') )
BEGIN
    CREATE INDEX [IX_Cer_CertidaoLiberacaoCritica_CodigoOrgao_IdCertidaoLiberacaoCriticaTipo_Ativo_AnoInicial_DataInicial] ON [Processo].[dbo].[Cer_CertidaoLiberacaoCritica] ([CodigoOrgao], [IdCertidaoLiberacaoCriticaTipo], [Ativo], [AnoInicial],[DataInicial])
END


-- 10

IF EXISTS( SELECT * FROM sys.indexes WHERE name='IX_Adm_Ponto_Banco_Horas_Data' AND object_id = OBJECT_ID('dbo.Adm_Ponto_Banco_Horas') )
BEGIN
	DROP INDEX [IX_Adm_Ponto_Banco_Horas_Data] ON [dbo].[Adm_Ponto_Banco_Horas];

CREATE INDEX [IX_Adm_Ponto_Banco_Horas_Usuario_CodigoPeriodoAcumulativo] ON [Processo].[dbo].[Adm_Ponto_Banco_Horas] ([Usuario], [CodigoPeriodoAcumulativo]) INCLUDE ([SaldoLiquido], [IdBancoHoras])
END

-- 11

IF EXISTS( SELECT * FROM sys.indexes WHERE name='por_DataPublicacaoDOE' AND object_id = OBJECT_ID('dbo.Ata_Composicao_Pautas') )
BEGIN
	DROP INDEX [por_DataPublicacaoDOE] ON [dbo].[Ata_Composicao_Pautas];

    CREATE INDEX [IX_Ata_Composicao_Pautas_DataPublicacaoDOE_IdMotivoRetirada] ON [Processo].[dbo].[Ata_Composicao_Pautas] ([DataPublicacaoDOE], [IdMotivoRetirada]) INCLUDE ([codigo_camara], [numero_sessao], [ano_sessao], [numero_processo], [ano_processo], [Pro_saiu_num_sessao], [idInformacao], [idVotoPauta])


    DROP INDEX [por_numero_processo_ano_processo] ON [dbo].[Ata_Composicao_Pautas]
    CREATE NONCLUSTERED INDEX [IX_Ata_Composicao_Pautas_ano_processo_numero_processo] ON [dbo].[Ata_Composicao_Pautas]
    (
        [ano_processo] ASC,
        [numero_processo] ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF, FILLFACTOR = 80)


	DROP INDEX [Por_CamaraNumeroSessaoAnoSessao] ON [dbo].[Ata_Composicao_Pautas];

    CREATE NONCLUSTERED INDEX [IX_Ata_Composicao_Pautas_Camara_AnoSessao_NumeroSessao] ON [dbo].[Ata_Composicao_Pautas]
    (
        [codigo_camara] ASC,
        [ano_sessao] ASC,
        [numero_sessao] ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF, FILLFACTOR = 80)


	DROP INDEX por_DataGeracaoArquivoPublicacao ON [dbo].[Ata_Composicao_Pautas];
END

-- 12

IF EXISTS( SELECT * FROM sys.indexes WHERE name='PorTipo' AND object_id = OBJECT_ID('dbo.Pro_LiberacaoCriticaProcesso') )
BEGIN
	DROP INDEX PorTipo ON [dbo].[Pro_LiberacaoCriticaProcesso];

    CREATE INDEX [IX_Pro_LiberacaoCriticaProcesso_Ano] ON [Processo].[dbo].[Pro_LiberacaoCriticaProcesso] ([Ano]) INCLUDE ([idOrgao], [idTipoLiberacaoCritica])
END

-- 13

IF NOT EXISTS( SELECT * FROM sys.indexes WHERE name='IX_Cit_ArquivoItensGuiaPostagem_IdItemGuiaPostagem' AND object_id = OBJECT_ID('dbo.Cit_ArquivoItensGuiaPostagem') )
BEGIN
    CREATE INDEX [IX_Cit_ArquivoItensGuiaPostagem_IdItemGuiaPostagem] ON [Processo].[dbo].[Cit_ArquivoItensGuiaPostagem] ([IdItemGuiaPostagem]) INCLUDE ([IdArquivoRetorno])
END

IF NOT EXISTS( SELECT * FROM sys.indexes WHERE name='IX_Cit_ArquivoItensGuiaPostagem_IdItemGuiaPostagem' AND object_id = OBJECT_ID('dbo.Cit_ItensGuiaPostagem') )
BEGIN
    CREATE INDEX [IX_Cit_ItensGuiaPostagem_Recebido] ON [Processo].[dbo].[Cit_ItensGuiaPostagem] ([Recebido]) INCLUDE ([IdItemGuiaPostagem])
END

-- 14

IF EXISTS( SELECT * FROM sys.indexes WHERE name='por_setor' AND object_id = OBJECT_ID('dbo.Lrf_Distribuicao') )
BEGIN
	DROP INDEX por_setor ON [dbo].[Lrf_Distribuicao];

	DROP INDEX por_usuario ON [dbo].[Lrf_Distribuicao];

	DROP INDEX Lrf_Distribuicao_UsuarioDataFimAnalise ON [dbo].[Lrf_Distribuicao];

	DROP INDEX PorNProcessoAnoProcessoDataAnaliseSetor ON [dbo].[Lrf_Distribuicao];

    CREATE INDEX [IX_Lrf_Distribuicao_Ano_processo_Numero_processo_data_fim_analise] ON [Processo].[dbo].[Lrf_Distribuicao] ([Ano_processo], [Numero_processo], [data_fim_analise])
END