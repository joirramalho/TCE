USE [Processo]
GO

IF EXISTS( SELECT * FROM sys.indexes WHERE name='PorAno' AND object_id = OBJECT_ID('dbo.SiaiDp_Arquivo') )
BEGIN
	DROP INDEX [PorAno] ON [dbo].[SiaiDp_Arquivo]
END


IF EXISTS( SELECT * FROM sys.indexes WHERE name='PorMes' AND object_id = OBJECT_ID('dbo.SiaiDp_Arquivo') )
BEGIN
	DROP INDEX [PorMes] ON [dbo].[SiaiDp_Arquivo]
END


---



IF EXISTS( SELECT * FROM sys.indexes WHERE name='IX_Processos_setor_atual_numero_apensador_Digitalizacao' AND object_id = OBJECT_ID('dbo.Processos') )
BEGIN
	DROP INDEX [IX_Processos_setor_atual_numero_apensador_Digitalizacao] ON [dbo].[Processos]
END

IF NOT EXISTS( SELECT * FROM sys.indexes WHERE name='IX_Processos_setor_atual' AND object_id = OBJECT_ID('dbo.Processos') )
BEGIN
	CREATE INDEX [IX_Processos_setor_atual] ON [Processo].[dbo].[Processos] ([setor_atual]) INCLUDE ([numero_processo], [ano_processo], [numero_apensador], [ano_apensador], [IdProcesso], [Digitalizacao], [DataDigitalizacao])
END

---

IF NOT EXISTS( SELECT * FROM sys.indexes WHERE name='IX_Pro_GestaoDocumento_IdProClassificacaoGestaoDocumento_Idprocesso_Ativo' AND object_id = OBJECT_ID('dbo.Pro_GestaoDocumento') )
BEGIN
	CREATE INDEX [IX_Pro_GestaoDocumento_IdProClassificacaoGestaoDocumento_Idprocesso_Ativo] ON [Processo].[dbo].[Pro_GestaoDocumento] ([IdProClassificacaoGestaoDocumento], [Idprocesso], [Ativo])
END


---

IF EXISTS( SELECT * FROM sys.indexes WHERE name='PorIdPessoa' AND object_id = OBJECT_ID('dbo.Ger_ChamadoImpedimentoPessoa') )
BEGIN
	DROP INDEX [PorIdPessoa] ON [dbo].[Ger_ChamadoImpedimentoPessoa]
END

IF NOT EXISTS( SELECT * FROM sys.indexes WHERE name='IX_Ger_ChamadoImpedimentoPessoa_IdPessoa_visualizado' AND object_id = OBJECT_ID('dbo.Ger_ChamadoImpedimentoPessoa') )
BEGIN
	CREATE INDEX [IX_Ger_ChamadoImpedimentoPessoa_IdPessoa_visualizado] ON [Processo].[dbo].[Ger_ChamadoImpedimentoPessoa] ([IdPessoa], [visualizado]) INCLUDE ([IdChamado])
END


---


USE [Processo]
GO



IF EXISTS( SELECT * FROM sys.indexes WHERE name='missing_index_1515' AND object_id = OBJECT_ID('dbo.Tse_Certidao_Itens') )
BEGIN
	DROP INDEX [missing_index_1515] ON [dbo].[Tse_Certidao_Itens]
	DROP INDEX [missing_index_1517] ON [dbo].[Tse_Certidao_Itens]
	DROP INDEX [missing_index_1421] ON [dbo].[SupHardware]
END


IF EXISTS( SELECT * FROM sys.indexes WHERE name='PorSetor' AND object_id = OBJECT_ID('dbo.Ger_Chamados') )
BEGIN
	DROP INDEX [PorSetor]  ON [dbo].[Ger_Chamados]
	DROP INDEX [PorOrgaoCredor]  ON [dbo].[Exe_Debito]
	DROP INDEX [porusuarioInclusao]  ON [dbo].[Pe_Lote]
	DROP INDEX [PorCartoriodistribuicao]  ON [dbo].[Protesto_TitulosRemessa]
	DROP INDEX [missing_index_4984]  ON [dbo].[Lrf_Anexo13Movimento]
	DROP INDEX [FL_ProcessoExecutar_ResponsavelAtivoN8umCD]  ON [dbo].[FL_ProcessoExecutar]

--	DROP INDEX [Uni_Fin_AnoOrcamentario]  ON [dbo].[Fin_AnoOrcamentario]
	
	DROP INDEX [por_descricao]  ON [dbo].[SupHardware]
	DROP INDEX [por_NumeroTombo]  ON [dbo].[SupHardware]
	DROP INDEX [Por_NumeroAno]  ON [dbo].[Ale_Alerta]
END






