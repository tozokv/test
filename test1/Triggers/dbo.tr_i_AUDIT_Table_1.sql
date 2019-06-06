SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[tr_i_AUDIT_Table_1]
ON [dbo].[Table_1]
FOR INSERT


As
-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"
-- --------------------------------------------------------------------------------------------------------------
-- Legal:        You may freely edit and modify this template and make copies of it.
-- Description:  INSERT TRIGGER for Table:  [dbo].[Table_1]
-- Author:       ApexSQL, LLC
-- Date:		 02/05/2019 2:21:12 PM
-- --------------------------------------------------------------------------------------------------------------
BEGIN
	DECLARE 
		@IDENTITY_SAVE				varchar(50),
		@AUDIT_LOG_TRANSACTION_ID		Int,
		@PRIM_KEY				nvarchar(4000),
		--@TABLE_NAME				nvarchar(4000),
		@ROWS_COUNT				int

	SET NOCOUNT ON

	--Set @TABLE_NAME = '[dbo].[Table_1]'
	Select @ROWS_COUNT=count(*) from inserted
	Set @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

	INSERT
	INTO [TestDB].dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		TABLE_SCHEMA,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		[DATABASE]
	)
	values(
		'Table_1',
		'dbo',
		2,	--	ACTION ID For INSERT
		CASE 
		  WHEN LEN(HOST_NAME()) < 1 THEN ' '
		  ELSE HOST_NAME()
		END,
		CASE 
		  WHEN LEN(APP_NAME()) < 1 THEN ' '
		  ELSE APP_NAME()
		END,
		SUSER_SNAME(),
		GETDATE(),
		@ROWS_COUNT,
		'TestDB'
	)

	
	Set @AUDIT_LOG_TRANSACTION_ID = SCOPE_IDENTITY()
	

	
	INSERT INTO [TestDB].dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		NEW_VALUE_LONG,
		DATA_TYPE
		, KEY1, KEY2, KEY3, KEY4
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
		convert(nvarchar(1500), IsNull('[ID]='+CONVERT(nvarchar(4000), NEW.[ID], 0), '[ID] Is Null') + ' AND ' + IsNull('[ime]=N'''+replace(CONVERT(nvarchar(4000), NEW.[ime], 0), '''', '''''')+'''', '[ime] Is Null') + ' AND ' + IsNull('[prezime]=N'''+replace(CONVERT(nvarchar(4000), NEW.[prezime], 0), '''', '''''')+'''', '[prezime] Is Null') + ' AND ' + IsNull('[01]='+CONVERT(nvarchar(4000), NEW.[01], 0), '[01] Is Null')),
		'01',
		CONVERT(nvarchar(4000), NEW.[01], 0),
		'A'
		, CONVERT(nvarchar(500), CONVERT(nvarchar(4000), NEW.[ID], 0)), CONVERT(nvarchar(500), CONVERT(nvarchar(4000), NEW.[ime], 0)), CONVERT(nvarchar(500), CONVERT(nvarchar(4000), NEW.[prezime], 0)), CONVERT(nvarchar(500), CONVERT(nvarchar(4000), NEW.[01], 0))
	FROM inserted NEW
	WHERE NEW.[01] Is Not Null
    

	-- Lookup 
	

  -- Restore @@IDENTITY Value
  
    CREATE TABLE #tmp (ID DECIMAL IDENTITY)
    SET IDENTITY_INSERT #tmp ON
    INSERT INTO #tmp (Id) VALUES (CAST(@IDENTITY_SAVE AS DECIMAL))
    SET IDENTITY_INSERT #tmp OFF
  

End
GO
EXEC sp_settriggerorder @triggername= '[dbo].[tr_i_AUDIT_Table_1]', @order='Last', @stmttype='INSERT'
GO
