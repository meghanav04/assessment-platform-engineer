CREATE PROCEDURE usp_VehiclePart_ReadSearch
    @vehicleName NVARCHAR(20),
    @vehiclePartName NVARCHAR(20) = NULL,
    @sku NVARCHAR(10) = NULL,
    @isStockItem BIT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Optimized query using indexed search
    SELECT 
        v.VehicleName,
        vp.VehiclePartName,
        vp.Sku, 
        vp.IsStockItem
    FROM Vehicle v 
    INNER JOIN VehiclePart vp 
        ON v.VehicleID = vp.VehicleID
    WHERE 
        v.VehicleName = @vehicleName
        AND (@vehiclePartName IS NULL OR vp.VehiclePartName LIKE @vehiclePartName + '%')
        AND (@sku IS NULL OR vp.Sku = @sku)
        AND (@isStockItem IS NULL OR vp.IsStockItem = @isStockItem);
END;


-- Add indexes to optimize search performance
CREATE INDEX idx_VehicleName ON Vehicle (VehicleName);
CREATE INDEX idx_VehiclePartName ON VehiclePart (VehiclePartName);
CREATE INDEX idx_Sku ON VehiclePart (Sku);
CREATE INDEX idx_IsStockItem ON VehiclePart (IsStockItem);

-- Add foreign key constraint
ALTER TABLE VehiclePart
ADD CONSTRAINT FK_VehiclePart_Vehicle
FOREIGN KEY (VehicleID) REFERENCES Vehicle(VehicleID);