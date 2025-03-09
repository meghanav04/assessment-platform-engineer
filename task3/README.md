
# SQL Changes

## AppendixA

The following changes were made to the `AppendixA` SQL file:

- Added indexes to optimize search performance:
  - `idx_VehicleName` on `Vehicle (VehicleName)`
  - `idx_VehiclePartName` on `VehiclePart (VehiclePartName)`
  - `idx_Sku` on `VehiclePart (Sku)`
  - `idx_IsStockItem` on `VehiclePart (IsStockItem)`
- Added a foreign key constraint to ensure data integrity:
  - `FK_VehiclePart_Vehicle` on `VehiclePart (VehicleID)` referencing `Vehicle (VehicleID)`

## usp_VehiclePart_ReadSearch.sql

The following changes were made to the `usp_VehiclePart_ReadSearch.sql` stored procedure:

- Optimized the query to utilize the newly created indexes for better performance.

## usp_VehiclePart_UpdateDisplayOrder.sql

The following changes were made to the `usp_VehiclePart_UpdateDisplayOrder.sql` stored procedure:

- Created a new stored procedure to update the `DisplayOrder` column using a JSON array of objects.
- The stored procedure handles errors using return codes instead of exceptions.
- The stored procedure handles cases where the JSON array contains only a few of the `VehiclePartID`/`DisplayOrder` combinations.

### Example JSON Array

```json
[
    { 
        "VehiclePartID": 1, 
        "DisplayOrder": 2 
    }, 
    { 
        "VehiclePartID": 2, 
        "DisplayOrder": 1 
    } 
]
```
