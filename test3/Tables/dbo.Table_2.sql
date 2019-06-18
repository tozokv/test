SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Table_2] (
		[table2]     [nchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[name]       [nchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[number]     [int] NULL,
		[new]        [int] NULL,
		[new2]       [int] NULL,
		[new3]       [int] NULL,
		[new4]       [int] NULL,
		CONSTRAINT [PK_Table_2]
		PRIMARY KEY
		CLUSTERED
		([table2])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Table_2] SET (LOCK_ESCALATION = TABLE)
GO
