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
CONSTRAINT CompanyID_PK PRIMARY KEY(CompanyID),
CONSTRAINT CompanyName_UNQ UNIQUE(CompanyName),
CONSTRAINT CompanyNameXML_CHK CHECK(CompanyNameXML IS NOT NULL),
CONSTRAINT CompanyNameJSON_CHK CHECK(JSON(CompanyNameJSON) = 1)
);
--
CREATE TABLE CompaniesLog
(
CompanyID NUMBER NOT NULL,
CompanyName VARCHAR2(50) NOT NULL,
DataManipulationLangugageStatement VARCHAR2(50) NOT NULL,
TrackOfTransactions TIMESTAMP DEFAULT SYSDATE,
CONSTRAINT DataManipulationLangugageStatement_CHK CHECK(DataManipulationLangugageStatement IN ('Insert Statement', 'Update Statement', 'Delete Statement'))
);
--
CREATE OR REPLACE TRIGGER CompaniesDMLStatementsBefore BEFORE INSERT OR UPDATE OR DELETE 
ON Companies
FOR EACH ROW
BEGIN
IF INSERTING THEN
INSERT INTO CompaniesLog(CompanyID, CompanyName, DataManipulationLangugageStatement) VALUES(:NEW.CompanyID, :NEW.CompanyName, 'Insert Statement');
ELSIF UPDATING THEN
INSERT INTO CompaniesLog(CompanyID, CompanyName, DataManipulationLangugageStatement) VALUES(:OLD.CompanyID, :OLD.CompanyName, 'Update Statement');
ELSIF DELETING THEN
INSERT INTO CompaniesLog(CompanyID, CompanyName, DataManipulationLangugageStatement) VALUES(:OLD.CompanyID, :OLD.CompanyName, 'Delete Statement');
END IF;
END;
--
--STOP EXECUTING
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
--STOP EXECUTING
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
--
------------------------------
------------------------------
------------------------------
------------------------------
------------------------------
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
DELETE FROM Companies;
COMMIT;
-- 
TRUNCATE TABLE CompaniesLog;
TRUNCATE TABLE Companies;
--
ALTER TRIGGER CompaniesDMLStatementsAfter ENABLE;
ALTER TRIGGER CompaniesDMLStatementsAfter DISABLE;
DROP TRIGGER CompaniesDMLStatementsAfter;
--
ALTER TRIGGER CompaniesDMLStatementsBefore ENABLE;
ALTER TRIGGER CompaniesDMLStatementsBefore DISABLE;
DROP TRIGGER CompaniesDMLStatementsBefore;
--
ALTER TABLE CompaniesLog DROP CONSTRAINT DataManipulationLangugageStatement_CHK;
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


