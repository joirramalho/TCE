-- Feito com Berg

SELECT TOP 1000 [IdArquivoXML]
      ,[IdUnidadeJurisdicionada]
      ,[IdAnexo]
      ,[DataReferenciaInicial]
      ,[DataReferenciaFinal]
      ,[IdSituacaoProcessamento]
      ,[EnvioComplementar]
 
      ,[DataProcessamento]
      ,[RetificacaoAutorizada]
      ,[DataInativacao]
      ,[DataInclusao]
      ,[IdSessao]
      ,[IdSessaoOperacao]
  FROM [BdSIAI].[dbo].[Envio_ArquivoXML]
  WHERE IdUnidadeJurisdicionada = 418 
	AND DataInativacao IS NULL
	AND ( ( DataReferenciaInicial = '2020-02-01' AND DataReferenciaFinal = '2020-02-29' ) OR ( DataReferenciaInicial = '2020-01-01' AND DataReferenciaFinal = '2020-01-31' ) )
  order by IdArquivoXML DESC



  begin tran

  UPDATE [BdSIAI].[dbo].[Envio_ArquivoXML]
  SET DataInativacao = GETDATE()
  WHERE IdUnidadeJurisdicionada = 418 
	AND DataInativacao IS NULL
	AND ( ( DataReferenciaInicial = '2020-02-01' AND DataReferenciaFinal = '2020-02-29' ) OR ( DataReferenciaInicial = '2020-01-01' AND DataReferenciaFinal = '2020-01-31' ) )


--commit
