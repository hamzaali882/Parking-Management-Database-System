# Parking Management Database System

## Project Overview

The Parking Management Database System is a SQL-based database project designed to manage parking areas, vehicles, parking slots, vehicle tracking, and parking fees.

The project demonstrates the design and implementation of a relational database using Oracle SQL. It includes table creation, primary keys, foreign keys, constraints, sample data, and SQL queries for retrieving and analyzing parking information.

## Objectives

- Design a structured parking management database.
- Store information about parking areas and their capacities.
- Manage vehicle information.
- Manage parking slots and their status.
- Track vehicle entry, exit, and parking duration.
- Store parking fee information.
- Demonstrate database normalization.
- Perform SQL queries to retrieve useful information.

## Database Tables

### AREA
Stores information about parking areas.

- AreaID
- AreaName
- Address
- Capacity

### VEHICLE
Stores information about vehicles and their owners.

- VehicleID
- Plate
- VType
- OwnerName
- ContactNo

### SLOT
Stores information about parking slots.

- SlotID
- AreaID
- SlotStatus

### TRACKING
Stores vehicle parking and tracking information.

- TrackingID
- SlotID
- VehicleID
- EntryTime
- ExitTime
- DurationHrs

### FEE
Stores parking fee information.

- FeeID
- TrackingID
- HourlyRate
- TotalFee

### PARKING_UNNORMALIZED
Contains the initial unnormalized parking data used to demonstrate the normalization process.

## Database Relationships

The database uses primary keys and foreign keys to establish relationships between the tables.

- AREA is related to SLOT.
- VEHICLE is related to TRACKING.
- SLOT is related to TRACKING.
- TRACKING is related to FEE.

## Technologies Used

- Oracle Database
- Oracle SQL
- SQL Developer

## SQL Concepts Used

The project includes:

- SELECT
- WHERE
- COUNT()
- SUM()
- AVG()
- MAX()
- MIN()
- GROUP BY
- ORDER BY
- Primary Keys
- Foreign Keys
- CHECK Constraints
- UNIQUE Constraints

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
