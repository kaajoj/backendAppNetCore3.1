USE [TestPumox]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 21.03.2020 14:36:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Company]    Script Date: 21.03.2020 14:36:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Company](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[EstablishmentYear] [int] NOT NULL,
 CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 21.03.2020 14:36:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[EmployeeId] [bigint] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](max) NOT NULL,
	[LastName] [nvarchar](max) NOT NULL,
	[DateOfBirth] [datetime2](7) NOT NULL,
	[JobTitle] [int] NOT NULL,
	[CompanyId] [bigint] NOT NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20200321131358_12', N'3.1.2')
SET IDENTITY_INSERT [dbo].[Company] ON 

INSERT [dbo].[Company] ([Id], [Name], [EstablishmentYear]) VALUES (1, N'TestCompany1', 2005)
INSERT [dbo].[Company] ([Id], [Name], [EstablishmentYear]) VALUES (2, N'TestCompany2', 2010)
INSERT [dbo].[Company] ([Id], [Name], [EstablishmentYear]) VALUES (3, N'TestCompany3', 2008)
SET IDENTITY_INSERT [dbo].[Company] OFF
SET IDENTITY_INSERT [dbo].[Employee] ON 

INSERT [dbo].[Employee] ([EmployeeId], [FirstName], [LastName], [DateOfBirth], [JobTitle], [CompanyId]) VALUES (1, N'FName1', N'LName1', CAST(N'1992-01-01T00:00:00.0000000' AS DateTime2), 1, 1)
INSERT [dbo].[Employee] ([EmployeeId], [FirstName], [LastName], [DateOfBirth], [JobTitle], [CompanyId]) VALUES (2, N'FName2', N'LName2', CAST(N'1994-01-01T00:00:00.0000000' AS DateTime2), 2, 1)
INSERT [dbo].[Employee] ([EmployeeId], [FirstName], [LastName], [DateOfBirth], [JobTitle], [CompanyId]) VALUES (3, N'FName3', N'LName3', CAST(N'1980-01-01T00:00:00.0000000' AS DateTime2), 1, 2)
INSERT [dbo].[Employee] ([EmployeeId], [FirstName], [LastName], [DateOfBirth], [JobTitle], [CompanyId]) VALUES (4, N'FName4', N'LName4', CAST(N'1985-01-01T00:00:00.0000000' AS DateTime2), 2, 2)
INSERT [dbo].[Employee] ([EmployeeId], [FirstName], [LastName], [DateOfBirth], [JobTitle], [CompanyId]) VALUES (5, N'FName5', N'LName5', CAST(N'1982-01-01T00:00:00.0000000' AS DateTime2), 0, 3)
INSERT [dbo].[Employee] ([EmployeeId], [FirstName], [LastName], [DateOfBirth], [JobTitle], [CompanyId]) VALUES (6, N'FName6', N'LName6', CAST(N'1995-01-01T00:00:00.0000000' AS DateTime2), 3, 3)
SET IDENTITY_INSERT [dbo].[Employee] OFF
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Company_CompanyId] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[Company] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_Company_CompanyId]
GO
