SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Table_4] (
		[01]     [int] NOT NULL,
		[02]     [int] NULL,
		[03]     [int] NULL,
		[04]     [int] NULL,
		[05]     [int] NULL,
		CONSTRAINT [PK_Table_4]
		PRIMARY KEY
		CLUSTERED
		([01])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Table_4] SET (LOCK_ESCALATION = TABLE)
GO
