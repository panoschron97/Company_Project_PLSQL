# Company project Oracle PL/SQL

## Project Description

This repository contains a PL/SQL script for a company.

## Features

- **PL/SQL Script:** Creating and managing database objects, users and roles.
- **Data Manipulation:** Demonstrates INSERT, UPDATE and DELETE operations on various tables.
- **Trigger Implementation:** Shows how to create and use database triggers for logging and auditing.
- **Bash Script:** Contains shell script for automating database task methods.
- **Supporting Documentation:** Provides screenshots and configuration files for reference.

## Table of Contents

- [Project Description](#project-description)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Dependencies](#dependencies)

## Installation

1.  Clone the repository:
    ```bash
    git clone https://github.com/panoschron97/Company_Project_PLSQL.git
    cd Company_Project_PLSQL
    ```

2.  Set up your Oracle database environment. Ensure you have Oracle Database installed and configured.

3.  Place the SQL script in a location accessible to your database client.

## Usage

1.  Connect to your Oracle database as a privileged user (e.g., `SYS`).

2.  Execute the main SQL script (`Company_Project_PLSQL.sql`) to set up the database:
    ```sql
    sqlplus sys/password@your_database @Company_Project_PLSQL.sql
    ```
    Replace `password` with the actual SYS password and `your_database` with your database connection string.

## Dependencies

-   **Oracle Database:** Required for running the PL/SQL script.
-   **SQL*Plus:** Oracle's command-line interface for executing SQL and PL/SQL.
