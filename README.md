BCCI Database Management System 

<img width="306" height="165" alt="bcci" src="https://github.com/user-attachments/assets/6ce34123-4813-4b82-8a2e-c7ebaad09b2e" />
[BCCI ER diagram.pdf](https://github.com/user-attachments/files/24254832/BCCI.ER.diagram.pdf)


This project presents a structured and normalized database design for the Board of Control for Cricket in India (BCCI).


It demonstrates the practical application of core Database Management System (DBMS) concepts such as entity–relationship modeling, normalization, relational integrity, and constraint enforcement.

The database is designed to efficiently manage cricket-related data involving teams, players, matches, tournaments, venues, umpires, and contractual information under the BCCI ecosystem.

Objectives of the Project

To model a complex real-world organization using a relational database

To reduce data redundancy through normalization

To ensure data integrity and consistency using primary keys, foreign keys, and constraints

To support efficient data storage, retrieval, and management

To demonstrate forward engineering using MySQL Workbench

Key Features

Centralized management of teams, players, and coaches

Player contract tracking with duration and contract value

Tournament and match scheduling details

Venue and umpire allocation for matches

Player performance records at match level

Proper implementation of one-to-many and many-to-many relationships

Enforced referential integrity using primary and foreign keys

Well-normalized tables designed for scalability and performance

Database Design and ER Model

The database schema is designed using an EER (Enhanced Entity–Relationship) model, representing key entities and their interactions within BCCI operations.

Major Entities

Team – Stores details of national and league teams

Player – Maintains player profiles and playing roles

Coach – Stores coaching staff information

Contract – Tracks player contracts with BCCI or IPL teams

Tournament – Represents cricket tournaments conducted by BCCI

Match_Details – Stores match-specific information

Venue – Manages match venues and locations

Umpire – Stores umpire profiles and experience details

<img width="650" height="450" alt="stadium" src="https://github.com/user-attachments/assets/494294f1-0d94-4328-83a5-0751740cd966" />

Relationship Handling

A team can have multiple players and coaches

A player can participate in multiple matches

Matches are associated with tournaments and venues

Umpires and venues are linked using bridge tables to handle many-to-many relationships

Player match performance is stored separately to maintain normalization

Database Integrity and Optimization

Primary Keys ensure unique identification of records

Foreign Keys enforce referential integrity between related tables

CHECK and ENUM constraints improve data validation and consistency


Appropriate data types are used to optimize storage and performance

Tools and Technologies Used

MySQL Workbench 8.0

MySQL Server 8.0

EER Modeling and Forward Engineering

Files Included

1.BCCI_ER_MODEL.mwb
MySQL Workbench model file
Contains the EER diagram, entities, relationships, and constraints
2.Bcci_full_schema_with_data.sql
Forward-engineered SQL script
Includes schema creation, table definitions, constraints, and sample data

BY :

GROUP 8(SEC A)
PRIYANSHI ARORA(341040), HARSHIT SHARMA(341020), PRIYA YADAV(341039)

SUBMITTED TO:

Mr. ASHOK HARNAL
