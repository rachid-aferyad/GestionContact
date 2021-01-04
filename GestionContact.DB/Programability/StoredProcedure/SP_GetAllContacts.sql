CREATE PROCEDURE [dbo].[SP_GetAllContacts]
AS
BEGIN
	SELECT FirstName, LastName, Email, Phone, BirthDate
	FROM [Contact]
END
