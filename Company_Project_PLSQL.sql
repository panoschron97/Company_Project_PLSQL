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
UPDATE Projects SET ProjectID = 31 WHERE ProjectID = 1;
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
--
------------------------------
------------------------------
------------------------------
------------------------------
------------------------------
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


