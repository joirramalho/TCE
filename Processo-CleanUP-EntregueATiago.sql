/*
\# LOTES
*/

IF NOT EXISTS( SELECT * FROM sys.indexes WHERE name='IX_Lotes_numero_lote_ano_lote' AND object_id = OBJECT_ID('dbo.Lotes') )
BEGIN
	CREATE INDEX [IX_Lotes_numero_lote_ano_lote] ON [Processo].[dbo].[Lotes] ([numero_lote], [ano_lote]) INCLUDE ([origem], [destino], [enviado_em])
END

/*
\# Itens\_Lote
*/

USE [Processo]
GO

IF EXISTS( SELECT * FROM sys.indexes WHERE name='IX_Itens_Lote_Recebido_por' AND object_id = OBJECT_ID('dbo.Itens_Lote') )
BEGIN
	DROP INDEX [IX_Itens_Lote_Recebido_por] ON [dbo].[Itens_Lote];

	CREATE INDEX [IX_Itens_Lote_recebido_por] ON [Processo].[dbo].[Itens_Lote] ([recebido_por]) INCLUDE ([IdLote]);
END

/*
\# PROCESSOS
*/

IF NOT EXISTS( SELECT * FROM sys.indexes WHERE name='IX_Processos_IdProcessoApensador' AND object_id = OBJECT_ID('dbo.Processos') )
BEGIN
	CREATE INDEX [IX_Processos_IdProcessoApensador] ON [Processo].[dbo].[Processos] ([IdProcessoApensador])
END



IF EXISTS( SELECT * FROM sys.indexes WHERE name='[IX_Processos_Setor_Atual_numero_apensador_Ano_apensador_Digitalizacao]' AND object_id = OBJECT_ID('dbo.Processos') )
BEGIN
	DROP INDEX [IX_Processos_Setor_Atual_numero_apensador_Ano_apensador_Digitalizacao] ON [dbo].[Processos];


	CREATE INDEX [IX_Processos_setor_atual] ON [Processo].[dbo].[Processos] ([setor_atual]) INCLUDE ([numero_processo], [ano_processo], [numero_apensador], [ano_apensador], [IdProcesso], [Digitalizacao], [DataDigitalizacao])
END


/*
\# SiaiDP\_Arquivo
*/

IF NOT EXISTS( SELECT * FROM sys.indexes WHERE name='IX_SiaiDp_Arquivo_mes_ano' AND object_id = OBJECT_ID('dbo.SiaiDp_Arquivo') )
BEGIN
	CREATE INDEX [IX_SiaiDp_Arquivo_mes_ano] ON [Processo].[dbo].[SiaiDp_Arquivo] ([mes], [ano]) INCLUDE ([codigoOrgao], [inativo])
END

/*
\# CRIAR IdProcesso em Ata\_Informacao em Processo\_Audit
*/

USE [Processo_Audit]
GO

IF	not EXISTS		( SELECT *	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Ata_Informacao_Audit'	AND COLUMN_NAME = 'IdProcesso' )
BEGIN
	BEGIN TRANSACTION
	SET QUOTED_IDENTIFIER ON
	SET ARITHABORT ON
	SET NUMERIC_ROUNDABORT OFF
	SET CONCAT_NULL_YIELDS_NULL ON
	SET ANSI_NULLS ON
	SET ANSI_PADDING ON
	SET ANSI_WARNINGS ON
	COMMIT

	BEGIN TRANSACTION

	CREATE TABLE dbo.Tmp_Ata_Informacao_Audit
		(
		setor varchar(10) NULL,
		numero_processo char(6) NULL,
		ano_processo char(4) NULL,
		ordem int NULL,
		data_resumo datetime NULL,
		resumo varchar(8000) NULL,
		sigilo char(1) NULL,
		usuario char(11) NULL,
		data_ultima_atualizacao datetime NULL,
		informacao_efetuada_por char(11) NULL,
		nome_informacao varchar(100) NULL,
		Titulo_Modelo_informacao varchar(100) NULL,
		Tipo_documento char(2) NULL,
		Decisao char(2) NULL,
		idInformacao int NULL,
		infConvPdf bit NULL,
		dataConversaoPDF datetime NULL,
		codigo_camara char(1) NULL,
		IdSessao int NULL,
		DataInclusao datetime NULL,
		UsuarioInclusao varchar(50) NULL,
		ErroConversao bit NULL,
		Assinado bit NULL,
		ProcessoEletronico bit NULL,
		Publicado bit NULL,
		IdModelo int NULL,
		Inativa bit NULL,
		DataPublicacao datetime NULL,
		IdInformacaoSubstituida int NULL,
		UsuarioInformacaoSubstituida varchar(11) NULL,
		DataInformacaoSubstituida datetime NULL,
		IdTipoParecer tinyint NULL,
		Observacao varchar(800) COLLATE Latin1_General_CI_AI NULL,
		IdProcesso int NULL,
		Operacao char(1) NULL,
		UsuarioConexao varchar(20) NULL,
		DataConexao datetime NULL
		)  ON [PRIMARY];
	
	ALTER TABLE dbo.Tmp_Ata_Informacao_Audit SET (LOCK_ESCALATION = TABLE);

--	GRANT INSERT ON dbo.Tmp_Ata_Informacao_Audit TO uCertCrossDB  AS dbo;

	IF EXISTS(SELECT * FROM dbo.Ata_Informacao_Audit)
		 EXEC('INSERT INTO dbo.Tmp_Ata_Informacao_Audit (setor, numero_processo, ano_processo, ordem, data_resumo, resumo, sigilo, usuario, data_ultima_atualizacao, informacao_efetuada_por, nome_informacao, Titulo_Modelo_informacao, Tipo_documento, Decisao, idInformacao, infConvPdf, dataConversaoPDF, codigo_camara, IdSessao, DataInclusao, UsuarioInclusao, ErroConversao, Assinado, ProcessoEletronico, Publicado, IdModelo, Inativa, DataPublicacao, IdInformacaoSubstituida, UsuarioInformacaoSubstituida, DataInformacaoSubstituida, IdTipoParecer, Observacao, Operacao, UsuarioConexao, DataConexao)
			SELECT setor, numero_processo, ano_processo, ordem, data_resumo, resumo, sigilo, usuario, data_ultima_atualizacao, informacao_efetuada_por, nome_informacao, Titulo_Modelo_informacao, Tipo_documento, Decisao, idInformacao, infConvPdf, dataConversaoPDF, codigo_camara, IdSessao, DataInclusao, UsuarioInclusao, ErroConversao, Assinado, ProcessoEletronico, Publicado, IdModelo, Inativa, DataPublicacao, IdInformacaoSubstituida, UsuarioInformacaoSubstituida, DataInformacaoSubstituida, IdTipoParecer, Observacao, Operacao, UsuarioConexao, DataConexao FROM dbo.Ata_Informacao_Audit WITH (HOLDLOCK TABLOCKX)');

	DROP TABLE dbo.Ata_Informacao_Audit;
	
	EXECUTE sp_rename N'dbo.Tmp_Ata_Informacao_Audit', N'Ata_Informacao_Audit', 'OBJECT' ;
	
	COMMIT
END

/*
\# CRIAR IdProcesso em Ata\_Informacao em Processo
*/

USE PROCESSO;

IF	not EXISTS		( SELECT *	FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Ata_Informacao'	AND COLUMN_NAME = 'IdProcesso' )
BEGIN
	BEGIN TRANSACTION
	SET QUOTED_IDENTIFIER ON
	SET ARITHABORT ON
	SET NUMERIC_ROUNDABORT OFF
	SET CONCAT_NULL_YIELDS_NULL ON
	SET ANSI_NULLS ON
	SET ANSI_PADDING ON
	SET ANSI_WARNINGS ON
	COMMIT
	BEGIN TRANSACTION;
	
	ALTER TABLE dbo.Ata_Informacao ADD
		IdProcesso int NULL;
	
	ALTER TABLE dbo.Ata_Informacao SET (LOCK_ESCALATION = TABLE);
	
	COMMIT
END

/*
Trigger para SETAR IdProcesso em Ata\_Informacao
*/

USE Processo;

IF EXISTS (SELECT * FROM sys.objects WHERE [name] = N'Setar_IdProcesso' AND [type] = 'TR')
BEGIN
	DROP TRIGGER [dbo].[Setar_IdProcesso];
END

CREATE TRIGGER [dbo].[Setar_IdProcesso] ON [dbo].[Ata_Informacao] 
AFTER INSERT
AS
BEGIN
	DECLARE @IdProcesso	INT

	SELECT IdProcesso = (	SELECT	IdProcesso FROM Processos 
								WHERE	ano_processo		= ( SELECT INSERTED.ano_processo	FROM INSERTED )
										AND numero_processo = ( SELECT INSERTED.numero_processo	FROM INSERTED ) )	
		
    UPDATE	Ata_Informacao
    SET		IdProcesso = @IdProcesso
    FROM	inserted
    WHERE			Ata_Informacao.ano_processo		= inserted.ano_processo 
				AND Ata_Informacao.numero_processo	= inserted.numero_processo
				
				AND inserted.IdProcesso IS NULL
END

DISABLE TRIGGER [dbo].[Setar_IdProcesso] ON [dbo].[ata_informacao]

--SELECT numero_processo, ano_processo
--FROM Ata_Informacao ata
--WHERE NOT EXISTS(SELECT * FROM Processos p WHERE ata.ano_processo = p.ano_processo AND  ata.numero_processo = p.numero_processo)


--SELECT COUNT(*) FROM Ata_Informacao

/*
# Índices de <span style="color: rgb(33, 33, 33); font-family: Menlo, Monaco, &quot;Courier New&quot;, monospace; font-size: 12px; white-space: pre;">Dil_Diligencias</span>
*/

USE Processo;

IF EXISTS( SELECT * FROM sys.indexes WHERE name='PorOrgao' AND object_id = OBJECT_ID('dbo.Dil_Diligencias') )
BEGIN
	DROP INDEX [PorOrgao] ON [dbo].[Dil_Diligencias];

	DROP INDEX [PorProcessoResposta] ON [dbo].[Dil_Diligencias];

	DROP INDEX [dil_diligencias_NumeroAnoResposta] ON [dbo].[Dil_Diligencias];


	CREATE INDEX [IX_Dil_Diligencias_IdProcesso] ON [Processo].[dbo].[Dil_Diligencias] ([IdProcesso])
END

/*
# Ger\_Chamados
*/

IF NOT EXISTS( SELECT * FROM sys.indexes WHERE name='IX_Ger_Chamados__Status' AND object_id = OBJECT_ID('dbo.Ger_Chamados') )
BEGIN
	CREATE INDEX [IX_Ger_Chamados__Status] ON [Processo].[dbo].[Ger_Chamados] ([Status]) INCLUDE ([DataInclusao]);
END

/*
# Req\_Requerimento
*/

IF NOT EXISTS( SELECT * FROM sys.indexes WHERE name='IX_Req_Requerimento__DataAssinatura_Status' AND object_id = OBJECT_ID('dbo.Req_Requerimento') )
BEGIN
	CREATE INDEX [IX_Req_Requerimento__DataAssinatura_Status] ON [Processo].[dbo].[Req_Requerimento] ([DataAssinatura], [Status]) INCLUDE ([IdRequerimento]);
END

/*
# REMOVENDO FKs com tabelas PROCESSOS para poder remover PK de Processos incorreta e criar a NOVA PK por IdProcesso
*/

USE [Processo]
GO


---
ALTER TABLE [dbo].[Ale_Alerta] DROP CONSTRAINT [FK_Ale_Alerta_processos]

---
ALTER TABLE [dbo].[Pro_Resultados] DROP CONSTRAINT [FK_Pro_Resultados_processos]

------

ALTER TABLE [dbo].[Pro_ContratosTceAditivos] DROP CONSTRAINT [FK_Pro_ContratosTceAditivos_Processos]

-----

ALTER TABLE [dbo].[Pro_ContratosTce] DROP CONSTRAINT [FK_Pro_ContratosTce_Processos]

------
ALTER TABLE [dbo].[ComplementarProcesso] DROP CONSTRAINT [FK_ComplementarProcesso_processos]

----

ALTER TABLE [dbo].[Ata_Informacao] DROP CONSTRAINT [FK_ata_informacao_processos]

---

ALTER TABLE [dbo].[IrregularidadesProcesso] DROP CONSTRAINT [FK_IrregularidadesProcesso_processos]

---

ALTER TABLE [dbo].[Pro_MarcadorProcesso] DROP CONSTRAINT [FK_Pro_MarcadorProcesso_processos]

-----

ALTER TABLE [dbo].[Voto] DROP CONSTRAINT [FK_Voto_Voto]


---


/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Processos
	DROP CONSTRAINT PK_processos
GO
ALTER TABLE dbo.Processos SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Processos ADD CONSTRAINT
	PK_Processos PRIMARY KEY CLUSTERED 
	(
	IdProcesso
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.Processos SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

/*
# REMOVER Índices inadequados em PROCESSOS
*/

-- numero_processo, ano_processo, etc

IF EXISTS( SELECT * FROM sys.indexes WHERE name='por_ProcessoNaturezaApensadorSetor' AND object_id = OBJECT_ID('dbo.Processos') )
BEGIN
	DROP INDEX [por_ProcessoNaturezaApensadorSetor] ON [dbo].[Processos];
END

IF EXISTS( SELECT * FROM sys.indexes WHERE name='por_idProcesso' AND object_id = OBJECT_ID('dbo.Processos') )
BEGIN
	DROP INDEX [por_idProcesso] ON [dbo].[Processos];
END

ALTER TABLE [dbo].[Itens_Lote] DROP CONSTRAINT [FK_Itens_Lote_Processos]


ALTER TABLE [dbo].[Cit_Citacoes] DROP CONSTRAINT [FK_Cit_Citacoes_Processos]


ALTER TABLE [dbo].[Comunicacao_Econsulta] DROP CONSTRAINT [FK_Comunicacao_Econsulta_Processos]


ALTER TABLE [dbo].[Dil_Diligencias] DROP CONSTRAINT [FK_Dil_Diligencias_Processos]


ALTER TABLE [dbo].[Rtt_PessoaPeriodo] DROP CONSTRAINT [FK_Rtt_PessoaPeriodo_Processos]


ALTER TABLE [dbo].[Pro_RelatorRedistribuicaoImpedimento] DROP CONSTRAINT [FK_Pro_RelatorRedistribuicaoImpedimento_Processos]


ALTER TABLE [dbo].[Ocp_NotaFiscal] DROP CONSTRAINT [FK_Ocp_NotaFiscal_processos]


ALTER TABLE [dbo].[Pro_GestaoDocumento] DROP CONSTRAINT [FK_IdProcesso_Pro_GestaoDocumento_Processos]


ALTER TABLE [dbo].[Voto] DROP CONSTRAINT [FK_Voto_Processos]

-- REMOVER índices por IdProcesso após ser CRIADA NOVA Chave primária em Processos


IF EXISTS( SELECT * FROM sys.indexes WHERE name='por_idProcesso' AND object_id = OBJECT_ID('dbo.Processos') )
BEGIN
	DROP INDEX [por_idProcesso] ON [dbo].[Processos];
END

-- RECRIANDO FKs

	ALTER TABLE [dbo].[Itens_Lote]  WITH CHECK ADD  CONSTRAINT [FK_Itens_Lote_Processos] FOREIGN KEY([IdProcesso])
	REFERENCES [dbo].[Processos] ([IdProcesso])
	GO

	ALTER TABLE [dbo].[Itens_Lote] CHECK CONSTRAINT [FK_Itens_Lote_Processos]
	GO

	ALTER TABLE [dbo].[Cit_Citacoes]  WITH CHECK ADD  CONSTRAINT [FK_Cit_Citacoes_Processos] FOREIGN KEY([IdProcesso])
	REFERENCES [dbo].[Processos] ([IdProcesso])
	GO

	ALTER TABLE [dbo].[Cit_Citacoes] CHECK CONSTRAINT [FK_Cit_Citacoes_Processos]
	GO

	ALTER TABLE [dbo].[Comunicacao_Econsulta]  WITH CHECK ADD  CONSTRAINT [FK_Comunicacao_Econsulta_Processos] FOREIGN KEY([IdProcesso])
	REFERENCES [dbo].[Processos] ([IdProcesso])
	GO

	ALTER TABLE [dbo].[Comunicacao_Econsulta] CHECK CONSTRAINT [FK_Comunicacao_Econsulta_Processos]
	GO

	ALTER TABLE [dbo].[Dil_Diligencias]  WITH CHECK ADD  CONSTRAINT [FK_Dil_Diligencias_Processos] FOREIGN KEY([IdProcesso])
	REFERENCES [dbo].[Processos] ([IdProcesso])
	GO

	ALTER TABLE [dbo].[Dil_Diligencias] CHECK CONSTRAINT [FK_Dil_Diligencias_Processos]
	GO

	ALTER TABLE [dbo].[Rtt_PessoaPeriodo]  WITH CHECK ADD  CONSTRAINT [FK_Rtt_PessoaPeriodo_Processos] FOREIGN KEY([IdProcesso])
	REFERENCES [dbo].[Processos] ([IdProcesso])
	GO

	ALTER TABLE [dbo].[Rtt_PessoaPeriodo] CHECK CONSTRAINT [FK_Rtt_PessoaPeriodo_Processos]
	GO

	ALTER TABLE [dbo].[Pro_RelatorRedistribuicaoImpedimento]  WITH CHECK ADD  CONSTRAINT [FK_Pro_RelatorRedistribuicaoImpedimento_Processos] FOREIGN KEY([idProcesso])
	REFERENCES [dbo].[Processos] ([IdProcesso])
	GO

	ALTER TABLE [dbo].[Pro_RelatorRedistribuicaoImpedimento] CHECK CONSTRAINT [FK_Pro_RelatorRedistribuicaoImpedimento_Processos]
	GO

	ALTER TABLE [dbo].[Ocp_NotaFiscal]  WITH CHECK ADD  CONSTRAINT [FK_Ocp_NotaFiscal_processos] FOREIGN KEY([idProcesso])
	REFERENCES [dbo].[Processos] ([IdProcesso])
	GO

	ALTER TABLE [dbo].[Ocp_NotaFiscal] CHECK CONSTRAINT [FK_Ocp_NotaFiscal_processos]
	GO

	ALTER TABLE [dbo].[Pro_GestaoDocumento]  WITH CHECK ADD  CONSTRAINT [FK_IdProcesso_Pro_GestaoDocumento_Processos] FOREIGN KEY([Idprocesso])
	REFERENCES [dbo].[Processos] ([IdProcesso])
	GO

	ALTER TABLE [dbo].[Pro_GestaoDocumento] CHECK CONSTRAINT [FK_IdProcesso_Pro_GestaoDocumento_Processos]
	GO

	ALTER TABLE [dbo].[Voto]  WITH CHECK ADD  CONSTRAINT [FK_Voto_Processos] FOREIGN KEY([IdProcesso])
	REFERENCES [dbo].[Processos] ([IdProcesso])
	GO

	ALTER TABLE [dbo].[Voto] CHECK CONSTRAINT [FK_Voto_Processos]
	GO

-- sigla_origem, codigo_tipo_processo, ano_referencia, mes_referencia

IF EXISTS( SELECT * FROM sys.indexes WHERE name='por_tipo_siglaorigem_ano_mes' AND object_id = OBJECT_ID('dbo.Processos') )
BEGIN
	DROP INDEX [por_tipo_siglaorigem_ano_mes] ON [dbo].[Processos];
END

-- RECRIANDDO FKs


	ALTER TABLE [dbo].[Ale_Alerta]  WITH CHECK ADD  CONSTRAINT [FK_Ale_Alerta_processos] FOREIGN KEY([AnoDocumento], [NumeroDocumento] )
	REFERENCES [dbo].[Processos] ([ano_processo], [numero_processo])
	GO

	ALTER TABLE [dbo].[Ale_Alerta] CHECK CONSTRAINT [FK_Ale_Alerta_processos]
	GO


	ALTER TABLE [dbo].[Pro_Resultados]  WITH CHECK ADD  CONSTRAINT [FK_Pro_Resultados_processos] FOREIGN KEY([ano_processo], [numero_processo])
	REFERENCES [dbo].[Processos] ([ano_processo], [numero_processo])
	GO

	ALTER TABLE [dbo].[Pro_Resultados] CHECK CONSTRAINT [FK_Pro_Resultados_processos]
	GO

	ALTER TABLE [dbo].[Pro_ContratosTceAditivos]  WITH CHECK ADD  CONSTRAINT [FK_Pro_ContratosTceAditivos_Processos] FOREIGN KEY([AnoProcessoAditivo], [NumeroProcessoAditivo])
	REFERENCES [dbo].[Processos] ([ano_processo], [numero_processo])
	GO

	ALTER TABLE [dbo].[Pro_ContratosTceAditivos] CHECK CONSTRAINT [FK_Pro_ContratosTceAditivos_Processos]
	GO

	ALTER TABLE [dbo].[Pro_ContratosTce]  WITH CHECK ADD  CONSTRAINT [FK_Pro_ContratosTce_Processos] FOREIGN KEY([AnoProcesso], [NumeroProcesso])
	REFERENCES [dbo].[Processos] ([ano_processo], [numero_processo])
	GO

	ALTER TABLE [dbo].[Pro_ContratosTce] CHECK CONSTRAINT [FK_Pro_ContratosTce_Processos]
	GO

	ALTER TABLE [dbo].[ComplementarProcesso]  WITH CHECK ADD  CONSTRAINT [FK_ComplementarProcesso_processos] FOREIGN KEY([ano_processo], [numero_processo])
	REFERENCES [dbo].[Processos] ([ano_processo], [numero_processo])
	GO

	ALTER TABLE [dbo].[ComplementarProcesso] CHECK CONSTRAINT [FK_ComplementarProcesso_processos]
	GO

	ALTER TABLE [dbo].[Ata_Informacao]  WITH CHECK ADD  CONSTRAINT [FK_ata_informacao_processos] FOREIGN KEY([ano_processo], [numero_processo])
	REFERENCES [dbo].[Processos] ([ano_processo], [numero_processo])
	GO

	ALTER TABLE [dbo].[Ata_Informacao] CHECK CONSTRAINT [FK_ata_informacao_processos]
	GO

	ALTER TABLE [dbo].[IrregularidadesProcesso]  WITH CHECK ADD  CONSTRAINT [FK_IrregularidadesProcesso_processos] FOREIGN KEY([ano_processo], [numero_processo])
	REFERENCES [dbo].[Processos] ([ano_processo],[numero_processo])
	GO

	ALTER TABLE [dbo].[IrregularidadesProcesso] CHECK CONSTRAINT [FK_IrregularidadesProcesso_processos]
	GO

	ALTER TABLE [dbo].[Pro_MarcadorProcesso]  WITH CHECK ADD  CONSTRAINT [FK_Pro_MarcadorProcesso_processos] FOREIGN KEY([Ano_Processo], [Numero_Processo])
	REFERENCES [dbo].[Processos] ([ano_processo], [numero_processo])
	GO

	ALTER TABLE [dbo].[Pro_MarcadorProcesso] CHECK CONSTRAINT [FK_Pro_MarcadorProcesso_processos]
	GO

ALTER TABLE [dbo].Ale_Alerta DROP CONSTRAINT [FK_Ale_Alerta_Ale_Alerta]

