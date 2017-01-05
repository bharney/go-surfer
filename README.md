# go-surfer
Go-Surfer, for the fun of it! Ecommerce site using web forms.

The project is intended for ASP.NET web forms with a SQL Server Database. 

Get started:

1. There is a sql server script to build the database and all tables needed. Script is called BuildDatabaseAndTables.sql Run this script on sql server to create the neccessary DB and tables.

2. Create a Visual Studio ASP.Net website

3. Add a web.config file to your website root directory. You will need to include a connection string to your DB with credentials. I have not included this file as it contains sensitive information.

4. Host website with IIS and add directory to app pool.

This project will allow users to dynamically add products, prices, and image paths to thier database and display within the product page.


