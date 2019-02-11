-- Sample VineYard Database
-- Original Schema created by Rahul Dhankhar

--  *DISCLAIMER*
--  To the best of my knowledge, this data is fabricated, and
--  it does not correspond to real people. 
--  Any similarity to existing people is purely coincidental.




DROP DATABASE IF EXISTS ValleyVineyardDB;

CREATE DATABASE IF NOT EXISTS  ValleyVineyardDB;

USE ValleyVineyardDB;

DROP TABLE IF EXISTS Vineyard,
GrapeVariety,
VintageYear,
Employee,
Skill,
Has_skill,
Blend,
Wine,
Bottle,
Product,
Customer,
`Order`,
OrderLineItem,
CommercialCustomer,
IndividualCustomer;

CREATE TABLE `Vineyard` (
    `VineyardID` INTEGER,
    `Name` VARCHAR(20) NOT NULL,
    `Size` VARCHAR(20) NOT NULL,
    `Owner` VARCHAR(20) NOT NULL,
    `Location` VARCHAR(80) NOT NULL,
    PRIMARY KEY (`VineyardID`),
    UNIQUE KEY (`Name`)
);



CREATE TABLE `GrapeVariety` (
    `GV_Code` INTEGER,
    `Gv_name` VARCHAR(20) NOT NULL,
    `JuiceRatio` INTEGER NOT NULL,
    PRIMARY KEY (`GV_Code`)
);



CREATE TABLE `VintageYear` (
    `VineyardID` INTEGER NOT NULL,
    `GV_Code` INTEGER NOT NULL,
    `Year` YEAR,
    FOREIGN KEY (`VineyardID`)
        REFERENCES Vineyard (VineyardID)
        ON DELETE CASCADE,
    FOREIGN KEY (`GV_Code`)
        REFERENCES GrapeVariety (GV_Code)
        ON DELETE CASCADE,
    PRIMARY KEY (VineyardID , GV_Code)
);

CREATE TABLE `Employee` (
    `EmployeeID` INTEGER AUTO_INCREMENT,
    `FirstName` VARCHAR(20) NOT NULL,
    `LastName` VARCHAR(20) NOT NULL,
    `SSN` CHAR(9) NOT NULL,
    `Phone` CHAR(10) NOT NULL,
    `StreetAddress` VARCHAR(80),
    `Zipcode` char(5),
    `DOB` DATE NOT NULL,
    `VineyardID` INTEGER NOT NULL,
    `GV_Code` INTEGER NOT NULL,
    PRIMARY KEY (`EmployeeID`),
    FOREIGN KEY (`VineyardID`)
        REFERENCES Vineyard (VineyardID)
        ON DELETE CASCADE,
    FOREIGN KEY (`GV_Code`)
        REFERENCES GrapeVariety (GV_Code)
        ON DELETE CASCADE,
    UNIQUE KEY (`SSN`),
    UNIQUE KEY (`Phone`) 
);
ALTER TABLE `Employee` AUTO_INCREMENT = 1000;

CREATE TABLE `Skill` (
    `SkillID` INTEGER,
    `SkillDesc` VARCHAR(40),
    PRIMARY KEY (`SkillID`)
);


CREATE TABLE `Has_skill` (
    `EmployeeID` INTEGER NOT NULL,
    `SkillID` INTEGER NOT NULL,
    FOREIGN KEY (`EmployeeID`)
        REFERENCES Employee (EmployeeID)
        ON DELETE CASCADE,
    FOREIGN KEY (`SkillID`)
        REFERENCES Skill (SkillID)
        ON DELETE CASCADE,
        PRIMARY KEY (EmployeeID, SkillID)
);

CREATE TABLE `Blend` (
    `BlendID` INTEGER,
    `GrapeCategory` CHAR(20) NOT NULL,
    `BlendProportion` CHAR(10),
    `Blend_MadeInYear` DATE,
    `GV_Code` INTEGER NOT NULL,
    PRIMARY KEY (`BlendID`),
    FOREIGN KEY (`GV_Code`)
        REFERENCES GrapeVariety (GV_Code)
        ON DELETE CASCADE
);


CREATE TABLE `Wine` (
    `WineID` INTEGER,
    `WineName` VARCHAR(20) NOT NULL,
    `AlcoholPer` CHAR(4),
    `WineCategory` CHAR(10),
    `Wine_madeInYear` DATE,
    `BlendID` INTEGER NOT NULL,
    PRIMARY KEY (`WineID`),
    FOREIGN KEY (`BlendID`)
        REFERENCES Blend (BlendID)
        ON DELETE CASCADE
);


CREATE TABLE `Bottle` (
    `BottleId` INTEGER,
    `Capacity` CHAR(10) NOT NULL,
    `GlassColor` CHAR(10) NOT NULL,
    `Shape` CHAR(20) NOT NULL,
    `UnitPrice` CHAR(4) NOT NULL,
    PRIMARY KEY (`BottleId`)
);


CREATE TABLE `Product` (
  `ProductID` integer,
  `UnitPrice` char(5) NOT NULL,
  `FinishedProduct` integer NOT NULL,
  `WineID` integer NOT NULL,
  `BottleID` integer NOT NULL,
  PRIMARY KEY (`ProductID`),
  FOREIGN KEY (`WineID`) REFERENCES Wine(WineID) ON DELETE CASCADE,
  FOREIGN KEY (`BottleID`) REFERENCES Bottle(BottleID) ON DELETE CASCADE
);

CREATE TABLE `Customer` (
  `CustomerID` integer AUTO_INCREMENT,
  `Phone` char(10) NOT NULL,
  `Email` varchar(20) NOT NULL,
  `StreetAddress` varchar(80),
  `ZipCode` char(5),
  `Country` varchar(10),
  PRIMARY KEY (`CustomerID`),
  UNIQUE KEY (`Phone`),
  UNIQUE KEY (`Email`)
);
ALTER TABLE `Customer` AUTO_INCREMENT = 10000;


CREATE TABLE `Order` (
  `OrderID` integer AUTO_INCREMENT,
  `Orderdate` date NOT NULL,
  `PaymentCategory` char(20) NOT NULL,
  `CustomerID` integer NOT NULL,
  PRIMARY KEY (`OrderID`),
  FOREIGN KEY (`CustomerID`) REFERENCES Customer(CustomerID) ON DELETE CASCADE
);
 ALTER TABLE `Order` AUTO_INCREMENT = 50000;

CREATE TABLE `OrderLineItem` (
  `ProductID` integer NOT NULL,
  `OrderID` integer NOT NULL,
  `Quantity` char(10),
  FOREIGN KEY (`ProductID`) REFERENCES Product(ProductID) ON DELETE CASCADE,
  FOREIGN KEY (`OrderID`) REFERENCES `Order`(OrderID) ON DELETE CASCADE,
  PRIMARY KEY (`ProductID`,`OrderID`)
);


CREATE TABLE `CommercialCustomer` (
  `CustomerID` integer PRIMARY KEY REFERENCES Customer(CustomerID) ON DELETE CASCADE,
  `Company_name` varchar(20) NOT NULL,
  `TaxID` char(9) NOT NULL,
  UNIQUE KEY (`TaxID`)
);



CREATE TABLE `IndividualCustomer` (
  `CustomerID` integer PRIMARY KEY REFERENCES Customer(CustomerID) ON DELETE CASCADE,
  `FirstName` varchar(20) NOT NULL,
  `LastName` varchar(20) NOT NULL,
  `DOB` date NOT NULL
);

-- insert values in Vineyard table
INSERT INTO `Vineyard`(`VineyardID`,`Name`,`Size`,`Owner`,`Location`)
VALUES (1,'Heathers Vineyard','20 Acres', 'Heather Lamb','Pierce,Colorado'),
(2,'Ross Vineyard','10 Acres','Ross Benignton','Windsor,Colorado'),
(3,'Rattlesnake','4 Acres','VVI','Windsor,Colorado'),
(4,'Rockies Vineyard','2 Acres','VVI','Windsor,Colorado'),
(5,'Redfox','5 Acres','VVI','Windsor,Colorado');

-- insert values in Grape Variety table
INSERT INTO `GrapeVariety` (`GV_Code`,`GV_NAME`,`JuiceRatio`)
VALUES (11,'Cabernet Sauvignon', '50'),
(12,'Chardonnay', '70'),
(13,'Riesling','60'),
(14,'Pinot noir','20'),
(15,'Merlot','40'),
(16,'Sauvignon blanc','60');

-- insert values in  Vintage Year table
INSERT INTO `VintageYear` (`VineyardID`,`GV_Code`, `Year`)
VALUES (1, 11, 1998),
(1,12,2004),
(1, 13, 1997),
(2, 11, 1994),
(3, 13, 1999),
(3, 14, 2001),
(4, 15, 2009),
(4, 16, 2002),
(5, 14, 2000);

-- inaert values in Employee Table

INSERT INTO `employee` (`FirstName`, `LastName`, `SSN`, `Phone`, 
`StreetAddress`,`Zipcode`, `DOB`, `VineyardID`,`GV_Code`)
VALUES('Stephen','Colbert',831404082,7634764373,'804 Jumper Street',80521,8/9/1980,1,12),
('Chris','Billings',210998812,7747327864,'609 Cross Road Street',80521,9/8/1990,2,11),
('Sam','Caroll',575097897,3254762333,'1399 Church Street',80537,2/3/1988,1,13),
('Aaron','Smith',290782871,9813264783,'673 Elizabeth Road',80537,3/11/1978,3,13),
('Smantha','Rubert',989377611,9712713263,'129 University Town',80615,2/5/1988,3,14),
('Helen','Ness',893812761,656381263,'908 Town House',80615,12/1/1985,4,15),
('Nancy','Ronald',334390503,3826432485,'120 South Shield',80645,6/9/1975,4,16),
('Jen','Nurse',904426634,6666465445,'893 Nolan Drive',80645,12/1/1960,5,14),
('Donald','Draper',516235716,6565465555,'478 Moses Street',80610,12/3/1988,1,11),
('Rose','Helbert',996696325,9898766552,'7894 Park Street',80610,2/11/1990,3,14),
('Nociano','Cass',556735625,8907947864,'1233 University Road',80650,11/1/1961,4,16),
('Thomas','Jenson',787297730,9907768655,'129 Prime Street',80650,12/11/1990,1,12);

-- insert values in skill table

INSERT INTO `Skill` (`SkillID`,`SkillDesc`)
VALUES (21,'Pruning'),
(22,'Irrigation Management'),
(23,'Weed Control'),
(24,'Chemical Applications'),
(25,'Pest Control');

-- insert values in has skill table 
INSERT INTO `has_skill`(`EmployeeID`, `skillId`)
VALUES (1000,21),
(1000,22),
(1001,23),
(1002,25),
(1003,25),
(1004,21),
(1005,24),
(1005,25),
(1006,22),
(1007,23),
(1008,22),
(1009,25),
(1010,23),
(1011,21);

-- insert values in blend table
INSERT INTO `blend`(`BlendID`,`GrapeCategory`,`BlendProportion`,`Blend_MadeInYear`,`GV_Code`)
VALUES (31,'Niagra','50',8/21/2010,11),
(32,'Diamond','80',12/10/2011,12),
(33,'Concord','20',11/11/2009,13),
(34,'Concord','40',12/1/2009,15),
(35,'Diamond','50',2/12/2011,14),
(36,'Niagra','60', 12/9/2015,16);

-- insert values in wine table
INSERT INTO `wine`(`WineID`,`WineName`,`AlcoholPer`,`WineCategory`, `Wine_madeInYear`,`BlendID`)
VALUES (51,'Carignan','10%','Dry Red', 11/10/2010,31),
(52,'Auslese','11%','Dry Red',12/5/2012,32),
(53,'Bardolino','12%','White',7/11/2009,33),
(54,'Blanc de Blancs','8%','Desert',9/9/2012,34),
(55,'Blush','5%','White',12/6/2010,35),
(56,'Cava','9%','Dry Red',1/2/2011,36);

-- insert values in bottle table
INSERT INTO `Bottle`(`BottleId`, `Capacity`, `GlassColor`, `Shape`, `UnitPrice`)
VALUES (61,'350 ml', 'Red', 'Burgundy Bottle', '$3'),
(62,'750 ml','Blue','Bordeaux Bottle','$5'),
(63,'1.5 L','Green','Mosel','$10');

-- insert values in product table

INSERT INTO `Product`(`ProductID`, `UnitPrice`, `FinishedProduct`, `WineID`, `BottleID`)
VALUES (100,'$30', 20, 51, 61),
(101,'$45', 40, 51, 62),
(102,'$55', 80, 51, 63),
(103,'$50', 90, 52, 63),
(104,'$40', 33, 52, 62),
(105,'$60', 77, 53, 63),
(106,'$44', 123,54, 62),
(107,'$33', 798, 55, 61),
(108,'$25',100, 56, 63),
(109,'$32', 1000, 56, 63);

-- insert values in customer table

INSERT INTO `customer`(`Phone`, `Email`, `StreetAddress`, `ZipCode`, `Country` )
VALUES 
('7873734730','an@gmail.com','324 south main','80521','USA'),
('2324345454','ch@gmail.com','234 north street','80521','USA'),
('4556566779','cj@gmail.com','4354 horsebend street','80252','USA'),
('6768686868','sf@gmail.com','902 downtown street','82525','USA'),
('687868686','bl@yahoo.com', '123 warster street','80534', 'USA'),
('8989544453', 'fl@aol.com', '67 main street','80537','USA'),
('3525657688', 'js@gmail.com','9802 mall street','80615','USA'),
('5453524241','th@yahoo.com','7873 lincon street','80343','USA'),
('4564543434','mm@gmail.com', '9484 placemarket street','80537', 'USA'),
('343433453','gp@yahoo.com', '232 hotel avenue','80537', 'USA'),
('907342442','sm@yahoo.com', '282 hall street', '80615','USA' ),
('9089929292','suraezj@gmail.com','252 monument street','80650','USA'),
('2424436567','liquorP@gmail.com','342 shield street','80650','USA'),
('2345654578', 'bt@gamil.com','23 downtown road','80650','USA'),
('5553234654','vn@aol.com','123 hollster road','80650','USA');

-- insert values in  order table
INSERT INTO `order`(`Orderdate`, `PaymentCategory`, `CustomerID` )
VALUES 
(6/1/2017, 'Credit Card',10000),
(12/2/2008, 'Debit Card',10001),
(11/4/2015, 'Credit Card',10002),
(12/9/2015, 'Debit Card', 10003),
(12/9/2013,'Credit Card',10004),
(12/5/2014, 'Credit Card', 10005),
(11/3/2014,'Check', 10006),
(11/6/2018, 'Debit Card',10007),
(12/5/2018,'Check',10008),
(10/7/2014,'Credit Card',10009),
(2/5/2018,'Debit Card',10010),
(3/4/2014,'Check', 10011),
(1/11/2015,'Credit Card',10012),
(11/2/2017, 'Credit Card',10013),
(12/3/2017,'Credit Card',10014);

-- insert values in order line item table
INSERT INTO `OrderLineItem`(`ProductID`, `OrderID`,`Quantity`)
VALUES (100,50000,'20'),
(101,50000,'12'),
(102,50001,'14'),
(103,50002,'300'),
(104,50003,'200'),
(105,50004,'2000'),
(106,50005,'13'),
(109,50005,'200'),
(108,50006,'1300'),
(101,50007,'11'),
(103,50008,'111'),
(104,50009,'113'),
(103,50010,'2232'),
(109,50011,'500'),
(107,50012,'765'),
(104,50013,'1311'),
(107,50014,'1214');

-- insert values in individual customer 
INSERT INTO `IndividualCustomer`(`CustomerID` , `FirstName`, `LastName`,`DOB` )
VALUES (1000,'Ashley', 'Newton', 12/3/1975),
(1001,'Chris', 'Hoss', 11/2/1989),
(1002, 'Chris', 'Jordan', 4/5/1991),
(1003,'Samuel', 'Francis', 12/2/1990),
(1004,'Booby','Lorenzo',11/3/1995),
(1005,'Frank', 'Lamb',10/4/1990),
(1006,'John', 'Smith', 3/9/1989),
(1007,'Tom','Hall',12/11/1990),
(1008,'Mathew','Morris',3/10/1997),
(1009,'Gabriel','Pulisic',5/7/1989),
(1010,'Sayer','Mekret', 11/8/1978),
(1011,'Josua', 'Suarez',10/9/1977);

-- insert values in commercial customer
INSERT INTO `CommercialCustomer`(`CustomerID`, `Company_name`, `TaxID`)
VALUES (1012, 'Campus Liquor', '123490876'),
(1013,'Bar Treats','342458976'),
(1014,'Vegas Nights','232456783');



