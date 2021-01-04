CREATE PROCEDURE [dbo].[SP_RegisterUser]
	@FirstName VARCHAR(50),
	@LastName VARCHAR(50),
	@Email VARCHAR(320),
	@Password VARCHAR(20),
	@BirthDate DATETIME2(7)
AS
BEGIN
	INSERT INTO [User]([FirstName], [LastName], [Email], [EncodedPassword], [BirthDate])
	OUTPUT INSERTED.Id
	VALUES(@FirstName, @LastName, @Email, HASHBYTES('SHA2_512', [dbo].GetPreSalt() + @Password + [dbo].GetPostSalt() ), @BirthDate)
END
