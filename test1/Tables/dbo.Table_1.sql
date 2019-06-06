SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Table_1] (
		[ID]          [int] NULL,
		[ime]         [nchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[prezime]     [nchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[01]          [int] NULL,
		[02]          [int] NULL,
		[03]          [int] NULL,
		[04]          [int] NULL,
		[05]          [int] NULL,
		[06]          [int] NULL,
		[07]          [int] NULL,
		[08]          [int] NULL,
		[09]          [int] NULL,
		[10]          [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Table_1] SET (LOCK_ESCALATION = TABLE)
GO
