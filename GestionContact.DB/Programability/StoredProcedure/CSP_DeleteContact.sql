﻿CREATE PROCEDURE [dbo].[CSP_DeleteContact]
	@Id INT
AS
BEGIN
	DELETE FROM Contact
	WHERE Id = @Id;
END
