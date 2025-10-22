# Company project Oracle PL/SQL

## Project Description

This repository contains PL/SQL scripts and related resources for a company project, including database setup, data manipulation, and user management. It also features bash scripts and supporting documentation, such as screenshots and configuration files. The primary goal is to provide a structured environment for managing and interacting with a company's database.

## Features

- **PL/SQL Scripts:** Includes scripts for creating and managing database objects, users, and roles.
- **Data Manipulation:** Demonstrates INSERT, UPDATE, and DELETE operations on various tables.
- **Trigger Implementation:** Shows how to create and use database triggers for logging and auditing.
- **Bash Scripts:** Contains shell scripts for automating database tasks.
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

3.  Place the SQL scripts in a location accessible to your database client.

## Usage

1.  Connect to your Oracle database as a privileged user (e.g., `SYS`).

2.  Execute the main SQL script (`Company_Project_PLSQL.sql`) to set up the database:
    ```sql
    sqlplus sys/password@your_database @Company_Project_PLSQL.sql
    ```
    Replace `password` with the actual SYS password and `your_database` with your database connection string.

3.  Run the bash scripts using the following command, providing the necessary credentials:
    ```bash
    ./LINUX_BASH_SCRIPTS/bash_scripts/sample.sh
    ```
    You will be prompted for the username, password, database connection string, and the SQL script path.

## Dependencies

-   **Oracle Database:** Required for running the PL/SQL scripts.
-   **SQL*Plus:** Oracle's command-line interface for executing SQL and PL/SQL.
-   **Bash:** Shell interpreter for running the automation scripts.
