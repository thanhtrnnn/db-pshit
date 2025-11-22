DELETE FROM Manufacturers
WHERE ManufacturerID NOT IN (
    SELECT ManufacturerID
    FROM ManufacturersSustainableMaterials
);