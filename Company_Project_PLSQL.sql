-- Sys User
ALTER SESSION SET CONTAINER = Cdb$Root;
--
CREATE PLUGGABLE DATABASE Panos_Chron
ADMIN USER Panos_Chron_Admin IDENTIFIED BY Panos_Chron_Admin
ROLES = (DBA) DEFAULT TABLESPACE USERS
DATAFILE 'C:\app\panos\product\23ai\oradata\FREE\Panos_Chron\USERS01.DBF' SIZE 250M AUTOEXTEND ON
FILE_NAME_CONVERT = ('C:\app\panos\product\23ai\oradata\FREE\pdbseed\', 'C:\app\panos\product\23ai\oradata\FREE\Panos_Chron\');
--
SELECT Name, Open_Mode FROM V$Pdbs;
--
ALTER PLUGGABLE DATABASE Panos_Chron OPEN;
--
SELECT Name, Open_Mode FROM V$Pdbs;
--
ALTER SESSION SET CONTAINER = Panos_Chron;
--
GRANT UNLIMITED TABLESPACE TO Panos_Chron_Admin;
-- Panos_Chron_Admin User
ALTER SESSION SET CONTAINER = Panos_Chron;
--
CREATE USER Panos_Chron IDENTIFIED BY Panos_Chron;
--
CREATE USER Panos_Chron1 IDENTIFIED BY Panos_Chron1;
--
CREATE ROLE GrantRoles;
--
CREATE TABLE Companies
(
CompanyID NUMBER NOT NULL,
CompanyName VARCHAR2(50) NOT NULL,
CompanyNameXML XMLTYPE NOT NULL,
CompanyNameJSON CLOB NOT NULL,
CONSTRAINT CompanyID_PK PRIMARY KEY (CompanyID),
CONSTRAINT CompanyName_UNQ UNIQUE (CompanyName),
CONSTRAINT CompanyNameXML_CHK CHECK (CompanyNameXML IS NOT NULL),
CONSTRAINT CompanyNameJSON_CHK CHECK (JSON(CompanyNameJSON) = 1)
);
--
CREATE TABLE CompaniesLog
(
CompanyID NUMBER NOT NULL,
CompanyName VARCHAR2(50) NOT NULL,
DataManipulationLangugageStatement VARCHAR2(50) NOT NULL,
TrackOfTransactions TIMESTAMP DEFAULT SYSDATE,
CONSTRAINT DataManipulationLangugageStatement_CHK_Company CHECK (DataManipulationLangugageStatement IN ('Insert Statement', 'Update Statement', 'Delete Statement'))
);
--
CREATE OR REPLACE TRIGGER CompaniesDMLStatementsBefore BEFORE INSERT OR UPDATE OR DELETE 
ON Companies
FOR EACH ROW
BEGIN
IF INSERTING THEN
INSERT INTO CompaniesLog (CompanyID, CompanyName, DataManipulationLangugageStatement) VALUES (:NEW.CompanyID, :NEW.CompanyName, 'Insert Statement');
ELSIF UPDATING THEN
INSERT INTO CompaniesLog (CompanyID, CompanyName, DataManipulationLangugageStatement) VALUES (:OLD.CompanyID, :OLD.CompanyName, 'Update Statement');
ELSIF DELETING THEN
INSERT INTO CompaniesLog (CompanyID, CompanyName, DataManipulationLangugageStatement) VALUES (:OLD.CompanyID, :OLD.CompanyName, 'Delete Statement');
END IF;
END;
--
-- STOP EXECUTING
--
CREATE OR REPLACE TRIGGER CompaniesDMLStatementsAfter AFTER INSERT OR UPDATE OR DELETE 
ON Companies
FOR EACH ROW
BEGIN
IF INSERTING THEN
DBMS_OUTPUT.PUT_LINE('Insert was successfull.');
ELSIF UPDATING THEN
DBMS_OUTPUT.PUT_LINE('Update was successfull.');
ELSIF DELETING THEN
DBMS_OUTPUT.PUT_LINE('Delete was successfull.');
END IF;
END;
--
-- STOP EXECUTING
--
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (1, 'Amazon', '<CompanyName>Amazon</CompanyName>', '{"CompanyName": "Amazon"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (2, 'Google', '<CompanyName>Google</CompanyName>', '{"CompanyName": "Google"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (3, 'Microsoft', '<CompanyName>Microsoft</CompanyName>', '{"CompanyName": "Microsoft"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (4, 'Apple', '<CompanyName>Apple</CompanyName>', '{"CompanyName": "Apple"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (5, 'Facebook', '<CompanyName>Facebook</CompanyName>', '{"CompanyName": "Facebook"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (6, 'Twitter', '<CompanyName>Twitter</CompanyName>', '{"CompanyName": "Twitter"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (7, 'IBM', '<CompanyName>IBM</CompanyName>', '{"CompanyName": "IBM"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (8, 'Intel', '<CompanyName>Intel</CompanyName>', '{"CompanyName": "Intel"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (9, 'Oracle', '<CompanyName>Oracle</CompanyName>', '{"CompanyName": "Oracle"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (10, 'Tesla', '<CompanyName>Tesla</CompanyName>', '{"CompanyName": "Tesla"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (11, 'Samsung', '<CompanyName>Samsung</CompanyName>', '{"CompanyName": "Samsung"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (12, 'Sony', '<CompanyName>Sony</CompanyName>', '{"CompanyName": "Sony"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (13, 'Nvidia', '<CompanyName>Nvidia</CompanyName>', '{"CompanyName": "Nvidia"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (14, 'Adobe', '<CompanyName>Adope</CompanyName>', '{"CompanyName": "Adope"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (15, 'Salesforce', '<CompanyName>Salesforce</CompanyName>', '{"CompanyName": "Salesforce"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (16, 'Alibaba', '<CompanyName>Alibaba</CompanyName>', '{"CompanyName": "Alibaba"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (17, 'Zoom', '<CompanyName>Zoom</CompanyName>', '{"CompanyName": "Zoom"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (18, 'Slack', '<CompanyName>Slack</CompanyName>', '{"CompanyName": "Slack"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (19, 'Spotify', '<CompanyName>Spotify</CompanyName>', '{"CompanyName": "Spotify"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (20, 'PayPal', '<CompanyName>Paypal</CompanyName>', '{"CompanyName": "Paypal"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (21, 'Netflix', '<CompanyName>Netflix</CompanyName>', '{"CompanyName": "Netflix"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (22, 'eBay', '<CompanyName>eBay</CompanyName>', '{"CompanyName": "eBay"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (23, 'LinkedIn', '<CompanyName>LinkedIn</CompanyName>', '{"CompanyName": "LinkedIn"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (24, 'Uber', '<CompanyName>Uber</CompanyName>', '{"CompanyName": "Uber"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (25, 'Lyft', '<CompanyName>Lyft</CompanyName>', '{"CompanyName": "Lyft"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (26, 'Shopify', '<CompanyName>Shopify</CompanyName>', '{"CompanyName": "Shopify"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (27, 'Square', '<CompanyName>Square</CompanyName>', '{"CompanyName": "Square"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (28, 'Dropbox', '<CompanyName>Dropbox</CompanyName>', '{"CompanyName": "Dropbox"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (29, 'Pinterest', '<CompanyName>Pinterest</CompanyName>', '{"CompanyName": "Pinterest"}');
INSERT INTO Companies (CompanyID, CompanyName, CompanyNameXML, CompanyNameJSON) VALUES (30, 'Reddit', '<CompanyName>Reddit</CompanyName>', '{"CompanyName": "Reddit"}');
COMMIT;
--
SELECT * FROM Companies;
SELECT * FROM CompaniesLog;
--
UPDATE Companies SET CompanyID = 31 WHERE CompanyID = 1;
COMMIT;
--
SELECT * FROM Companies;
SELECT * FROM CompaniesLog;
--
DELETE FROM Companies WHERE CompanyID = 31;
COMMIT;
--
SELECT * FROM Companies;
SELECT * FROM CompaniesLog;
--
GRANT CREATE SESSION TO GrantRoles;
--
CREATE OR REPLACE VIEW MaskedCompanies AS SELECT CompanyID FROM Companies;
--
GRANT SELECT ON MaskedCompanies TO Panos_Chron WITH GRANT OPTION;
--
GRANT GrantRoles TO Panos_Chron, Panos_Chron1;
-- Panos_Chron User
ALTER SESSION SET CONTAINER = Panos_Chron;
--
SELECT * FROM Panos_Chron_Admin.MaskedCompanies;
--
GRANT SELECT ON Panos_Chron_Admin.MaskedCompanies TO Panos_Chron1;
-- Panos_Chron1 User
ALTER SESSION SET CONTAINER = Panos_Chron;
--
SELECT * FROM Panos_Chron_Admin.MaskedCompanies;
-- Panos_Chron_Admin User
ALTER SESSION SET CONTAINER = Panos_Chron;
--
CREATE TABLE Locations
(
LocationID NUMBER NOT NULL,
GeographicalLocation SDO_GEOMETRY NOT NULL,
CompanyID NUMBER NOT NULL,
CONSTRAINT LocationID_PK PRIMARY KEY (LocationID),
CONSTRAINT CompanyID_FK FOREIGN KEY (CompanyID) REFERENCES Companies (CompanyID) ON DELETE CASCADE
);
--
CREATE TABLE LocationsLog
(
LocationID NUMBER NOT NULL,
GeographicalLocation SDO_GEOMETRY NOT NULL,
CompanyID NUMBER NOT NULL,
DataManipulationLanguageStatement VARCHAR2(50) NOT NULL,
TrackOfTransactions TIMESTAMP DEFAULT SYSDATE,
CONSTRAINT DataManipulationLanguageStatement_CHK_Location CHECK (DataManipulationLanguageStatement IN ('Insert Statement', 'Update Statement', 'Delete Statement'))
);
--
CREATE OR REPLACE TRIGGER LocationsDMLStatementsBefore BEFORE INSERT OR UPDATE OR DELETE
ON Locations
FOR EACH ROW
BEGIN
IF INSERTING THEN
INSERT INTO LocationsLog (LocationID, GeographicalLocation, CompanyID, DataManipulationLanguageStatement) VALUES (:NEW.LocationID, :NEW.GeographicalLocation, :NEW.CompanyID, 'Insert Statement');
ELSIF UPDATING THEN
INSERT INTO LocationsLog (LocationID, GeographicalLocation, CompanyID, DataManipulationLanguageStatement) VALUES (:OLD.LocationID, :OLD.GeographicalLocation, :OLD.CompanyID, 'Update Statement');
ELSIF DELETING THEN
INSERT INTO LocationsLog (LocationID, GeographicalLocation, CompanyID, DataManipulationLanguageStatement) VALUES (:OLD.LocationID, :OLD.GeographicalLocation, :OLD.CompanyID, 'Delete Statement');
END IF;
END;
--
-- STOP EXECUTING
--
CREATE OR REPLACE TRIGGER LocationsDMLStatementsAfter AFTER INSERT OR UPDATE OR DELETE
ON Locations
FOR EACH ROW
BEGIN
IF INSERTING THEN
DBMS_OUTPUT.PUT_LINE('Insert was successfull.');
ELSIF UPDATING THEN
DBMS_OUTPUT.PUT_LINE('Update was successfull.');
ELSIF DELETING THEN
DBMS_OUTPUT.PUT_LINE('Delete was successfull.');
END IF;
END;
--
CREATE OR REPLACE TRIGGER OnUpdateCascadeCompanyID_FK AFTER UPDATE 
ON Companies
FOR EACH ROW
BEGIN
IF UPDATING THEN
UPDATE Locations SET CompanyID = :NEW.CompanyID WHERE CompanyID = :OLD.CompanyID;
DBMS_OUTPUT.PUT_LINE('Update was successfull.');
END IF;
END;
--
-- STOP EXECUTING
--
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (1, SDO_GEOMETRY (2001, NULL, SDO_POINT_TYPE(-122.3321, 47.6062, NULL), NULL, NULL), 1);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (2, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(-122.4194, 37.7749, NULL), NULL, NULL), 2);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (3, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(23.7275, 37.9838, NULL), NULL, NULL), 3);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (4, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(-122.0312, 37.3318, NULL), NULL, NULL), 4);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (5, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(-74.0060, 40.7128, NULL), NULL, NULL), 5);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (6, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(-0.1278, 51.5074, NULL), NULL, NULL), 6);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (7, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(139.6917, 35.6895, NULL), NULL, NULL), 7);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (8, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(2.3522, 48.8566, NULL), NULL, NULL), 8);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (9, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(-118.2437, 34.0522, NULL), NULL, NULL), 9);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (10, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(12.4964, 41.9028, NULL), NULL, NULL), 10);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (11, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(116.4074, 39.9042, NULL), NULL, NULL), 11);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (12, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(151.2093, -33.8688, NULL), NULL, NULL), 12);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (13, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(37.6173, 55.7558, NULL), NULL, NULL), 13);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (14, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(-104.9903, 39.7392, NULL), NULL, NULL), 14);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (15, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(-46.6333, -23.5505, NULL), NULL, NULL), 15);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (16, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(-73.9352, 40.7306, NULL), NULL, NULL), 16);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (17, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(-97.7431, 30.2672, NULL), NULL, NULL), 17);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (18, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(-86.7816, 36.1627, NULL), NULL, NULL), 18);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (19, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(-79.3470, 43.6510, NULL), NULL, NULL), 19);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (20, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(13.4050, 52.5200, NULL), NULL, NULL), 20);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (21, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(-3.1883, 55.9533, NULL), NULL, NULL), 21);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (22, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(24.9354, 60.1695, NULL), NULL, NULL), 22);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (23, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(10.4515, 51.1657, NULL), NULL, NULL), 23);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (24, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(139.6503, 35.6762, NULL), NULL, NULL), 24);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (25, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(-58.3816, -34.6037, NULL), NULL, NULL), 25);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (26, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(90.4125, 23.8103, NULL), NULL, NULL), 26);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (27, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(100.9925, 15.8700, NULL), NULL, NULL), 27);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (28, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(11.5820, 48.1351, NULL), NULL, NULL), 28);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (29, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(103.8198, 1.3521, NULL), NULL, NULL), 29);
INSERT INTO Locations (LocationID, GeographicalLocation, CompanyID) VALUES (30, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(116.4040, 39.9138, NULL), NULL, NULL), 30);
COMMIT;
--
SELECT * FROM Locations;
SELECT * FROM LocationsLog;
--
UPDATE Locations SET LocationID = 31 WHERE LocationID = 1;
COMMIT;
--
SELECT * FROM Locations;
SELECT * FROM LocationsLog;
--
DELETE FROM Locations WHERE LocationID = 31;
COMMIT;
--
SELECT * FROM Locations;
SELECT * FROM LocationsLog;
--
CREATE OR REPLACE VIEW MaskedLocations AS SELECT LocationID, CompanyID FROM Locations;
--
GRANT SELECT ON MaskedLocations TO Panos_Chron WITH GRANT OPTION;
-- Panos_Chron User
ALTER SESSION SET CONTAINER = Panos_Chron;
--
SELECT * FROM Panos_Chron_Admin.MaskedLocations;
--
GRANT SELECT ON Panos_Chron_Admin.MaskedLocations TO Panos_Chron1;
-- Panos_Chron1 User
ALTER SESSION SET CONTAINER = Panos_Chron;
--
SELECT * FROM Panos_Chron_Admin.MaskedLocations;
-- Panos_Chron_Admin User
ALTER SESSION SET CONTAINER = Panos_Chron;
--
CREATE TABLE Departments
(
DepartmentID NUMBER NOT NULL,
DepartmentName VARCHAR2(50) NOT NULL,
DepartmentLocation VARCHAR2(50) NOT NULL,
LocationID NUMBER NOT NULL,
DepartmentBudget NUMBER(7,2) NULL,
CONSTRAINT DepartmentID_PK PRIMARY KEY (DepartmentID),
CONSTRAINT DepartmentName_DepartmentLocation_UNQ UNIQUE (DepartmentName, DepartmentLocation),
CONSTRAINT LocationID_FK FOREIGN KEY (LocationID) REFERENCES Locations (LocationID) ON DELETE CASCADE,
CONSTRAINT DepartmentBudget_CHK CHECK (DepartmentBudget >= 10000.00 AND DepartmentBudget <= 50000.00)
);
--
CREATE TABLE DepartmentsLog
(
DepartmentID NUMBER NOT NULL,
DepartmentName VARCHAR2(50) NOT NULL,
DepartmentLocation VARCHAR2(50) NOT NULL,
LocationID NUMBER NOT NULL,
DataManipulationLanguageStatement VARCHAR2(50) NOT NULL,
TrackOfTransactions TIMESTAMP DEFAULT SYSDATE,
CONSTRAINT DataManipulationLanguageStatement_CHK_Department CHECK (DataManipulationLanguageStatement IN ('Insert Statement', 'Update Statement', 'Delete Statement')),
DepartmentOldBudget NUMBER(7,2) NULL,
DepartmentNewBudget NUMBER(7,2) NULL
);
--
CREATE OR REPLACE TRIGGER DepartmentsDMLStatementsBefore BEFORE INSERT OR UPDATE OR DELETE 
ON Departments
FOR EACH ROW
BEGIN
IF INSERTING THEN
INSERT INTO DepartmentsLog (DepartmentID, DepartmentName, DepartmentLocation, LocationID, DataManipulationLanguageStatement, DepartmentNewBudget) VALUES (:NEW.DepartmentID, :NEW.DepartmentName, :NEW.DepartmentLocation, :NEW.LocationID, 'Insert Statement', :NEW.DepartmentBudget);
ELSIF UPDATING THEN
INSERT INTO DepartmentsLog (DepartmentID, DepartmentName, DepartmentLocation, LocationID, DataManipulationLanguageStatement, DepartmentOldBudget, DepartmentNewBudget) VALUES (:NEW.DepartmentID, :NEW.DepartmentName, :NEW.DepartmentLocation, :NEW.LocationID, 'Update Statement', :OLD.DepartmentBudget, :NEW.DepartmentBudget);
ELSIF DELETING THEN
INSERT INTO DepartmentsLog (DepartmentID, DepartmentName, DepartmentLocation, LocationID, DataManipulationLanguageStatement) VALUES (:OLD.DepartmentID, :OLD.DepartmentName, :OLD.DepartmentLocation, :OLD.LocationID, 'Delete Statement');
END IF;
END;
--
-- STOP EXECUTING
--
CREATE OR REPLACE TRIGGER DepartmentsDMLStatementsAfter AFTER INSERT OR UPDATE OR DELETE
ON Departments
FOR EACH ROW
BEGIN
IF INSERTING THEN
DBMS_OUTPUT.PUT_LINE('Insert was successfull.');
ELSIF UPDATING THEN
DBMS_OUTPUT.PUT_LINE('Update was successfull.');
ELSIF DELETING THEN
DBMS_OUTPUT.PUT_LINE('Delete was successfull.');
END IF;
END;
--
CREATE OR REPLACE TRIGGER OnUpdateCascadeLocationID_FK AFTER UPDATE 
ON Locations
FOR EACH ROW
BEGIN
IF UPDATING THEN
UPDATE Departments SET LocationID = :NEW.LocationID WHERE LocationID = :OLD.LocationID;
DBMS_OUTPUT.PUT_LINE('Update was successfull.');
END IF;
END;
--
-- STOP EXECUTING
--
INSERT INTO Departments (DepartmentID, DepartmentName, DepartmentLocation, LocationID, DepartmentBudget) VALUES (1, 'Engineering', 'Seattle', 1, 30000.00);
INSERT INTO Departments (DepartmentID, DepartmentName, DepartmentLocation, LocationID, DepartmentBudget) VALUES (2, 'Marketing', 'San Francisco', 2, 25000.00);
INSERT INTO Departments (DepartmentID, DepartmentName, DepartmentLocation, LocationID, DepartmentBudget) VALUES (3, 'Product', 'Los Angeles', 3, 20000.00);
INSERT INTO Departments (DepartmentID, DepartmentName, DepartmentLocation, LocationID, DepartmentBudget) VALUES (4, 'Design', 'Cupertino', 4, 15000.00);
INSERT INTO Departments (DepartmentID, DepartmentName, DepartmentLocation, LocationID, DepartmentBudget) VALUES (5, 'HR', 'New York', 5, 18000.00);
INSERT INTO Departments (DepartmentID, DepartmentName, DepartmentLocation, LocationID, DepartmentBudget) VALUES (6, 'Sales', 'London', 6, 20000.00);
INSERT INTO Departments (DepartmentID, DepartmentName, DepartmentLocation, LocationID, DepartmentBudget) VALUES (7, 'Support', 'Tokyo', 7, 22000.00);
INSERT INTO Departments (DepartmentID, DepartmentName, DepartmentLocation, LocationID, DepartmentBudget) VALUES (8, 'Research', 'Paris', 8, 18000.00);
INSERT INTO Departments (DepartmentID, DepartmentName, DepartmentLocation, LocationID, DepartmentBudget) VALUES (9, 'Analytics', 'Berlin', 9, 17000.00);
INSERT INTO Departments (DepartmentID, DepartmentName, DepartmentLocation, LocationID, DepartmentBudget) VALUES (10, 'Finance', 'Rome', 10, 20000.00);
INSERT INTO Departments (DepartmentID, DepartmentName, DepartmentLocation, LocationID, DepartmentBudget) VALUES (11, 'Legal', 'Beijing', 11, 21000.00);
INSERT INTO Departments (DepartmentID, DepartmentName, DepartmentLocation, LocationID, DepartmentBudget) VALUES (12, 'Customer Service', 'Sydney', 12, 17000.00);
INSERT INTO Departments (DepartmentID, DepartmentName, DepartmentLocation, LocationID, DepartmentBudget) VALUES (13, 'Content', 'Moscow', 13, 18000.00);
INSERT INTO Departments (DepartmentID, DepartmentName, DepartmentLocation, LocationID, DepartmentBudget) VALUES (14, 'Public Relations', 'Denver', 14, 15000.00);
INSERT INTO Departments (DepartmentID, DepartmentName, DepartmentLocation, LocationID, DepartmentBudget) VALUES (15, 'Operations', 'São Paulo', 15, 25000.00);
INSERT INTO Departments (DepartmentID, DepartmentName, DepartmentLocation, LocationID, DepartmentBudget) VALUES (16, 'Procurement', 'Austin', 16, 22000.00);
INSERT INTO Departments (DepartmentID, DepartmentName, DepartmentLocation, LocationID, DepartmentBudget) VALUES (17, 'Quality Assurance', 'Nashville', 17, 20000.00);
INSERT INTO Departments (DepartmentID, DepartmentName, DepartmentLocation, LocationID, DepartmentBudget) VALUES (18, 'Logistics', 'Toronto', 18, 23000.00);
INSERT INTO Departments (DepartmentID, DepartmentName, DepartmentLocation, LocationID, DepartmentBudget) VALUES (19, 'Training', 'Montreal', 19, 18000.00);
INSERT INTO Departments (DepartmentID, DepartmentName, DepartmentLocation, LocationID, DepartmentBudget) VALUES (20, 'Strategy', 'Hamburg', 20, 25000.00);
INSERT INTO Departments (DepartmentID, DepartmentName, DepartmentLocation, LocationID, DepartmentBudget) VALUES (21, 'Compliance', 'Edinburgh', 21, 21000.00);
INSERT INTO Departments (DepartmentID, DepartmentName, DepartmentLocation, LocationID, DepartmentBudget) VALUES (22, 'Business Development', 'Helsinki', 22, 22000.00);
INSERT INTO Departments (DepartmentID, DepartmentName, DepartmentLocation, LocationID, DepartmentBudget) VALUES (23, 'Innovation', 'Berlin', 23, 23000.00);
INSERT INTO Departments (DepartmentID, DepartmentName, DepartmentLocation, LocationID, DepartmentBudget) VALUES (24, 'IT', 'Tokyo', 24, 24000.00);
INSERT INTO Departments (DepartmentID, DepartmentName, DepartmentLocation, LocationID, DepartmentBudget) VALUES (25, 'Facilities', 'Buenos Aires', 25, 22000.00);
INSERT INTO Departments (DepartmentID, DepartmentName, DepartmentLocation, LocationID, DepartmentBudget) VALUES (26, 'Business Intelligence', 'Dhaka', 26, 26000.00);
INSERT INTO Departments (DepartmentID, DepartmentName, DepartmentLocation, LocationID, DepartmentBudget) VALUES (27, 'User Experience', 'Bangkok', 27, 20000.00);
INSERT INTO Departments (DepartmentID, DepartmentName, DepartmentLocation, LocationID, DepartmentBudget) VALUES (28, 'Cybersecurity', 'Munich', 28, 28000.00);
INSERT INTO Departments (DepartmentID, DepartmentName, DepartmentLocation, LocationID, DepartmentBudget) VALUES (29, 'Data Science', 'Singapore', 29, 29000.00);
INSERT INTO Departments (DepartmentID, DepartmentName, DepartmentLocation, LocationID, DepartmentBudget) VALUES (30, 'System Administration', 'Beijing', 30, 30000.00);
COMMIT;
--
SELECT * FROM Departments;
SELECT * FROM DepartmentsLog;
--
UPDATE Departments SET DepartmentID = 31, DepartmentBudget = DepartmentBudget * 1.5 WHERE DepartmentID = 1;
COMMIT;
--
SELECT * FROM Departments;
SELECT * FROM DepartmentsLog;
--
DELETE FROM Departments WHERE DepartmentID = 31;
COMMIT;
--
SELECT * FROM Departments;
SELECT * FROM DepartmentsLog;
--
CREATE OR REPLACE VIEW MaskedDepartments AS SELECT DepartmentName, DepartmentLocation FROM Departments;
--
GRANT SELECT ON MaskedDepartments TO Panos_Chron WITH GRANT OPTION;
-- Panos_Chron User
ALTER SESSION SET CONTAINER = Panos_Chron;
--
SELECT * FROM Panos_Chron_Admin.MaskedDepartments;
--
GRANT SELECT ON Panos_Chron_Admin.MaskedDepartments TO Panos_Chron1;
-- Panos_Chron1 User
ALTER SESSION SET CONTAINER = Panos_Chron;
--
SELECT * FROM Panos_Chron_Admin.MaskedDepartments;
-- Panos_Chron_Admin User
ALTER SESSION SET CONTAINER = Panos_Chron;
--
CREATE TABLE Projects
(
ProjectID NUMBER NOT NULL, 
ProjectName VARCHAR2(50) NOT NULL,
ProjectBudget NUMBER(7,2) NOT NULL,
ProjectStartDate DATE NOT NULL,
ProjectEndDate DATE NOT NULL,
CONSTRAINT ProjectID_PK PRIMARY KEY (ProjectID),
CONSTRAINT ProjectName_UNQ UNIQUE (ProjectName),
CONSTRAINT ProjectBudget_CHK CHECK (ProjectBudget BETWEEN 5000.00 AND 15000.00),
CONSTRAINT ProjectStartDate_ProjectEndDate_CHK CHECK (ProjectStartDate >= TO_DATE('2015-01-01', 'YYYY-MM-DD') AND ProjectEndDate <= TO_DATE('2030-12-31', 'YYYY-MM-DD'))
);
--
CREATE TABLE ProjectsLog
(
ProjectID NUMBER NOT NULL,
ProjectName VARCHAR2(50) NOT NULL,
ProjectOldBudget NUMBER(7,2) NULL,
ProjectNewBudget NUMBER(7,2) NULL,
DataManipulationLanguageStatement VARCHAR2(50) NOT NULL,
TrackOfTransactions TIMESTAMP DEFAULT SYSDATE,
CONSTRAINT DataManipulationLanguageStatement_CHK_Project CHECK (DataManipulationLanguageStatement IN ('Insert Statement', 'Update Statement', 'Delete Statement'))
);
--
CREATE OR REPLACE TRIGGER ProjectsDMLStatementsBefore BEFORE INSERT OR UPDATE OR DELETE 
ON Projects
FOR EACH ROW
BEGIN
IF INSERTING THEN
INSERT INTO ProjectsLog (ProjectID, ProjectName, ProjectNewBudget, DataManipulationLanguageStatement) VALUES (:NEW.ProjectID, :NEW.ProjectName, :NEW.ProjectBudget, 'Insert Statement');
ELSIF UPDATING THEN
INSERT INTO ProjectsLog (ProjectID, ProjectName, ProjectOldBudget, ProjectNewBudget, DataManipulationLanguageStatement) VALUES (:NEW.ProjectID, :NEW.ProjectName, :OLD.ProjectBudget, :NEW.ProjectBudget, 'Update Statement');
ELSIF DELETING THEN
INSERT INTO ProjectsLog (ProjectID, ProjectName, DataManipulationLanguageStatement) VALUES (:OLD.ProjectID, :OLD.ProjectName, 'Delete Statement');
END IF;
END;
--
-- STOP EXECUTING
--
CREATE OR REPLACE TRIGGER ProjectsDMLStatementsAfter AFTER INSERT OR UPDATE OR DELETE
ON Projects
FOR EACH ROW
BEGIN
IF INSERTING THEN
DBMS_OUTPUT.PUT_LINE('Insert was successfull.');
ELSIF UPDATING THEN
DBMS_OUTPUT.PUT_LINE('Update was successfull.');
ELSIF DELETING THEN
DBMS_OUTPUT.PUT_LINE('Delete was successfull.');
END IF;
END;
--
-- STOP EXECUTING
--
INSERT INTO Projects (ProjectID, ProjectName, ProjectBudget, ProjectStartDate, ProjectEndDate) VALUES (1, 'Project Alpha', 10000.00, TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'));
INSERT INTO Projects (ProjectID, ProjectName, ProjectBudget, ProjectStartDate, ProjectEndDate) VALUES (2, 'Project Beta', 15000.00, TO_DATE('2023-02-01', 'YYYY-MM-DD'), TO_DATE('2023-11-30', 'YYYY-MM-DD'));
INSERT INTO Projects (ProjectID, ProjectName, ProjectBudget, ProjectStartDate, ProjectEndDate) VALUES (3, 'Project Gamma', 13000.00, TO_DATE('2023-01-15', 'YYYY-MM-DD'), TO_DATE('2023-11-15', 'YYYY-MM-DD'));
INSERT INTO Projects (ProjectID, ProjectName, ProjectBudget, ProjectStartDate, ProjectEndDate) VALUES (4, 'Project Delta', 12000.00, TO_DATE('2023-03-01', 'YYYY-MM-DD'), TO_DATE('2023-10-01', 'YYYY-MM-DD'));
INSERT INTO Projects (ProjectID, ProjectName, ProjectBudget, ProjectStartDate, ProjectEndDate) VALUES (5, 'Project Epsilon', 14000.00, TO_DATE('2023-04-01', 'YYYY-MM-DD'), TO_DATE('2023-09-01', 'YYYY-MM-DD'));
INSERT INTO Projects (ProjectID, ProjectName, ProjectBudget, ProjectStartDate, ProjectEndDate) VALUES (6, 'Project Zeta', 11000.00, TO_DATE('2023-05-01', 'YYYY-MM-DD'), TO_DATE('2023-10-15', 'YYYY-MM-DD'));
INSERT INTO Projects (ProjectID, ProjectName, ProjectBudget, ProjectStartDate, ProjectEndDate) VALUES (7, 'Project Eta', 15000.00, TO_DATE('2023-06-01', 'YYYY-MM-DD'), TO_DATE('2023-08-15', 'YYYY-MM-DD'));
INSERT INTO Projects (ProjectID, ProjectName, ProjectBudget, ProjectStartDate, ProjectEndDate) VALUES (8, 'Project Theta', 8000.00, TO_DATE('2023-07-01', 'YYYY-MM-DD'), TO_DATE('2023-12-01', 'YYYY-MM-DD'));
INSERT INTO Projects (ProjectID, ProjectName, ProjectBudget, ProjectStartDate, ProjectEndDate) VALUES (9, 'Project Iota', 9000.00, TO_DATE('2023-08-01', 'YYYY-MM-DD'), TO_DATE('2023-10-30', 'YYYY-MM-DD'));
INSERT INTO Projects (ProjectID, ProjectName, ProjectBudget, ProjectStartDate, ProjectEndDate) VALUES (10, 'Project Kappa', 7500.00, TO_DATE('2023-09-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'));
INSERT INTO Projects (ProjectID, ProjectName, ProjectBudget, ProjectStartDate, ProjectEndDate) VALUES (11, 'Project Lambda', 7000.00, TO_DATE('2023-10-01', 'YYYY-MM-DD'), TO_DATE('2023-11-15', 'YYYY-MM-DD'));
INSERT INTO Projects (ProjectID, ProjectName, ProjectBudget, ProjectStartDate, ProjectEndDate) VALUES (12, 'Project Mu', 6800.00, TO_DATE('2023-01-10', 'YYYY-MM-DD'), TO_DATE('2023-05-05', 'YYYY-MM-DD'));
INSERT INTO Projects (ProjectID, ProjectName, ProjectBudget, ProjectStartDate, ProjectEndDate) VALUES (13, 'Project Nu', 13000.00, TO_DATE('2023-11-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'));
INSERT INTO Projects (ProjectID, ProjectName, ProjectBudget, ProjectStartDate, ProjectEndDate) VALUES (14, 'Project Xi', 5000.00, TO_DATE('2023-03-15', 'YYYY-MM-DD'), TO_DATE('2023-06-30', 'YYYY-MM-DD'));
INSERT INTO Projects (ProjectID, ProjectName, ProjectBudget, ProjectStartDate, ProjectEndDate) VALUES (15, 'Project Omicron', 8500.00, TO_DATE('2023-06-15', 'YYYY-MM-DD'), TO_DATE('2023-12-15', 'YYYY-MM-DD'));
INSERT INTO Projects (ProjectID, ProjectName, ProjectBudget, ProjectStartDate, ProjectEndDate) VALUES (16, 'Project Pi', 12500.00, TO_DATE('2023-07-10', 'YYYY-MM-DD'), TO_DATE('2023-11-01', 'YYYY-MM-DD'));
INSERT INTO Projects (ProjectID, ProjectName, ProjectBudget, ProjectStartDate, ProjectEndDate) VALUES (17, 'Project Rho', 6000.00, TO_DATE('2023-08-01', 'YYYY-MM-DD'), TO_DATE('2023-09-01', 'YYYY-MM-DD'));
INSERT INTO Projects (ProjectID, ProjectName, ProjectBudget, ProjectStartDate, ProjectEndDate) VALUES (18, 'Project Sigma', 15000.00, TO_DATE('2023-09-10', 'YYYY-MM-DD'), TO_DATE('2023-12-20', 'YYYY-MM-DD'));
INSERT INTO Projects (ProjectID, ProjectName, ProjectBudget, ProjectStartDate, ProjectEndDate) VALUES (19, 'Project Tau', 9200.00, TO_DATE('2023-01-20', 'YYYY-MM-DD'), TO_DATE('2023-06-20', 'YYYY-MM-DD'));
INSERT INTO Projects (ProjectID, ProjectName, ProjectBudget, ProjectStartDate, ProjectEndDate) VALUES (20, 'Project Upsilon', 11900.00, TO_DATE('2023-02-15', 'YYYY-MM-DD'), TO_DATE('2023-10-15', 'YYYY-MM-DD'));
INSERT INTO Projects (ProjectID, ProjectName, ProjectBudget, ProjectStartDate, ProjectEndDate) VALUES (21, 'Project Phi', 14000.00, TO_DATE('2023-03-30', 'YYYY-MM-DD'), TO_DATE('2023-10-30', 'YYYY-MM-DD'));
INSERT INTO Projects (ProjectID, ProjectName, ProjectBudget, ProjectStartDate, ProjectEndDate) VALUES (22, 'Project Chi', 12000.00, TO_DATE('2023-04-22', 'YYYY-MM-DD'), TO_DATE('2023-09-15', 'YYYY-MM-DD'));
INSERT INTO Projects (ProjectID, ProjectName, ProjectBudget, ProjectStartDate, ProjectEndDate) VALUES (23, 'Project Psi', 7500.00, TO_DATE('2023-05-17', 'YYYY-MM-DD'), TO_DATE('2023-11-05', 'YYYY-MM-DD'));
INSERT INTO Projects (ProjectID, ProjectName, ProjectBudget, ProjectStartDate, ProjectEndDate) VALUES (24, 'Project Omega', 11000.00, TO_DATE('2023-06-10', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'));
INSERT INTO Projects (ProjectID, ProjectName, ProjectBudget, ProjectStartDate, ProjectEndDate) VALUES (25, 'Project A1', 13500.00, TO_DATE('2023-07-15', 'YYYY-MM-DD'), TO_DATE('2023-12-01', 'YYYY-MM-DD'));
INSERT INTO Projects (ProjectID, ProjectName, ProjectBudget, ProjectStartDate, ProjectEndDate) VALUES (26, 'Project B1', 9500.00, TO_DATE('2023-08-08', 'YYYY-MM-DD'), TO_DATE('2023-10-20', 'YYYY-MM-DD'));
INSERT INTO Projects (ProjectID, ProjectName, ProjectBudget, ProjectStartDate, ProjectEndDate) VALUES (27, 'Project C1', 8300.00, TO_DATE('2023-09-12', 'YYYY-MM-DD'), TO_DATE('2023-12-10', 'YYYY-MM-DD'));
INSERT INTO Projects (ProjectID, ProjectName, ProjectBudget, ProjectStartDate, ProjectEndDate) VALUES (28, 'Project D1', 10200.00, TO_DATE('2023-10-02', 'YYYY-MM-DD'), TO_DATE('2023-11-30', 'YYYY-MM-DD'));
INSERT INTO Projects (ProjectID, ProjectName, ProjectBudget, ProjectStartDate, ProjectEndDate) VALUES (29, 'Project E1', 8900.00, TO_DATE('2023-11-25', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'));
INSERT INTO Projects (ProjectID, ProjectName, ProjectBudget, ProjectStartDate, ProjectEndDate) VALUES (30, 'Project F1', 12000.00, TO_DATE('2023-12-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'));
COMMIT;
--
SELECT * FROM Projects;
SELECT * FROM ProjectsLog;
--
UPDATE Projects SET ProjectID = 31, ProjectBudget = ProjectBudget - 5000.00 WHERE ProjectID = 1;
COMMIT;
--
SELECT * FROM Projects;
SELECT * FROM ProjectsLog;
--
DELETE FROM Projects WHERE ProjectID = 31;
COMMIT;
--
SELECT * FROM Projects;
SELECT * FROM ProjectsLog;
--
CREATE OR REPLACE VIEW MaskedProjects AS SELECT ProjectName FROM Projects;
--
GRANT SELECT ON MaskedProjects TO Panos_Chron WITH GRANT OPTION;
-- Panos_Chron User
ALTER SESSION SET CONTAINER = Panos_Chron;
--
SELECT * FROM Panos_Chron_Admin.MaskedProjects;
--
GRANT SELECT ON Panos_Chron_Admin.MaskedProjects TO Panos_Chron1;
-- Panos_Chron1 User
ALTER SESSION SET CONTAINER = Panos_Chron;
--
SELECT * FROM Panos_Chron_Admin.MaskedProjects;
-- Panos_Chron_Admin User
ALTER SESSION SET CONTAINER = Panos_Chron;
--
CREATE TABLE Employees
(
EmployeeID NUMBER NOT NULL, 
EmployeeFirstName VARCHAR2(50) NOT NULL,
EmployeeMiddleName VARCHAR2(50) DEFAULT '',
EmployeeLastName VARCHAR2(50) NOT NULL,
EmployeeSex VARCHAR2(50) NOT NULL,
EmployeeSalary NUMBER(7,2) NOT NULL,
EmployeeYearOfRecruitment DATE NOT NULL,
EmployeeLevelOfEducation VARCHAR2(50) NOT NULL,
EmployeeSpeciality VARCHAR2(50) NOT NULL,
EmployeeExperience VARCHAR2(50) NOT NULL,
EmployeeCountry VARCHAR2(50) NOT NULL,
EmployeeTown VARCHAR2(50) NOT NULL,
EmployeeAddress VARCHAR2(50) NOT NULL,
EmployeePhoneNumber VARCHAR2(50) NOT NULL,
EmployeeFamilySituation VARCHAR2(50) NOT NULL,
EmployeeNumberOfChildren NUMBER DEFAULT 0,
DepartmentID NUMBER NOT NULL,
ProjectID NUMBER NOT NULL,
CONSTRAINT EmployeeID_PK PRIMARY KEY (EmployeeID),
CONSTRAINT EmployeeFirstName_EmployeeLastName_UNQ UNIQUE (EmployeeFirstName, EmployeeLastName),
CONSTRAINT EmployeeSex_CHK CHECK (EmployeeSex IN ('Male', 'Female')),
CONSTRAINT EmployeeSalary_CHK CHECK (EmployeeSalary BETWEEN 1000.00 AND 10000.00),
CONSTRAINT EmployeeYearOfRecruitment_CHK CHECK (EmployeeYearOfRecruitment >= TO_DATE('2015-01-01', 'YYYY-MM-DD') AND EmployeeYearOfRecruitment <= TO_DATE('2030-12-31', 'YYYY-MM-DD')),
CONSTRAINT EmployeeLevelOfEducation_CHK CHECK (EmployeeLevelOfEducation IN ('Bachelor''s Degree', 'Master''s Degree', 'PhD')),
CONSTRAINT EmployeeSpeciality_CHK CHECK (EmployeeSpeciality IN ('Full Stack Developer', 'Front End Developer', 'Back End Developer', 'Data Analyst', 'Business Analyst', 'QA Engineer', 'HR Manager', 'DevOps Engineer', 'Data Engineer', 'Database Administrator', 'DevSecOps Engineer', 'Data Scientist', 'SQL Developer', 'PL/SQL Developer', 'Technical Support Engineer', 'Project Manager')),
CONSTRAINT EmployeeExperience_CHK CHECK (EmployeeExperience IN ('Intership', 'Entry Level', 'Associate', 'Mid-Senior Level','Director', 'Executive')),
CONSTRAINT EmployeePhoneNumber_CHK CHECK (LENGTH (EmployeePhoneNumber) = 10),
CONSTRAINT EmployeeNumberOfChildren_CHK CHECK (EmployeeNumberOfChildren >= 0),
CONSTRAINT EmployeeFamilySituation_CHK CHECK (EmployeeFamilySituation IN ('UnMarried', 'Married')),
CONSTRAINT DepartmentID_FK FOREIGN KEY (DepartmentID) REFERENCES Departments (DepartmentID) ON DELETE CASCADE,
CONSTRAINT ProjectID_FK FOREIGN KEY (ProjectID) REFERENCES Projects (ProjectID) ON DELETE CASCADE
);
--
CREATE TABLE EmployeesLog
(
EmployeeID NUMBER NOT NULL,
EmployeeFirstName VARCHAR2(50) NOT NULL,
EmployeeMiddleName VARCHAR2(50) DEFAULT '',
EmployeeLastName VARCHAR2(50) NOT NULL,
EmployeeOldSalary NUMBER(7,2) NULL,
EmployeeNewSalary NUMBER(7,2) NULL,
DepartmentID NUMBER NOT NULL,
ProjectID NUMBER NOT NULL,
DataManipulationLanguageStatement VARCHAR2(50) NOT NULL,
TrackOfTransactions TIMESTAMP DEFAULT SYSDATE,
CONSTRAINT DataManipulationLanguageStatement_CHK_Employee CHECK (DataManipulationLanguageStatement IN ('Insert Statement', 'Update Statement', 'Delete Statement'))
);
--
CREATE OR REPLACE TRIGGER EmployeesDMLStatementsBefore BEFORE INSERT OR UPDATE OR DELETE 
ON Employees
FOR EACH ROW
BEGIN
IF INSERTING THEN
INSERT INTO EmployeesLog (EmployeeID, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeNewSalary, DepartmentID, ProjectID, DataManipulationLanguageStatement) VALUES (:NEW.EmployeeID, :NEW.EmployeeFirstName, :NEW.EmployeeMiddleName, :NEW.EmployeeLastName, :NEW.EmployeeSalary, :NEW.DepartmentID, :NEW.ProjectID, 'Insert Statement');
ELSIF UPDATING THEN
INSERT INTO EmployeesLog (EmployeeID, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeOldSalary, EmployeeNewSalary, DepartmentID, ProjectID, DataManipulationLanguageStatement) VALUES (:NEW.EmployeeID, :NEW.EmployeeFirstName, :NEW.EmployeeMiddleName, :NEW.EmployeeLastName, :OLD.EmployeeSalary, :NEW.EmployeeSalary, :NEW.DepartmentID, :NEW.ProjectID, 'Update Statement');
ELSIF DELETING THEN
INSERT INTO EmployeesLog (EmployeeID, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, DepartmentID, ProjectID, DataManipulationLanguageStatement) VALUES (:OLD.EmployeeID, :OLD.EmployeeFirstName, :OLD.EmployeeMiddleName, :OLD.EmployeeLastName, :OLD.DepartmentID, :OLD.ProjectID, 'Delete Statement');
END IF;
END;
--
-- STOP EXECUTING
--
CREATE OR REPLACE TRIGGER EmployeesDMLStatementsAfter AFTER INSERT OR UPDATE OR DELETE
ON Employees
FOR EACH ROW
BEGIN
IF INSERTING THEN
DBMS_OUTPUT.PUT_LINE('Insert was successfull.');
ELSIF UPDATING THEN
DBMS_OUTPUT.PUT_LINE('Update was successfull.');
ELSIF DELETING THEN
DBMS_OUTPUT.PUT_LINE('Delete was successfull.');
END IF;
END;
--
CREATE OR REPLACE TRIGGER OnUpdateCascadeDepartmentID_FK AFTER UPDATE 
ON Departments
FOR EACH ROW
BEGIN
IF UPDATING THEN
UPDATE Employees SET DepartmentID = :NEW.DepartmentID WHERE DepartmentID = :OLD.DepartmentID;
DBMS_OUTPUT.PUT_LINE('Update was successfull.');
END IF;
END;
--
CREATE OR REPLACE TRIGGER OnUpdateCascadeProjectID_FK AFTER UPDATE 
ON Projects
FOR EACH ROW
BEGIN
IF UPDATING THEN
UPDATE Employees SET ProjectID = :NEW.ProjectID WHERE ProjectID = :OLD.ProjectID;
DBMS_OUTPUT.PUT_LINE('Update was successfull.');
END IF;
END;
--
-- STOP EXECUTING
--
INSERT INTO Employees (EmployeeID, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeSex, EmployeeSalary, EmployeeYearOfRecruitment, EmployeeLevelOfEducation, EmployeeSpeciality, EmployeeExperience, EmployeeCountry, EmployeeTown, EmployeeAddress, EmployeePhoneNumber, EmployeeFamilySituation, EmployeeNumberOfChildren, DepartmentID, ProjectID) VALUES (1, 'John', 'A.', 'Doe', 'Male', 5000.00, TO_DATE('2020-01-15', 'YYYY-MM-DD'), 'Bachelor''s Degree', 'Full Stack Developer', 'Entry Level', 'USA', 'Seattle', '123 Elm St', '1234567890', 'Married', 0, 1, 1);
INSERT INTO Employees (EmployeeID, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeSex, EmployeeSalary, EmployeeYearOfRecruitment, EmployeeLevelOfEducation, EmployeeSpeciality, EmployeeExperience, EmployeeCountry, EmployeeTown, EmployeeAddress, EmployeePhoneNumber, EmployeeFamilySituation, EmployeeNumberOfChildren, DepartmentID, ProjectID) VALUES (2, 'Jane', 'B.', 'Smith', 'Female', 6000.00, TO_DATE('2019-02-16', 'YYYY-MM-DD'), 'Master''s Degree', 'Data Analyst', 'Associate', 'USA', 'San Francisco', '456 Oak St', '2345678901', 'Married', 0, 2, 2);
INSERT INTO Employees (EmployeeID, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeSex, EmployeeSalary, EmployeeYearOfRecruitment, EmployeeLevelOfEducation, EmployeeSpeciality, EmployeeExperience, EmployeeCountry, EmployeeTown, EmployeeAddress, EmployeePhoneNumber, EmployeeFamilySituation, EmployeeNumberOfChildren, DepartmentID, ProjectID) VALUES (3, 'Chris', 'C.', 'Johnson', 'Male', 4000.00, TO_DATE('2021-03-14', 'YYYY-MM-DD'), 'Bachelor''s Degree', 'Business Analyst', 'Mid-Senior Level', 'USA', 'Los Angeles', '789 Pine St', '3456789012', 'UnMarried', 0, 3, 3);
INSERT INTO Employees (EmployeeID, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeSex, EmployeeSalary, EmployeeYearOfRecruitment, EmployeeLevelOfEducation, EmployeeSpeciality, EmployeeExperience, EmployeeCountry, EmployeeTown, EmployeeAddress, EmployeePhoneNumber, EmployeeFamilySituation, EmployeeNumberOfChildren, DepartmentID, ProjectID) VALUES (4, 'Emily', 'D.', 'Williams', 'Female', 7000.00, TO_DATE('2018-04-18', 'YYYY-MM-DD'), 'PhD', 'Data Scientist', 'Director', 'USA', 'Cupertino', '321 Birch St', '4567890123', 'Married', 1, 2, 4);
INSERT INTO Employees (EmployeeID, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeSex, EmployeeSalary, EmployeeYearOfRecruitment, EmployeeLevelOfEducation, EmployeeSpeciality, EmployeeExperience, EmployeeCountry, EmployeeTown, EmployeeAddress, EmployeePhoneNumber, EmployeeFamilySituation, EmployeeNumberOfChildren, DepartmentID, ProjectID) VALUES (5, 'Michael', 'E.', 'Brown', 'Male', 8500.00, TO_DATE('2020-07-01', 'YYYY-MM-DD'), 'Master''s Degree', 'Project Manager', 'Mid-Senior Level', 'USA', 'New York', '654 Cedar St', '5678901234', 'Married', 2, 3, 5);
INSERT INTO Employees (EmployeeID, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeSex, EmployeeSalary, EmployeeYearOfRecruitment, EmployeeLevelOfEducation, EmployeeSpeciality, EmployeeExperience, EmployeeCountry, EmployeeTown, EmployeeAddress, EmployeePhoneNumber, EmployeeFamilySituation, EmployeeNumberOfChildren, DepartmentID, ProjectID) VALUES (6, 'Jessica', 'F.', 'Jones', 'Female', 7500.00, TO_DATE('2017-10-11', 'YYYY-MM-DD'), 'Master''s Degree', 'QA Engineer', 'Associate', 'USA', 'London', '987 Spruce St', '6789012345', 'UnMarried', 0, 6, 6);
INSERT INTO Employees (EmployeeID, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeSex, EmployeeSalary, EmployeeYearOfRecruitment, EmployeeLevelOfEducation, EmployeeSpeciality, EmployeeExperience, EmployeeCountry, EmployeeTown, EmployeeAddress, EmployeePhoneNumber, EmployeeFamilySituation, EmployeeNumberOfChildren, DepartmentID, ProjectID) VALUES (7, 'Matthew', 'G.', 'Miller', 'Male', 9000.00, TO_DATE('2016-09-25', 'YYYY-MM-DD'), 'PhD', 'DevOps Engineer', 'Executive', 'USA', 'Tokyo', '135 Maple St', '7890123456', 'Married', 3, 4, 7);
INSERT INTO Employees (EmployeeID, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeSex, EmployeeSalary, EmployeeYearOfRecruitment, EmployeeLevelOfEducation, EmployeeSpeciality, EmployeeExperience, EmployeeCountry, EmployeeTown, EmployeeAddress, EmployeePhoneNumber, EmployeeFamilySituation, EmployeeNumberOfChildren, DepartmentID, ProjectID) VALUES (8, 'Sarah', 'H.', 'Davis', 'Female', 5600.00, TO_DATE('2019-01-04', 'YYYY-MM-DD'), 'Bachelor''s Degree', 'Front End Developer', 'Entry Level', 'USA', 'Paris', '246 Fir St', '8901234567', 'UnMarried', 0, 8, 8);
INSERT INTO Employees (EmployeeID, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeSex, EmployeeSalary, EmployeeYearOfRecruitment, EmployeeLevelOfEducation, EmployeeSpeciality, EmployeeExperience, EmployeeCountry, EmployeeTown, EmployeeAddress, EmployeePhoneNumber, EmployeeFamilySituation, EmployeeNumberOfChildren, DepartmentID, ProjectID) VALUES (9, 'David', 'I.', 'Garcia', 'Male', 4200.00, TO_DATE('2020-02-17', 'YYYY-MM-DD'), 'Bachelor''s Degree', 'Back End Developer', 'Mid-Senior Level', 'USA', 'Berlin', '357 Elm St', '9012345678', 'Married', 4, 1, 9);
INSERT INTO Employees (EmployeeID, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeSex, EmployeeSalary, EmployeeYearOfRecruitment, EmployeeLevelOfEducation, EmployeeSpeciality, EmployeeExperience, EmployeeCountry, EmployeeTown, EmployeeAddress, EmployeePhoneNumber, EmployeeFamilySituation, EmployeeNumberOfChildren, DepartmentID, ProjectID) VALUES (10, 'Emily', 'J.', 'Martinez', 'Female', 7500.00, TO_DATE('2020-08-05', 'YYYY-MM-DD'), 'Bachelor''s Degree', 'Full Stack Developer', 'Mid-Senior Level', 'USA', 'Rome', '147 Walnut St', '0123456789', 'UnMarried', 0, 10, 10);
INSERT INTO Employees (EmployeeID, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeSex, EmployeeSalary, EmployeeYearOfRecruitment, EmployeeLevelOfEducation, EmployeeSpeciality, EmployeeExperience, EmployeeCountry, EmployeeTown, EmployeeAddress, EmployeePhoneNumber, EmployeeFamilySituation, EmployeeNumberOfChildren, DepartmentID, ProjectID) VALUES (11, 'Kevin', 'K.', 'Hernandez', 'Male', 6800.00, TO_DATE('2021-10-09', 'YYYY-MM-DD'), 'PhD', 'Data Engineer', 'Associate', 'USA', 'Beijing', '258 Chestnut St', '2345678905', 'Married', 1, 1, 11);
INSERT INTO Employees (EmployeeID, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeSex, EmployeeSalary, EmployeeYearOfRecruitment, EmployeeLevelOfEducation, EmployeeSpeciality, EmployeeExperience, EmployeeCountry, EmployeeTown, EmployeeAddress, EmployeePhoneNumber, EmployeeFamilySituation, EmployeeNumberOfChildren, DepartmentID, ProjectID) VALUES (12, 'Nancy', 'L.', 'Lee', 'Female', 5200.00, TO_DATE('2019-02-14', 'YYYY-MM-DD'), 'Master''s Degree', 'Database Administrator', 'Mid-Senior Level', 'Canada', 'Toronto', '369 Ash St', '3456789010', 'Married', 5, 3, 12);
INSERT INTO Employees (EmployeeID, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeSex, EmployeeSalary, EmployeeYearOfRecruitment, EmployeeLevelOfEducation, EmployeeSpeciality, EmployeeExperience, EmployeeCountry, EmployeeTown, EmployeeAddress, EmployeePhoneNumber, EmployeeFamilySituation, EmployeeNumberOfChildren, DepartmentID, ProjectID) VALUES (13, 'George', 'M.', 'Wilson', 'Male', 9300.00, TO_DATE('2020-06-12', 'YYYY-MM-DD'), 'PhD', 'Technical Support Engineer', 'Director', 'UK', 'London', '987 Cypress St', '4321098765', 'Married', 1, 2, 13);
INSERT INTO Employees (EmployeeID, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeSex, EmployeeSalary, EmployeeYearOfRecruitment, EmployeeLevelOfEducation, EmployeeSpeciality, EmployeeExperience, EmployeeCountry, EmployeeTown, EmployeeAddress, EmployeePhoneNumber, EmployeeFamilySituation, EmployeeNumberOfChildren, DepartmentID, ProjectID) VALUES (14, 'Betty', 'N.', 'Anderson', 'Female', 4600.00, TO_DATE('2021-07-30', 'YYYY-MM-DD'), 'Bachelor''s Degree', 'HR Manager', 'Entry Level', 'Canada', 'Montreal', '123 Spruce St', '5432109876', 'Married', 0, 1, 14);
INSERT INTO Employees (EmployeeID, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeSex, EmployeeSalary, EmployeeYearOfRecruitment, EmployeeLevelOfEducation, EmployeeSpeciality, EmployeeExperience, EmployeeCountry, EmployeeTown, EmployeeAddress, EmployeePhoneNumber, EmployeeFamilySituation, EmployeeNumberOfChildren, DepartmentID, ProjectID) VALUES (15, 'Angela', 'O.', 'Thomas', 'Female', 4700.00, TO_DATE('2022-01-15', 'YYYY-MM-DD'), 'Master''s Degree', 'Data Scientist', 'Associate', 'USA', 'Chicago', '654 River St', '8642097531', 'Married', 0, 15, 15);
INSERT INTO Employees (EmployeeID, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeSex, EmployeeSalary, EmployeeYearOfRecruitment, EmployeeLevelOfEducation, EmployeeSpeciality, EmployeeExperience, EmployeeCountry, EmployeeTown, EmployeeAddress, EmployeePhoneNumber, EmployeeFamilySituation, EmployeeNumberOfChildren, DepartmentID, ProjectID) VALUES (16, 'Austin', 'P.', 'Martin', 'Male', 5800.00, TO_DATE('2023-01-05', 'YYYY-MM-DD'), 'Bachelor''s Degree', 'DevSecOps Engineer', 'Entry Level', 'USA', 'San Diego', '456 Sunset Blvd', '6812465790', 'UnMarried', 0, 16, 16);
INSERT INTO Employees (EmployeeID, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeSex, EmployeeSalary, EmployeeYearOfRecruitment, EmployeeLevelOfEducation, EmployeeSpeciality, EmployeeExperience, EmployeeCountry, EmployeeTown, EmployeeAddress, EmployeePhoneNumber, EmployeeFamilySituation, EmployeeNumberOfChildren, DepartmentID, ProjectID) VALUES (17, 'Laura', 'Q.', 'Young', 'Female', 4000.00, TO_DATE('2021-03-12', 'YYYY-MM-DD'), 'Master''s Degree', 'Database Administrator', 'Mid-Senior Level', 'Canada', 'Victoria', '129 Pacific St', '7984561230', 'Married', 2, 2, 17);
INSERT INTO Employees (EmployeeID, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeSex, EmployeeSalary, EmployeeYearOfRecruitment, EmployeeLevelOfEducation, EmployeeSpeciality, EmployeeExperience, EmployeeCountry, EmployeeTown, EmployeeAddress, EmployeePhoneNumber, EmployeeFamilySituation, EmployeeNumberOfChildren, DepartmentID, ProjectID) VALUES (18, 'David', 'B.', 'Wright', 'Male', 8800.00, TO_DATE('2022-05-19', 'YYYY-MM-DD'), 'PhD', 'QA Engineer', 'Director', 'UK', 'Birmingham', '318 Queen St', '5672348910', 'UnMarried', 0, 18, 18);
INSERT INTO Employees (EmployeeID, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeSex, EmployeeSalary, EmployeeYearOfRecruitment, EmployeeLevelOfEducation, EmployeeSpeciality, EmployeeExperience, EmployeeCountry, EmployeeTown, EmployeeAddress, EmployeePhoneNumber, EmployeeFamilySituation, EmployeeNumberOfChildren, DepartmentID, ProjectID) VALUES (19, 'Clara', 'C.', 'Scott', 'Female', 9600.00, TO_DATE('2021-10-30', 'YYYY-MM-DD'), 'Master''s Degree', 'HR Manager', 'Executive', 'Canada', 'Montreal', '113 Thames St', '8901234567', 'UnMarried', 0, 19, 19);
INSERT INTO Employees (EmployeeID, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeSex, EmployeeSalary, EmployeeYearOfRecruitment, EmployeeLevelOfEducation, EmployeeSpeciality, EmployeeExperience, EmployeeCountry, EmployeeTown, EmployeeAddress, EmployeePhoneNumber, EmployeeFamilySituation, EmployeeNumberOfChildren, DepartmentID, ProjectID) VALUES (20, 'Robert', 'R.', 'Johnson', 'Male', 6300.00, TO_DATE('2021-11-22', 'YYYY-MM-DD'), 'Bachelor''s Degree', 'Front End Developer', 'Mid-Senior Level', 'USA', 'Seattle', '222 Sunset Rd', '2345678902', 'Married', 3, 2, 20);
INSERT INTO Employees (EmployeeID, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeSex, EmployeeSalary, EmployeeYearOfRecruitment, EmployeeLevelOfEducation, EmployeeSpeciality, EmployeeExperience, EmployeeCountry, EmployeeTown, EmployeeAddress, EmployeePhoneNumber, EmployeeFamilySituation, EmployeeNumberOfChildren, DepartmentID, ProjectID) VALUES (21, 'Thomas', 'T.', 'Harris', 'Male', 7200.00, TO_DATE('2022-03-15', 'YYYY-MM-DD'), 'Master''s Degree', 'Data Analyst', 'Associate', 'UK', 'Manchester', '444 Oak St', '3456789019', 'UnMarried', 0, 21, 21);
INSERT INTO Employees (EmployeeID, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeSex, EmployeeSalary, EmployeeYearOfRecruitment, EmployeeLevelOfEducation, EmployeeSpeciality, EmployeeExperience, EmployeeCountry, EmployeeTown, EmployeeAddress, EmployeePhoneNumber, EmployeeFamilySituation, EmployeeNumberOfChildren, DepartmentID, ProjectID) VALUES (22, 'Danielle', 'S.', 'Clark', 'Female', 7900.00, TO_DATE('2021-04-09', 'YYYY-MM-DD'), 'PhD', 'Technical Support Engineer', 'Mid-Senior Level', 'Canada', 'Toronto', '555 Maple St', '7896780654', 'Married', 1, 1, 22);
INSERT INTO Employees (EmployeeID, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeSex, EmployeeSalary, EmployeeYearOfRecruitment, EmployeeLevelOfEducation, EmployeeSpeciality, EmployeeExperience, EmployeeCountry, EmployeeTown, EmployeeAddress, EmployeePhoneNumber, EmployeeFamilySituation, EmployeeNumberOfChildren, DepartmentID, ProjectID) VALUES (23, 'Steven', 'V.', 'Lee', 'Male', 6700.00, TO_DATE('2023-01-22', 'YYYY-MM-DD'), 'Master''s Degree', 'Database Administrator', 'Entry Level', 'USA', 'Philadelphia', '888 Pine St', '0123456788', 'UnMarried', 0, 23, 23);
INSERT INTO Employees (EmployeeID, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeSex, EmployeeSalary, EmployeeYearOfRecruitment, EmployeeLevelOfEducation, EmployeeSpeciality, EmployeeExperience, EmployeeCountry, EmployeeTown, EmployeeAddress, EmployeePhoneNumber, EmployeeFamilySituation, EmployeeNumberOfChildren, DepartmentID, ProjectID) VALUES (24, 'Laura', 'T.', 'Miller', 'Female', 9000.00, TO_DATE('2021-12-14', 'YYYY-MM-DD'), 'Master''s Degree', 'Full Stack Developer', 'Mid-Senior Level', 'Canada', 'Vancouver', '555 Cedar St', '7895432106', 'Married', 2, 1, 24);
INSERT INTO Employees (EmployeeID, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeSex, EmployeeSalary, EmployeeYearOfRecruitment, EmployeeLevelOfEducation, EmployeeSpeciality, EmployeeExperience, EmployeeCountry, EmployeeTown, EmployeeAddress, EmployeePhoneNumber, EmployeeFamilySituation, EmployeeNumberOfChildren, DepartmentID, ProjectID) VALUES (25, 'Adrian', 'U.', 'Walker', 'Male', 5100.00, TO_DATE('2022-02-10', 'YYYY-MM-DD'), 'Bachelor''s Degree', 'Front End Developer', 'Entry Level', 'USA', 'Austin', '666 Star St', '4567890123', 'UnMarried', 0, 25, 25);
INSERT INTO Employees (EmployeeID, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeSex, EmployeeSalary, EmployeeYearOfRecruitment, EmployeeLevelOfEducation, EmployeeSpeciality, EmployeeExperience, EmployeeCountry, EmployeeTown, EmployeeAddress, EmployeePhoneNumber, EmployeeFamilySituation, EmployeeNumberOfChildren, DepartmentID, ProjectID) VALUES (26, 'Zoe', 'W.', 'Martin', 'Female', 6200.00, TO_DATE('2018-01-07', 'YYYY-MM-DD'), 'Bachelor''s Degree', 'Back End Developer', 'Mid-Senior Level', 'USA', 'Houston', '333 River Rd', '6780123456', 'Married', 6, 1, 26);
INSERT INTO Employees (EmployeeID, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeSex, EmployeeSalary, EmployeeYearOfRecruitment, EmployeeLevelOfEducation, EmployeeSpeciality, EmployeeExperience, EmployeeCountry, EmployeeTown, EmployeeAddress, EmployeePhoneNumber, EmployeeFamilySituation, EmployeeNumberOfChildren, DepartmentID, ProjectID) VALUES (27, 'Henry', 'N.', 'Hall', 'Male', 6900.00, TO_DATE('2019-10-14', 'YYYY-MM-DD'), 'Master''s Degree', 'HR Manager', 'Executive', 'UK', 'Birmingham', '789 Mountain St', '6781234560', 'UnMarried', 0, 27, 27);
INSERT INTO Employees (EmployeeID, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeSex, EmployeeSalary, EmployeeYearOfRecruitment, EmployeeLevelOfEducation, EmployeeSpeciality, EmployeeExperience, EmployeeCountry, EmployeeTown, EmployeeAddress, EmployeePhoneNumber, EmployeeFamilySituation, EmployeeNumberOfChildren, DepartmentID, ProjectID) VALUES (28, 'Ella', 'O.', 'Stewart', 'Female', 7500.00, TO_DATE('2020-03-11', 'YYYY-MM-DD'), 'PhD', 'Data Scientist', 'Mid-Senior Level', 'Canada', 'Ottawa', '147 Lagoon Ave', '1456781346', 'Married', 3, 1, 28);
INSERT INTO Employees (EmployeeID, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeSex, EmployeeSalary, EmployeeYearOfRecruitment, EmployeeLevelOfEducation, EmployeeSpeciality, EmployeeExperience, EmployeeCountry, EmployeeTown, EmployeeAddress, EmployeePhoneNumber, EmployeeFamilySituation, EmployeeNumberOfChildren, DepartmentID, ProjectID) VALUES (29, 'Benjamin', 'Y.', 'James', 'Male', 9600.00, TO_DATE('2021-12-29', 'YYYY-MM-DD'), 'PhD', 'Project Manager', 'Director', 'USA', 'Phoenix', '222 Cascade Blvd', '7770912345', 'UnMarried', 0, 29, 29);
INSERT INTO Employees (EmployeeID, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeSex, EmployeeSalary, EmployeeYearOfRecruitment, EmployeeLevelOfEducation, EmployeeSpeciality, EmployeeExperience, EmployeeCountry, EmployeeTown, EmployeeAddress, EmployeePhoneNumber, EmployeeFamilySituation, EmployeeNumberOfChildren, DepartmentID, ProjectID) VALUES (30, 'Cheryl', 'Y.', 'Bennett', 'Female', 5300.00, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'Bachelor''s Degree', 'Project Manager', 'Associate', 'USA', 'Dallas', '543 Oak Hill Ave', '2340912228', 'Married', 0, 3, 30);
COMMIT;
--
SELECT * FROM Employees;
SELECT * FROM EmployeesLog;
--
UPDATE Employees SET EmployeeSalary = EmployeeSalary * 2 WHERE EmployeeID = 1;
COMMIT;
--
SELECT * FROM Employees;
SELECT * FROM EmployeesLog;
--
DELETE FROM Employees WHERE EmployeeID = 1;
COMMIT;
--
SELECT * FROM Employees;
SELECT * FROM EmployeesLog;
--
CREATE OR REPLACE VIEW MaskedEmployees AS SELECT EmployeeFirstName, EmployeeLastName FROM Employees;
--
GRANT SELECT ON MaskedEmployees TO Panos_Chron WITH GRANT OPTION;
-- Panos_Chron User
ALTER SESSION SET CONTAINER = Panos_Chron;
--
SELECT * FROM Panos_Chron_Admin.MaskedEmployees;
--
GRANT SELECT ON Panos_Chron_Admin.MaskedEmployees TO Panos_Chron1;
-- Panos_Chron1 User
ALTER SESSION SET CONTAINER = Panos_Chron;
--
SELECT * FROM Panos_Chron_Admin.MaskedEmployees;
--
------------------------------
------------------------------
------------------------------
------------------------------
------------------------------
-- Panos_Chron User
ALTER SESSION SET CONTAINER = Panos_Chron;
--
SELECT * FROM Panos_Chron_Admin.MaskedEmployees;
--
REVOKE SELECT ON Panos_Chron_Admin.MaskedEmployees FROM Panos_Chron1;
-- Panos_Chron1 User
ALTER SESSION SET CONTAINER = Panos_Chron;
--
SELECT * FROM Panos_Chron_Admin.MaskedEmployees;
-- Panos_Chron_Admin User
ALTER SESSION SET CONTAINER = Panos_Chron;
--
REVOKE SELECT ON MaskedEmployees FROM Panos_Chron;
--
DROP VIEW IF EXISTS MaskedEmployees;
--
DELETE FROM EmployeesLog;
COMMIT;
TRUNCATE TABLE EmployeesLog;
--
DELETE FROM Employees;
COMMIT;
TRUNCATE TABLE Employees;
--
ALTER TRIGGER OnUpdateCascadeProjectID_FK ENABLE;
ALTER TRIGGER OnUpdateCascadeProjectID_FK DISABLE;
DROP TRIGGER IF EXISTS OnUpdateCascadeProjectID_FK;
--
ALTER TRIGGER OnUpdateCascadeDepartmentID_FK ENABLE;
ALTER TRIGGER OnUpdateCascadeDepartmentID_FK DISABLE;
DROP TRIGGER IF EXISTS OnUpdateCascadeDepartmentID_FK;
--
ALTER TRIGGER EmployeesDMLStatementsAfter ENABLE;
ALTER TRIGGER EmployeesDMLStatementsAfter DISABLE;
DROP TRIGGER IF EXISTS EmployeesDMLStatementsAfter;
--
ALTER TRIGGER EmployeesDMLStatementsBefore ENABLE;
ALTER TRIGGER EmployeesDMLStatementsBefore DISABLE;
DROP TRIGGER IF EXISTS EmployeesDMLStatementsBefore;
--
ALTER TABLE EmployeesLog DROP CONSTRAINT DataManipulationLanguageStatement_CHK_Employee;
--
DROP TABLE IF EXISTS EmployeesLog;
--
ALTER TABLE Employees DROP CONSTRAINT ProjectID_FK;
--
ALTER TABLE Employees DROP CONSTRAINT DepartmentID_FK;
--
ALTER TABLE Employees DROP CONSTRAINT EmployeeFamilySituation_CHK;
--
ALTER TABLE Employees DROP CONSTRAINT EmployeeNumberOfChildren_CHK;
--
ALTER TABLE Employees DROP CONSTRAINT EmployeePhoneNumber_CHK;
--
ALTER TABLE Employees DROP CONSTRAINT EmployeeExperience_CHK;
--
ALTER TABLE Employees DROP CONSTRAINT EmployeeSpeciality_CHK;
--
ALTER TABLE Employees DROP CONSTRAINT EmployeeLevelOfEducation_CHK;
--
ALTER TABLE Employees DROP CONSTRAINT EmployeeYearOfRecruitment_CHK;
--
ALTER TABLE Employees DROP CONSTRAINT EmployeeSalary_CHK;
--
ALTER TABLE Employees DROP CONSTRAINT EmployeeSex_CHK;
--
ALTER TABLE Employees DROP CONSTRAINT EmployeeFirstName_EmployeeLastName_UNQ;
--
ALTER TABLE Employees DROP CONSTRAINT EmployeeID_PK;
--
DROP TABLE IF EXISTS Employees;
-- Panos_Chron User
ALTER SESSION SET CONTAINER = Panos_Chron;
--
SELECT * FROM Panos_Chron_Admin.MaskedProjects;
--
REVOKE SELECT ON Panos_Chron_Admin.MaskedProjects FROM Panos_Chron1;
-- Panos_Chron1 User
ALTER SESSION SET CONTAINER = Panos_Chron;
--
SELECT * FROM Panos_Chron_Admin.MaskedProjects;
-- Panos_Chron_Admin User
ALTER SESSION SET CONTAINER = Panos_Chron;
--
REVOKE SELECT ON MaskedProjects FROM Panos_Chron;
--
DROP VIEW IF EXISTS MaskedProjects;
--
DELETE FROM ProjectsLog;
COMMIT;
TRUNCATE TABLE ProjectsLog;
--
DELETE FROM Projects;
COMMIT;
TRUNCATE TABLE Projects;
--
ALTER TRIGGER ProjectsDMLStatementsAfter ENABLE;
ALTER TRIGGER ProjectsDMLStatementsAfter DISABLE;
DROP TRIGGER IF EXISTS ProjectsDMLStatementsAfter;
--
ALTER TRIGGER ProjectsDMLStatementsBefore ENABLE;
ALTER TRIGGER ProjectsDMLStatementsBefore DISABLE;
DROP TRIGGER IF EXISTS ProjectsDMLStatementsBefore;
--
ALTER TABLE ProjectsLog DROP CONSTRAINT DataManipulationLanguageStatement_CHK_Project;
--
DROP TABLE IF EXISTS ProjectsLog;
--
ALTER TABLE Projects DROP CONSTRAINT ProjectStartDate_ProjectEndDate_CHK;
--
ALTER TABLE Projects DROP CONSTRAINT ProjectBudget_CHK;
--
ALTER TABLE Projects DROP CONSTRAINT ProjectName_UNQ;
--
ALTER TABLE Projects DROP CONSTRAINT ProjectID_PK;
--
DROP TABLE IF EXISTS Projects;
-- Panos_Chron User
ALTER SESSION SET CONTAINER = Panos_Chron;
--
SELECT * FROM Panos_Chron_Admin.MaskedDepartments;
--
REVOKE SELECT ON Panos_Chron_Admin.MaskedDepartments FROM Panos_Chron1;
-- Panos_Chron1 User
ALTER SESSION SET CONTAINER = Panos_Chron;
--
SELECT * FROM Panos_Chron_Admin.MaskedDepartments;
-- Panos_Chron_Admin User
ALTER SESSION SET CONTAINER = Panos_Chron;
--
REVOKE SELECT ON MaskedDepartments FROM Panos_Chron;
--
DROP VIEW IF EXISTS MaskedDepartments;
--
DELETE FROM DepartmentsLog;
COMMIT;
TRUNCATE TABLE DepartmentsLog;
--
DELETE FROM Departments;
COMMIT;
TRUNCATE TABLE Departments;
-- 
ALTER TRIGGER OnUpdateCascadeLocationID_FK ENABLE;
ALTER TRIGGER OnUpdateCascadeLocationID_FK DISABLE;
DROP TRIGGER IF EXISTS OnUpdateCascadeLocationID_FK;
--
ALTER TRIGGER DepartmentsDMLStatementsAfter ENABLE;
ALTER TRIGGER DepartmentsDMLStatementsAfter DISABLE;
DROP TRIGGER IF EXISTS DepartmentsDMLStatementsAfter;
--
ALTER TRIGGER DepartmentsDMLStatementsBefore ENABLE;
ALTER TRIGGER DepartmentsDMLStatementsBefore DISABLE;
DROP TRIGGER IF EXISTS DepartmentsDMLStatementsBefore;
--
ALTER TABLE DepartmentsLog DROP CONSTRAINT DataManipulationLanguageStatement_CHK_Department;
--
DROP TABLE IF EXISTS DepartmentsLog;
--
ALTER TABLE Departments DROP CONSTRAINT DepartmentBudget_CHK;
--
ALTER TABLE Departments DROP CONSTRAINT LocationID_FK;
--
ALTER TABLE Departments DROP CONSTRAINT DepartmentName_DepartmentLocation_UNQ;
--
ALTER TABLE Departments DROP CONSTRAINT DepartmentID_PK;
--
DROP TABLE IF EXISTS Departments; 
-- Panos_Chron User
ALTER SESSION SET CONTAINER = Panos_Chron;
--
SELECT * FROM Panos_Chron_Admin.MaskedLocations;
--
REVOKE SELECT ON Panos_Chron_Admin.MaskedLocations FROM Panos_Chron1;
-- Panos_Chron1 User
ALTER SESSION SET CONTAINER = Panos_Chron;
--
SELECT * FROM Panos_Chron_Admin.MaskedLocations;
-- Panos_Chron_Admin User
ALTER SESSION SET CONTAINER = Panos_Chron;
--
REVOKE SELECT ON MaskedLocations FROM Panos_Chron;
--
DROP VIEW IF EXISTS MaskedLocations;
--
DELETE FROM LocationsLog;
COMMIT;
TRUNCATE TABLE LocationsLog;
--
DELETE FROM Locations;
COMMIT;
TRUNCATE TABLE Locations;
--
ALTER TRIGGER OnUpdateCascadeCompanyID_FK ENABLE;
ALTER TRIGGER OnUpdateCascadeCompanyID_FK DISABLE;
DROP TRIGGER IF EXISTS OnUpdateCascadeCompanyID_FK;
--
ALTER TRIGGER LocationsDMLStatementsAfter ENABLE;
ALTER TRIGGER LocationsDMLStatementsAfter DISABLE;
DROP TRIGGER IF EXISTS LocationsDMLStatementsAfter;
--
ALTER TRIGGER LocationsDMLStatementsBefore ENABLE;
ALTER TRIGGER LocationsDMLStatementsBefore DISABLE;
DROP TRIGGER IF EXISTS LocationsDMLStatementsBefore;
--
ALTER TABLE LocationsLog DROP CONSTRAINT DataManipulationLanguageStatement_CHK_Location;
--
ALTER TABLE Locations DROP CONSTRAINT CompanyID_FK;
--
ALTER TABLE Locations DROP CONSTRAINT LocationID_PK;
--
DROP TABLE IF EXISTS LocationsLog;
--
DROP TABLE IF EXISTS Locations;
-- Panos_Chron User
ALTER SESSION SET CONTAINER = Panos_Chron;
--
SELECT * FROM Panos_Chron_Admin.MaskedCompanies;
--
REVOKE SELECT ON Panos_Chron_Admin.MaskedCompanies FROM Panos_Chron1;
-- Panos_Chron1 User
ALTER SESSION SET CONTAINER = Panos_Chron;
--
SELECT * FROM Panos_Chron_Admin.MaskedCompanies;
-- Panos_Chron_Admin User
ALTER SESSION SET CONTAINER = Panos_Chron;
--
REVOKE SELECT ON MaskedCompanies FROM Panos_Chron;
--
REVOKE GrantRoles FROM Panos_Chron1, Panos_Chron;
--
DROP VIEW IF EXISTS MaskedCompanies;
--
REVOKE CREATE SESSION FROM GrantRoles;
--
DELETE FROM CompaniesLog;
COMMIT;
TRUNCATE TABLE CompaniesLog;
-- 
DELETE FROM Companies;
COMMIT;
TRUNCATE TABLE Companies;
--
ALTER TRIGGER CompaniesDMLStatementsAfter ENABLE;
ALTER TRIGGER CompaniesDMLStatementsAfter DISABLE;
DROP TRIGGER IF EXISTS CompaniesDMLStatementsAfter;
--
ALTER TRIGGER CompaniesDMLStatementsBefore ENABLE;
ALTER TRIGGER CompaniesDMLStatementsBefore DISABLE;
DROP TRIGGER IF EXISTS CompaniesDMLStatementsBefore;
--
ALTER TABLE CompaniesLog DROP CONSTRAINT DataManipulationLangugageStatement_CHK_Company;
--
ALTER TABLE Companies DROP CONSTRAINT CompanyNameJSON_CHK;
--
ALTER TABLE Companies DROP CONSTRAINT CompanyNameXML_CHK;
--
ALTER TABLE Companies DROP CONSTRAINT CompanyName_UNQ;
--
ALTER TABLE Companies DROP CONSTRAINT CompanyID_PK;
--
DROP TABLE IF EXISTS CompaniesLog;
--
DROP TABLE IF EXISTS Companies;
--
DROP ROLE IF EXISTS GrantRoles;
--
DROP USER IF EXISTS Panos_Chron1 CASCADE;
--
DROP USER IF EXISTS Panos_Chron CASCADE;
-- Sys User
ALTER SESSION SET CONTAINER = Panos_Chron;
--
REVOKE UNLIMITED TABLESPACE FROM Panos_Chron_Admin;
--
ALTER SESSION SET CONTAINER = Cdb$Root;
--
ALTER PLUGGABLE DATABASE Panos_Chron CLOSE;
--
SELECT Name, Open_Mode FROM V$Pdbs;
--
DROP PLUGGABLE DATABASE Panos_Chron INCLUDING DATAFILES;
--
SELECT Name, Open_Mode FROM V$Pdbs;
--