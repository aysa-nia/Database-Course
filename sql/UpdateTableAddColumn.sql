-- Add two new columns to Apartment table
USE FinalPhase;

ALTER TABLE Apartment
ADD HasParkingOrNot BIT NOT NULL;

ALTER TABLE Apartment
ADD FloorNumber INT NULL;

ALTER TABLE Apartment
ADD HasElevatorOrNot BIT NOT NULL;

ALTER TABLE Apartment
ADD HasBalconyOrNot BIT NULL;

ALTER TABLE Apartment
ADD TotalNumberOfFloors INT NULL;


ALTER TABLE Apartment
ADD TotalNumberOfUnits INT NULL;

ALTER TABLE Rate
ADD AverageOfRates FLOAT
SELECT AVG (NumericalRate)
FROM Rate
GROUP BY Rate.AgencyID;
