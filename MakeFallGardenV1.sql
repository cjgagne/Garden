PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;

/* Create Table of Vegetables I would like in my fall garden */
CREATE TABLE DesiredVeg (AggieName TEXT);
.mode csv 
.import 'DesiredVeg.csv' DesiredVeg
delete from DesiredVeg where AggieName='Desired Plants';
delete from DesiredVeg where AggieName='';
/*select * from DesiredVeg;*/

/* Create table of Vegetable Harvests and Yields */
CREATE TABLE VegYield (AggieName TEXT, DayToHarvest TEXT, LengthOfHarvest TEXT, YieldPer100Ft TEXT, ApproxPlantingPerPersonFresh TEXT, ApproxPlantingPerPersonCanFroz TEXT);
.mode csv
.import 'AggieVegHarvestAndYield.csv' VegYield
delete from VegYield where AggieName='Table 9. Vegetable harvest and yield.';
delete from VegYield where AggieName='Vegetable';
delete from VegYield where AggieName='';
delete from VegYield where ApproxPlantingPerPersonFresh='N/A';
/*select * from VegYield;*/

/* Create table of Vegetable Planting Info.  Includes Fall Planting Recomendations, Spacing and Height */
CREATE TABLE VegPlantingInfo (AggieName TEXT, SeedsOrPlantsPer100Ft TEXT, DepthOfPlantsInch TEXT, DistanceBetweenRowsInch TEXT, DistanceBetweenPlantsInch TEXT, HeightOfCropFt TEXT, SpringPlantingRelToFrostFreeDate TEXT, FallPlantingRelToFirstFreezeDate);
.mode csv
.import 'AggieVegPlanting.csv' VegPlantingInfo
delete from VegPlantingInfo where AggieName='Table 8. Vegetable planting. ';
delete from VegPlantingInfo where AggieName='Vegetables';
delete from VegPlantingInfo where AggieName='';
/*select * from VegPlantingInfo;*/

/*select AggieName from VegPlantingInfo where FallPlantingReltoFirstFreezeDate='not recommended';*/
/*select AggieName from DesiredVeg INTERSECT SELECT AggieName from VegPlantingInfo WHERE FallPlantingReltoFirstFreezeDate != 'not recommended'*/;

/*SELECT VegYield.ApproxPlantingPerPersonFresh FROM VegYield*/;
/*SELECT VegYield.ApproxPlantingPerPersonFresh FROM VegYield WHERE VegYield.AggieName IN DesiredVeg*/;
/*SELECT VegYield.ApproxPlantingPerPersonFresh FROM VegYield WHERE VegYield.AggieName IN (select AggieName from DesiredVeg INTERSECT SELECT AggieName from VegPlantingInfo WHERE FallPlantingReltoFirstFreezeDate != 'not recommended')*/;

/*SELECT VegYield.AggieName, VegYield.ApproxPlantingPerPersonFresh FROM VegYield WHERE VegYield.AggieName IN (select AggieName from DesiredVeg INTERSECT SELECT AggieName from VegPlantingInfo WHERE FallPlantingReltoFirstFreezeDate != 'not recommended')*/;

/* Create table of Desired Vegatables Suitable For Fall Garden */
CREATE TABLE DesiredVegYield (AggieName TEXT, DayToHarvest TEXT, LengthOfHarvest TEXT, YieldPer100Ft TEXT, ApproxPlantingPerPersonFresh TEXT, ApproxPlantingPerPersonCanFroz TEXT);

/*SELECT * FROM VegYield WHERE (VegYield.AggieName IN (SELECT DesiredVeg.AggieName FROM DesiredVeg INTERSECT SELECT VegPlantingInfo.AggieName FROM VegPlantingInfo WHERE VegPlantingInfo.FallPlantingReltoFirstFreezeDate != 'not recommended'));*/

INSERT INTO DesiredVegYield SELECT * FROM VegYield WHERE (VegYield.AggieName IN (SELECT DesiredVeg.AggieName FROM DesiredVeg INTERSECT SELECT VegPlantingInfo.AggieName FROM VegPlantingInfo WHERE VegPlantingInfo.FallPlantingReltoFirstFreezeDate != 'not recommended'));

/*SELECT * FROM DesiredVegYield;*/

/*CREATE TABLE PerPersonPlantingRange (AggieName TEXT, Min INTEGER, MAX INTEGER, UNITS TEXT);*/
CREATE TABLE NumSquares (AggieName TEXT, Squares INTEGER);

/*SELECT DesiredVegYield.AggieName, SUBSTR(DesiredVegYield.ApproxPlantingPerPersonFresh, 1, 1) 'Min' FROM DesiredVegYield;*/

INSERT INTO NumSquares SELECT DesiredVegYield.AggieName,
CASE 
WHEN SUBSTR(DesiredVegYield.ApproxPlantingPerPersonFresh, 2, 1) == '-' 
THEN 2*CAST(SUBSTR(DesiredVegYield.ApproxPlantingPerPersonFresh, 1, 1) AS INTEGER) 
ELSE 2*CAST(SUBSTR(DesiredVegYield.ApproxPlantingPerPersonFresh, 1, 2) AS INTEGER)
END 
FROM DesiredVegYield;

.mode csv
.output NumSquares.csv
/*SELECT total(NumSquares.Squares), * FROM NumSquares;*/
SELECT * FROM NumSquares;
.output stdout


