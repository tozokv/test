SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[tr_u_AUDIT_Table_1]
ON [dbo].[Table_1]
FOR UPDATE

As
-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"
-- --------------------------------------------------------------------------------------------------------------
-- Legal:        You may freely edit and modify this template and make copies of it.
-- Description:  UPDATE TRIGGER for Table:  [dbo].[Table_1]
-- Author:       ApexSQL, LLC
-- Date:		 02/05/2019 2:21:12 PM
-- --------------------------------------------------------------------------------------------------------------
BEGIN
	DECLARE 
		@IDENTITY_SAVE			varchar(50),
		@AUDIT_LOG_TRANSACTION_ID	Int,
		@PRIM_KEY			nvarchar(4000),
		@Inserted	    		bit,
		--@TABLE_NAME				nvarchar(4000),
 		@ROWS_COUNT				int

	SET NOCOUNT ON

	--Set @TABLE_NAME = '[dbo].[Table_1]'
	Select @ROWS_COUNT=count(*) from inserted
	SET @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

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
		1,	--	ACTION ID For UPDATE
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
	

	SET @Inserted = 0
	
	If UPDATE([01])
	BEGIN
    
		INSERT
		INTO [TestDB].dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			OLD_VALUE_LONG,
			NEW_VALUE_LONG,
			DATA_TYPE
			, KEY1, KEY2, KEY3, KEY4
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
		    convert(nvarchar(1500), IsNull('[ID]='+CONVERT(nvarchar(4000), IsNull(OLD.[ID], NEW.[ID]), 0), '[ID] Is Null')+' AND '+IsNull('[ime]=N'''+replace(CONVERT(nvarchar(4000), IsNull(OLD.[ime], NEW.[ime]), 0),'''' ,'''''')+'''', '[ime] Is Null')+' AND '+IsNull('[prezime]=N'''+replace(CONVERT(nvarchar(4000), IsNull(OLD.[prezime], NEW.[prezime]), 0),'''' ,'''''')+'''', '[prezime] Is Null')+' AND '+IsNull('[01]='+CONVERT(nvarchar(4000), IsNull(OLD.[01], NEW.[01]), 0), '[01] Is Null')),
		    '01',
			CONVERT(nvarchar(4000), OLD.[01], 0),
			CONVERT(nvarchar(4000), NEW.[01], 0),
			'A'
			, IsNULL( CONVERT(nvarchar(500), CONVERT(nvarchar(4000), OLD.[ID], 0)), CONVERT(nvarchar(500), CONVERT(nvarchar(4000), NEW.[ID], 0))), IsNULL( CONVERT(nvarchar(500), CONVERT(nvarchar(4000), OLD.[ime], 0)), CONVERT(nvarchar(500), CONVERT(nvarchar(4000), NEW.[ime], 0))), IsNULL( CONVERT(nvarchar(500), CONVERT(nvarchar(4000), OLD.[prezime], 0)), CONVERT(nvarchar(500), CONVERT(nvarchar(4000), NEW.[prezime], 0))), IsNULL( CONVERT(nvarchar(500), CONVERT(nvarchar(4000), OLD.[01], 0)), CONVERT(nvarchar(500), CONVERT(nvarchar(4000), NEW.[01], 0)))
			
		FROM deleted OLD Full Outer Join inserted NEW On
			(CONVERT(nvarchar(4000), NEW.[ID], 0)=CONVERT(nvarchar(4000), OLD.[ID], 0) or (NEW.[ID] Is Null and OLD.[ID] Is Null)) AND (CONVERT(nvarchar(4000), NEW.[ime], 0)=CONVERT(nvarchar(4000), OLD.[ime], 0) or (NEW.[ime] Is Null and OLD.[ime] Is Null)) AND (CONVERT(nvarchar(4000), NEW.[prezime], 0)=CONVERT(nvarchar(4000), OLD.[prezime], 0) or (NEW.[prezime] Is Null and OLD.[prezime] Is Null)) AND (CONVERT(nvarchar(4000), NEW.[01], 0)=CONVERT(nvarchar(4000), OLD.[01], 0) or (NEW.[01] Is Null and OLD.[01] Is Null))
			WHERE (
			
			
				(
					NEW.[01] <>
					OLD.[01]
				) Or
			
				(
					NEW.[01] Is Null And
					OLD.[01] Is Not Null
				) Or
				(
					NEW.[01] Is Not Null And
					OLD.[01] Is Null
				)
				)
        
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END
	
	-- Watch
	
    --'
	-- Lookup
	
	IF @Inserted = 0
	BEGIN
		DELETE FROM [TestDB].dbo.AUDIT_LOG_TRANSACTIONS WHERE AUDIT_LOG_TRANSACTION_ID = @AUDIT_LOG_TRANSACTION_ID
	END

  -- Restore @@IDENTITY Value
  
    CREATE TABLE #tmp (ID DECIMAL IDENTITY)
    SET IDENTITY_INSERT #tmp ON
    INSERT INTO #tmp (Id) VALUES (CAST(@IDENTITY_SAVE AS DECIMAL))
    SET IDENTITY_INSERT #tmp OFF
  
End
GO
EXEC sp_settriggerorder @triggername= '[dbo].[tr_u_AUDIT_Table_1]', @order='Last', @stmttype='UPDATE'
GO
