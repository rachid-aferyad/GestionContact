CREATE PROCEDURE [dbo].[SP_CheckContact]
	@Email NVARCHAR(50),
	@Password NVARCHAR(20)
AS
BEGIN
	SELECT [Id], [FirstName], [LastName], [Email], [BirthDate] FROM [Contact]
	WHERE [Email] = @Email AND [Password] = HASHBYTES('SHA2_512', [dbo].GetPreSalt() + @Password + [dbo].GetPostSalt())
END