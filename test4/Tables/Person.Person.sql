SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [Person].[Person] (
		[BusinessEntityID]          [int] NOT NULL,
		[PersonType]                [nchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NameStyle]                 [dbo].[NameStyle] NOT NULL,
		[Title]                     [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FirstName]                 [dbo].[Name] NOT NULL,
		[MiddleName]                [dbo].[Name] NULL,
		[LastName]                  [dbo].[Name] NOT NULL,
		[Suffix]                    [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[EmailPromotion]            [int] NOT NULL,
		[AdditionalContactInfo]     [xml](CONTENT [Person].[AdditionalContactInfoSchemaCollection]) NULL,
		[Demographics]              [xml](CONTENT [Person].[IndividualSurveySchemaCollection]) NULL,
		[rowguid]                   [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[ModifiedDate]              [datetime] NOT NULL,
		[new]                       [int] NULL,
		CONSTRAINT [PK_Person_BusinessEntityID]
		PRIMARY KEY
		CLUSTERED
		([BusinessEntityID])
	ON [PRIMARY]
)
GO
ALTER TABLE [Person].[Person]
	ADD
	CONSTRAINT [CK_Person_EmailPromotion]
	CHECK
	([EmailPromotion]>=(0) AND [EmailPromotion]<=(2))
GO
ALTER TABLE [Person].[Person]
CHECK CONSTRAINT [CK_Person_EmailPromotion]
GO
ALTER TABLE [Person].[Person]
	ADD
	CONSTRAINT [CK_Person_PersonType]
	CHECK
	([PersonType] IS NULL OR (upper([PersonType])='GC' OR upper([PersonType])='SP' OR upper([PersonType])='EM' OR upper([PersonType])='IN' OR upper([PersonType])='VC' OR upper([PersonType])='SC'))
GO
ALTER TABLE [Person].[Person]
CHECK CONSTRAINT [CK_Person_PersonType]
GO
ALTER TABLE [Person].[Person]
	ADD
	CONSTRAINT [DF_Person_NameStyle]
	DEFAULT ((0)) FOR [NameStyle]
GO
ALTER TABLE [Person].[Person]
	ADD
	CONSTRAINT [DF_Person_EmailPromotion]
	DEFAULT ((0)) FOR [EmailPromotion]
GO
ALTER TABLE [Person].[Person]
	ADD
	CONSTRAINT [DF_Person_rowguid]
	DEFAULT (newid()) FOR [rowguid]
GO
ALTER TABLE [Person].[Person]
	ADD
	CONSTRAINT [DF_Person_ModifiedDate]
	DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [Person].[Person]
	WITH CHECK
	ADD CONSTRAINT [FK_Person_BusinessEntity_BusinessEntityID]
	FOREIGN KEY ([BusinessEntityID]) REFERENCES [Person].[BusinessEntity] ([BusinessEntityID])
ALTER TABLE [Person].[Person]
	CHECK CONSTRAINT [FK_Person_BusinessEntity_BusinessEntityID]

GO
CREATE NONCLUSTERED INDEX [IX_Person_LastName_FirstName_MiddleName]
	ON [Person].[Person] ([LastName], [FirstName], [MiddleName])
	ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_Person_rowguid]
	ON [Person].[Person] ([rowguid])
	ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
CREATE PRIMARY XML INDEX [PXML_Person_AddContact]
	ON [Person].[Person] ([AdditionalContactInfo])
GO
SET ANSI_PADDING ON
GO
CREATE PRIMARY XML INDEX [PXML_Person_Demographics]
	ON [Person].[Person] ([Demographics])
GO
SET ANSI_PADDING ON
GO
CREATE XML INDEX [XMLPATH_Person_Demographics]
	ON [Person].[Person] ([Demographics])
	USING XML INDEX [PXML_Person_Demographics]
	FOR PATH
GO
SET ANSI_PADDING ON
GO
CREATE XML INDEX [XMLPROPERTY_Person_Demographics]
	ON [Person].[Person] ([Demographics])
	USING XML INDEX [PXML_Person_Demographics]
	FOR PROPERTY
GO
SET ANSI_PADDING ON
GO
CREATE XML INDEX [XMLVALUE_Person_Demographics]
	ON [Person].[Person] ([Demographics])
	USING XML INDEX [PXML_Person_Demographics]
	FOR VALUE
GO
ALTER TABLE [Person].[Person] SET (LOCK_ESCALATION = TABLE)
GO
