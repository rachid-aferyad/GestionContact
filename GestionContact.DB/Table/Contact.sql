CREATE TABLE [dbo].[Contact]
(
	[Id] INT NOT NULL IDENTITY, 
    [LastName] NVARCHAR(75) NOT NULL, 
    [FirstName] NVARCHAR(75) NOT NULL, 
    [Email] NVARCHAR(320) NOT NULL, 
    [Phone] NVARCHAR(20) NOT NULL, 
    [BirthDate] DATETIME2(7),
	[Password] BINARY(64) NOT NULL,
    CONSTRAINT [PK_Contact] PRIMARY KEY ([Id])


)
