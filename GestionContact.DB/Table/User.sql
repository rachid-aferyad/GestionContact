﻿CREATE TABLE [dbo].[User]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY,
	[FirstName] NVARCHAR(50) NOT NULL,
	[LastName] NVARCHAR(50) NOT NULL,
	[Email] NVARCHAR(320) NOT NULL,
	[EncodedPassword] BINARY(64) NOT NULL,
	[BirthDate] DATETIME2(7)
)
