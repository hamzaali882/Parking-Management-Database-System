# Parking Management Database System

## Project Overview

The **Parking Management Database System** is a SQL-based database project designed to manage parking areas, vehicles, parking slots, vehicle tracking, and parking fees.

The project demonstrates the design and implementation of a relational database using **Oracle SQL**. It includes database creation, table relationships, primary keys, foreign keys, constraints, sample data, normalization, and SQL queries for retrieving, transforming, and analyzing parking data.

The project also demonstrates advanced SQL techniques such as JOINs, CASE statements, subqueries, Common Table Expressions (CTEs), aggregate analysis, and window functions.

## Objectives

* Design a structured relational database for parking management.
* Store information about parking areas and their capacities.
* Manage vehicle and owner information.
* Manage parking slots and their availability status.
* Track vehicle entry, exit, and parking duration.
* Store and analyze parking fee information.
* Demonstrate database normalization.
* Establish relationships using primary and foreign keys.
* Perform SQL queries for data retrieval and analysis.
* Apply advanced SQL techniques to generate business-oriented insights.
* Perform data quality and validation checks.

## Database Tables

### AREA

Stores information about parking areas.

* AreaID
* AreaName
* Address
* Capacity

### VEHICLE

Stores information about vehicles and their owners.

* VehicleID
* Plate
* VType
* OwnerName
* ContactNo

### SLOT

Stores information about parking slots and their status.

* SlotID
* AreaID
* SlotStatus

### TRACKING

Stores vehicle parking and tracking information.

* TrackingID
* SlotID
* VehicleID
* EntryTime
* ExitTime
* DurationHrs

### FEE

Stores parking fee information.

* FeeID
* TrackingID
* HourlyRate
* TotalFee

### PARKING_UNNORMALIZED

Contains the initial unnormalized parking data used to demonstrate the database normalization process.

## Database Relationships

The database uses primary keys and foreign keys to establish relationships between the tables.

* **AREA → SLOT**: An area can contain multiple parking slots.
* **VEHICLE → TRACKING**: A vehicle can have multiple parking records.
* **SLOT → TRACKING**: A parking slot can be associated with multiple tracking records over time.
* **TRACKING → FEE**: Each parking tracking record can have associated fee information.

## Technologies Used

* Oracle Database
* Oracle SQL
* Oracle SQL Developer

## SQL Concepts Used

The project demonstrates both fundamental and advanced SQL concepts.

### Basic SQL

* SELECT
* WHERE
* ORDER BY
* GROUP BY
* COUNT()
* SUM()
* AVG()
* MAX()
* MIN()

### Database Design

* Primary Keys
* Foreign Keys
* CHECK Constraints
* UNIQUE Constraints
* Relational Database Design
* Database Normalization

### Advanced SQL

* INNER JOIN
* Multi-table JOINs
* CASE Statements
* Subqueries
* Common Table Expressions (CTEs)
* Aggregate Functions
* Window Functions
* RANK()
* PARTITION BY
* Running Totals
* Business-oriented data analysis
* Data validation queries

## SQL Analysis Examples

The `queries.sql` file contains queries covering different levels of SQL analysis, including:

### Basic Analysis

* Total number of vehicles
* Vehicles by type
* Parking slots by status
* Total parking revenue
* Average parking fee
* Fees above a specified amount
* Tracking records exceeding a specified duration
* Areas with capacity above a specified threshold

### JOIN Analysis

* Combining vehicle and tracking information
* Combining area, slot, tracking, and fee information
* Multi-table parking transaction analysis

### Business Analysis

* Revenue by parking area
* Revenue by vehicle type
* Average parking fees
* Parking duration classification
* Vehicle spending analysis
* Parking activity analysis

### Advanced SQL Analysis

* Subqueries for above-average values
* CTE-based revenue analysis
* CASE-based parking duration categories
* Vehicle spending rankings
* Running revenue calculations
* Window function analysis

## Project Structure

```text
Parking-Management-Database-System/
│
├── README.md
│
├── sql/
│   ├── parking_management.sql
│   └── queries.sql
│
├── documentation/
│   └── Parking_Management_Documentation.docx
│
└── screenshots/
    │
    ├── AREA TABLE.png
    ├── AREA_CAPACITY_GREATER50.png
    ├── AVERAGE_FEE.png
    ├── CTE_AREA_REVENUE.png
    ├── ER_Diagram.png
    ├── FEE TABLE.png
    ├── MULTI_TABLE_JOIN.png
    ├── PARKING_DURATION_CASE.png
    ├── PARKING_FEE_ABOVE_100.png
    ├── PARKING_REVENUE_QUERY.png
    ├── PARKING_UNNORMALIZED TABLE.png
    ├── REVENUE_BY_PARKING_AREA.png
    ├── RUNNING_REVENUE.png
    ├── SLOT TABLE.png
    ├── SLOT_STATUS_QUERY.png
    ├── TOTAL_VEHICLE_QUERY.png
    ├── TRACKING TABLE.png
    ├── TRACKING_DURATION_5HOURS.png
    ├── VEHICLE TABLE.png
    └── VEHICLE_TYPE_QUERY.png
```

## Project Highlights

* Relational database designed using Oracle SQL.
* Proper use of primary and foreign key relationships.
* Demonstrates normalization from an unnormalized dataset.
* Includes fundamental and advanced SQL queries.
* Uses multi-table JOINs to combine related parking data.
* Uses CASE statements for data classification.
* Uses subqueries and CTEs for analytical queries.
* Uses window functions for ranking and running revenue analysis.
* Includes business-oriented queries for parking revenue and usage analysis.
* Includes screenshots demonstrating database tables and SQL query outputs.

## Purpose

This project was developed to demonstrate practical skills in SQL, relational database design, data analysis, and business-oriented data querying using an Oracle database.
