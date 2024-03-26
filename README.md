# Airline Management System

This repository contains the source code and documentation for an Airline Management System developed as a part of the CS 5200 final project by the BasangoudarARongaE group. The system is designed to facilitate efficient management of airline operations and enhance customer experience through a user-friendly graphical interface.

## Getting Started
To deploy the Airline Management System, follow these steps:

- Prerequisites
Windows OS (compatibility issues may arise on MacOS)
MySQL Workbench
Python IDE (e.g., VS Code or PyCharm)
MySQL DB connector (mysql-connector-python)
Tkinter library for Python GUI
Installation
Clone this repository to your local machine.
Import the database schema and data dump from the dump_airline_dbms.sql file using MySQL Workbench.
Install the MySQL DB connector by running python -m pip install mysql-connector-python in the terminal.
Install Tkinter library by running pip install tkinter in the terminal.
Usage
Run the app.py file.
Enter the username and password for your MySQL database when prompted.
The GUI will appear, providing options for customers to view flights, create reservations, update reservations, and delete reservations.

Note
If you encounter the error mysql.connector.errors.NotSupportedError: Authentication plugin 'caching_sha2_password' is not supported, consider upgrading to a newer version of the MySQL connector library or changing the default authentication plugin used by your MySQL server.
Technical Specifications
Relational database (SQL) implemented using MySQL Workbench.
Graphical User Interface (GUI) developed in Python using the tkinter library.
Designed and tested on Windows OS hardware.
Conceptual Design

## Logical Design

## User Flow

Lessons Learned
Emphasized the importance of conceptual design for successful implementation.
Leveraged database procedures, functions, and triggers to streamline system functionalities.
Recognized the critical role of database integrity in ensuring system reliability and performance.
Future Work
Implement CRUD functionality for additional tables, such as flights.
Introduce security protocols to protect customer information and enhance data privacy.
Continuously improve the system based on user feedback and emerging requirements.

License
This project is licensed under the MIT License - see the LICENSE file for details.
