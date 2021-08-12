/****** Script for SelectTopNRows command from SSMS  ******/
SELECT IdSituacaoProcessamento, count(*) QTDE
  FROM [BdSIAI].[dbo].[Envio_ArquivoXML]
  where DataReferenciaInicial = '2021-01-01'  AND DataInclusao > '2021-03-02' --IdSituacaoProcessamento = 1
  group by IdSituacaoProcessamento
  --order by IdArquivoXML DESC

  SELECT IdArquivoXML, UJ.NomeOrgao, DataReferenciaInicial, IdSituacaoProcessamento, EnvioComplementar, Observacoes, envio.DataInclusao AS 'Data de Envio', DataProcessamento
  FROM [BdSIAI].[dbo].[Envio_ArquivoXML] envio
  LEFT JOIN vw_Gen_UnidadeJurisdicionada UJ ON envio.IdUnidadeJurisdicionada = Uj.IdUnidadeJurisdicionada
  where envio.IdArquivoXML = (SELECT TOP 1 IdArquivoXML from [bdSIAI].[dbo].[Envio_ArquivoXML] envioXml2 where envio.IdUnidadeJurisdicionada = envioXml2.IdUnidadeJurisdicionada ORDER BY IdArquivoXML DESC)
		AND DataReferenciaInicial = '2021-01-01' AND envio.DataInclusao < '2021-03-02' AND IdSituacaoProcessamento = 4 -- NOT IN  (4,6)
  --order by UJ.NomeOrgao -- DataInclusao DESC
  order by envio.DataInclusao


-- 16mar21
  SELECT IdArquivoXML, UJ.NomeOrgao, DataReferenciaInicial, IdSituacaoProcessamento, Observacoes, envio.DataInclusao AS 'Data de Envio', DataProcessamento
  FROM [BdSIAI].[dbo].[Envio_ArquivoXML] envio
  LEFT JOIN vw_Gen_UnidadeJurisdicionada UJ ON envio.IdUnidadeJurisdicionada = Uj.IdUnidadeJurisdicionada
  where --envio.IdArquivoXML = (SELECT TOP 1 IdArquivoXML from [bdSIAI].[dbo].[Envio_ArquivoXML] envioXml2 where envio.IdUnidadeJurisdicionada = envioXml2.IdUnidadeJurisdicionada ORDER BY IdArquivoXML DESC)
		-- AND 
		DataReferenciaInicial = '2021-01-01' AND envio.DataInclusao < '2021-03-02' AND envio.DataProcessamento >= '2021-03-02' --AND IdSituacaoProcessamento NOT IN (4,6)
  order by UJ.NomeOrgao -- DataInclusao DESC
  --order by envio.DataInclusao

 -- group by IdSituacaoProcessamento
  --order by IdArquivoXML DESC



  --where LRF.IdArquivoLRF = (SELECT TOP 1 IdArquivoLRF from [bdSIAI].[dbo].[Envio_ArquivoLRF] lrf2 where lrf.IdOrgao = lrf2.Idorgao ORDER by IdOrgao, Ano DESC, Bimestre DESC)


    SELECT IdArquivoXML, IdUnidadeJurisdicionada, DataReferenciaFinal, IdSituacaoProcessamento, DataProcessamento, DataInativacao, DataInclusao
  FROM [BdSIAI].[dbo].[Envio_ArquivoXML]
  where DataReferenciaInicial = '2021-01-01' AND IdUnidadeJurisdicionada = 345
  order by DataInclusao DESC


  SELECT IdSituacaoProcessamento, count(*) [qtde]
  FROM [BdSIAI].[dbo].[Envio_ArquivoXML]
  GROUP BY IdSituacaoProcessamento

-- Situacão    Qtde
-- 9	        17      Probremas no processamento
-- 3	        1238    Erro no envio
-- 6	        119     Retificada
-- 1	        1       Aguardando processamento
-- 4	        306     Aprovadas

