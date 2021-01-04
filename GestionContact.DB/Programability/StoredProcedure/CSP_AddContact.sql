CREATE PROCEDURE [dbo].[CSP_AddContact]
	@LastName NVARCHAR(75), 
    @FirstName NVARCHAR(75), 
    @Email NVARCHAR(320), 
    @Phone NVARCHAR(20), 
    @BirthDate DATETIME2(7),
    @Password NVARCHAR(20)
AS
BEGIN
	INSERT INTO Contact (LastName, FirstName, Email, Phone, BirthDate, [Password]) 
    OUTPUT inserted.Id
    VALUES (@LastName, @FirstName, @Email, @Phone, @BirthDate, HashBytes('SHA2_512', [dbo].[GetPreSalt]() + @Password + [dbo].[GetPostSalt]()));
END
