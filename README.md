# Getting started with dbt

I wanted to take some time and use dbt with a simple project. This project makes use of the Northwind data. The data can be accessed in many places, I found the necessary files [here]('https://code.google.com/archive/p/northwindextended/downloads')

## Data warehousing

Although the database is small, dbt has limited support for SQLite. The built in connectors support a lot of the standard database and data warehouse tools. Since the Northwind database can also be acquired in a PostgreSQL file, I decided to go that route. After spiining up a free-tier Postgres instance on AWS RDS, I ran the sql file in PgAdmin and within a short window of time I was up and running. 

While I could have used dbt in a CLI, the limited cloud enviroment was sufficient and free with limitations. Plus, it was nice to see the same interface as their training materials. 

Luckily, the dbt connection is nothing more than passing credentials.

<img src=https://raw.githubusercontent.com/smithjustinm/dbt_northwind/main/Screen%20Shot%202021-08-11%20at%2010.30.14%20PM.png width="400" height="auto"/>

## yml Files

In the base directory there is a dbt_project.yml files. The yml file specifies project details and can be configured for different materilizations at the folder level (quite useful). 

<img src=https://raw.githubusercontent.com/smithjustinm/dbt_northwind/main/Screen%20Shot%202021-08-11%20at%2011.24.15%20PM.png width="200" height="auto"/>

## Models

Dbt refers to any .sql files using "SELECT" statement as "models." These models are one of the main contributions dbt makes to the data warehouse. When "dbt run" is passed as a command, dbt executes the compiled SQL models against the target database. Dbt connects to the database and materialized the SQL. While there are various materializations, the table materialization populates a new table in the target database. 

### Staging & Jinja 

The real benefit of dbt is the use of Jinja and the ability to write SQL files that can act as variables. Staging SQL scripts to reference in other SQL scripts gives writing SQL a big upgrade. The "{{ }}" used in Jinja allow various templating and as mentioned referencing other models is a great way to get started. The syntax is {{ ref('staged_model_name')}}. 

<img src=https://raw.githubusercontent.com/smithjustinm/dbt_northwind/main/Screen%20Shot%202021-08-11%20at%2011.24.41%20PM.png width="400" height="auto"/>

One big question that seems to come up concerns readability. Won't something like this make SQL less readable since you are not looking at what goes into that refernced model? Good news, you can click "Compile SQL" in dbt cloud or "dbt compile" in the CLI. 

## dbt run Error

After writing stage models and then referencing those models in others, it is time to type dbt run and send everything over to the database. Dbt is supposed to infer that the staging models need to be compiled first and then the main models that, presumably, create new tables in the database. I, however, was not that lucky. My first few dbt runs failed. After a bit of searching I found that I could use "dbt run -- target staging" which would run the targeted folder of models first. I am not sure why I encountered the error, but I was happy to find a work around. 

## Transformations

Since dbt is focused on the T in the ELT pipeline, it is worth noting what the transformations are. The transformations are the main models that create denormalized data in the data warehouse for BI users and data analysts to leverage. One of dbt's practices in their tutorials is to place these transformations in a "marts" folder and then further break them down for individual departments as needed. 

## Jinja, Macros, and Beyond

Dbt leverages Jinja in another way, macros. Macros are similar to references, but instead of referencing a staged model like a varialbe a macro is more like a function. When you think about the possibilities of writing functions in SQL and sharing them with a team of analytics engineers, composing SQL queries gets a bit more interesting. 

