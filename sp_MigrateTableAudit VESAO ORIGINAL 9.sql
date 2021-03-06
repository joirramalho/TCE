USE [master]
GO
/****** Object:  StoredProcedure [dbo].[BdAudit]    Script Date: 21/05/2020 11:08:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 22Junho V1.05

-- EXEC Master.dbo.sp_MigrateTableAudit @db = 'bdcTrigger'

ALTER PROCEDURE [dbo].[sp_MigrateTableAudit]
	@db	VARCHAR(128)
AS
BEGIN
	PRINT 'VERSAO ORIGINAL 9' -- LIMPEZA
	
	SET NOCOUNT ON

	DECLARE	@IdDDLEvents	INT
	DECLARE @EventType		VARCHAR(32)
	DECLARE @Tb				VARCHAR(128)
	DECLARE @TSQL			nVARCHAR(MAX)

	DECLARE @ExecDb 		nVARCHAR(max) = QUOTENAME( @db ) 			+ N'.sys.sp_executesql'
	DECLARE @ExecDbAudit 	nVARCHAR(max) = QUOTENAME( @db + '_audit' ) + N'.sys.sp_executesql'

	DECLARE @TbRename		VARCHAR(128)

	DECLARE @CamposAudit	VARCHAR(MAX) = ''

	DECLARE @Trigger		nVARCHAR(MAX)

	CREATE TABLE #tmpTabelas	( IdDDLEvents INT, EventType VARCHAR(32), ObjectName VARCHAR(128), EventDDL nVARCHAR(max) )
    CREATE TABLE #tmpTrigger    ( TriggerName   VARCHAR(128) )
    CREATE TABLE #tmpCampos	    ( Campos        VARCHAR(128) )


	INSERT INTO #tmpTabelas
		SELECT	IdDDLEvents, EventType, ObjectName, EventDDL
		FROM	BdDDL.dbo.DDLEvents 
		WHERE	DatabaseName = @db
				AND EventType IN ('CREATE_TABLE', 'ALTER_TABLE', 'RENAME', 'DROP_TABLE' ) 
				AND ApplyDatabaseAudit = 0 
		ORDER BY IdDDLEvents


	WHILE ( SELECT COUNT(*) FROM #tmpTabelas ) > 0
        BEGIN
            SELECT	TOP 1 @IdDDLEvents = IdDDLEvents, @EventType = EventType, @Tb = ObjectName, @TSQL = EventDDL
            FROM	#tmpTabelas
            ORDER   BY IdDDLEvents


            IF LEFT ( @tb, 4 ) = 'Tmp_' 
                SET @Tb = RTRIM( SUBSTRING( @Tb, 5, 128 ) )


            SET @TSQL = REPLACE ( @TSQL , 'IDENTITY (1, 1)' , '' )
            SET @TSQL = REPLACE ( @TSQL , 'NOT' , '' )

    
            BEGIN TRY
                IF @EventType IN ( 'ALTER_TABLE', 'DROP_TABLE' )
                    BEGIN
                        IF CHARINDEX('ADD CONSTRAINT', @TSQL ) = 0 AND CHARINDEX('DROP CONSTRAINT', @TSQL ) = 0
                            EXEC	@ExecDbAudit @TSQL
                    END

            
                ELSE IF @EventType IN ( 'RENAME' )
                    BEGIN
                        IF  CHARINDEX('COLUMN', @TSQL ) > 0 -- RENAME COLUMN -- DROP TRIGGER TABELA BASE
                            BEGIN
                                SET @TbRename	= SUBSTRING( @TSQL, CHARINDEX('.', @TSQL ) + 1, LEN( @TSQL ) - CHARINDEX('.', @TSQL ) - CHARINDEX('.', REVERSE( @TSQL ) ) )

                                SET	@Trigger	= 'SELECT o.name FROM sys.triggers AS t INNER JOIN sys.objects AS o  ON t.parent_id = o.object_id WHERE o.name = @TbRename';    

                                DELETE #tmpTrigger

                                INSERT INTO #tmpTrigger
                                    EXEC	@ExecDb @Trigger, N'@TbRename varchar(128)', @TbRename;

                                IF	EXISTS ( SELECT * FROM #tmpTrigger )
                                    BEGIN
                                        SET		@Trigger = 'DROP TRIGGER dbo.tg_' + @TbRename + '_audit';
                            
                                        EXEC	@ExecDb @Trigger
                                    END
                            END

                        EXEC	@ExecDbAudit @TSQL
                    END



                ELSE IF @EventType IN ( 'CREATE_TABLE' ) AND CHARINDEX('Tmp_', @TSQL ) > 0
                    BEGIN                   
                        EXEC	@ExecDbAudit @TSQL	-- Nova tabela Tmp  --	SET		@TSQL = 'SELECT * INTO ' + @db + '_Audit' + '.dbo.Tmp_' + @Tb + ' FROM ' + @db + '.dbo.' + @Tb + ' WHERE 1 = 2';		      

                        
                        SET		@TSQL = 'ALTER TABLE ' + @db + '_Audit' + '.dbo.Tmp_' + @Tb + ' ADD _Audit_Operacao char(1) NOT NULL, _Audit_UsuarioConexao varchar(20) NOT NULL, _Audit_DataConexao datetime NOT NULL';		      

                        EXEC	@ExecDbAudit @TSQL  -- ADD Campos _Audit no final

                        SET		@TSQL = 'SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @Tb'; 

                        DELETE  #tmpCampos

                        INSERT INTO #tmpCampos
                            EXEC	@ExecDbAudit @TSQL, N'@tb VARCHAR(128)', @Tb; -- GET Campos de _Audit

                        SELECT	@CamposAudit	= @CamposAudit + Campos + ', ' FROM #tmpCampos
                        SET		@CamposAudit	= SUBSTRING( @CamposAudit, 0, LEN( @CamposAudit ));


                        SET		@TSQL = 'INSERT INTO ' + @db + '_Audit' + '.dbo.Tmp_' + @Tb + ' ( ' + @CamposAudit + ' ) SELECT ' + @CamposAudit + ' FROM ' + @db + '_Audit' + '.dbo.' + @Tb + ' WITH (HOLDLOCK TABLOCKX)';

                        EXEC	@ExecDbAudit @TSQL  -- INSERT tabela atual de _Audit na Tmp_*
               
                        SET	@Trigger	= 'SELECT o.name FROM sys.triggers AS t INNER JOIN sys.objects AS o  ON t.parent_id = o.object_id WHERE o.name = @Tb';    

                        DELETE  #tmpTrigger

                        INSERT INTO #tmpTrigger
                            EXEC	@ExecDb @Trigger, N'@Tb varchar(128)', @Tb;

                        IF	EXISTS ( SELECT * FROM #tmpTrigger )
                            BEGIN
                                SET		@Trigger = 'DROP TRIGGER dbo.tg_' + @Tb + '_audit';
                
                                EXEC	@ExecDb @Trigger
                            END
                END

                --- FINAL
                SET		@TSQL = N'UPDATE BdDDL.dbo.DDLEvents SET ApplyDatabaseAudit = 1 WHERE IdDDLEvents = @Id;';

                EXEC	@ExecDb @TSQL, N'@Id int', @IdDDLEvents;

                DELETE FROM  #tmpTabelas WHERE  IdDDLEvents = @IdDDLEvents
            END TRY
            BEGIN CATCH
                PRINT	ERROR_MESSAGE()
            END CATCH
        END
END
