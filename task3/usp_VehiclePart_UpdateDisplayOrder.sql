
CREATE PROCEDURE usp_VehiclePart_UpdateDisplayOrder
    @json NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @errorCode INT = 0;

    BEGIN TRY
        -- Parse the JSON array into a table variable
        DECLARE @vehicleParts TABLE (
            VehiclePartID INT,
            DisplayOrder INT
        );

        INSERT INTO @vehicleParts (VehiclePartID, DisplayOrder)
        SELECT VehiclePartID, DisplayOrder
        FROM OPENJSON(@json)
        WITH (
            VehiclePartID INT,
            DisplayOrder INT
        );

        -- Update the DisplayOrder for each VehiclePartID
        UPDATE vp
        SET vp.DisplayOrder = vpNew.DisplayOrder
        FROM VehiclePart vp
        INNER JOIN @vehicleParts vpNew
            ON vp.VehiclePartID = vpNew.VehiclePartID;

    END TRY
    BEGIN CATCH
        -- Handle errors and set the error code
        SET @errorCode = ERROR_NUMBER();
    END CATCH

    -- Return the error code (0 if no error)
    RETURN @errorCode;
END;
