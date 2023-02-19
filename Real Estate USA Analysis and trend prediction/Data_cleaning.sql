/* Data cleaning using SQL
Skills used: CREATE, GROUP BY, ORDER BY, REPLACE, COUNT, DISTINCT, Remove duplicates, inadequate, and unnecessary data.*/


----------------------------------------------------------------------------------

/*First look at the dataset*/

SELECT 
    *
FROM 
    `myproject8888-357816.real_estate_us.re-us` 
LIMIT 
    1000




/* Remove Duplicates and create a new table */

CREATE OR REPLACE TABLE myproject8888-357816.real_estate_us.re_us1
AS
SELECT 
  DISTINCT *
FROM 
    `myproject8888-357816.real_estate_us.re-us`  
    
/* The dataset has decreased by almost 9 times */    



/* Change datatypes and names in the 'bed', 'bath', 'zip_code' columns*/

CREATE OR REPLACE TABLE `myproject8888-357816.real_estate_us.re_us1`
AS
SELECT
    status, 
    price, 
    CAST(bed AS INT64) AS bedrooms, 
    CAST(bath AS INT64) AS bathrooms,
    acre_lot,
    full_address,
    street,
    city,
    state,
    CAST(zip_code AS STRING) AS zipcode, 
    house_size,
    sold_date
FROM`myproject8888-357816.real_estate_us.re_us1` 
    
    
    
/*Check distint values in the status column and quantity*/    
SELECT 
    status,
    COUNT(status)
FROM 
    `myproject8888-357816.real_estate_us.re_us1` 
GROUP BY status



/*Check sold_date column with status 'ready_to_build'*/

SELECT 
    *
FROM 
    `myproject8888-357816.real_estate_us.re_us1` 
WHERE 
    status = 'ready_to_build' AND 
    sold_date IS NOT NULL

/* The Status column has two distinct values, the majority of which are "for_sale" (113512).
There is no 'sold date' for any of the rows with "ready_to_build" (277 rows). Later, we will exclude 'ready_to_build' rows from our analysis,
because they are now actually existing buildings.  */
    


/*Check bed column*/

SELECT 
    bedrooms,
    COUNT(bedrooms) as count_bed
FROM 
    `myproject8888-357816.real_estate_us.re-us` 
GROUP BY bedrooms
ORDER BY count_bed DESC



SELECT 
    *
FROM 
    `myproject8888-357816.real_estate_us.re_us1` 
WHERE bedrooms > 11



SELECT 
    *
FROM 
    `myproject8888-357816.real_estate_us.re_us1` 
WHERE bedrooms IS NULL

/* Here are some rows with an enormously high quantity of bedrooms; for example, 123 is the maximum value. However, a portion of the rows do not have a null sold_date.
There aren't many rows like this. We will leave it as is. 17516 with null values in this column */



/* Check the other columns */ 

SELECT 
    bathrooms,
    COUNT(bathrooms) as count_bath
FROM 
    `myproject8888-357816.real_estate_us.re_us1` 
GROUP BY bathrooms
ORDER BY count_bath DESC

SELECT 
    *
FROM 
    `myproject8888-357816.real_estate_us.re_us1` 
WHERE bathrooms > 12

SELECT 
    *
FROM 
    `myproject8888-357816.real_estate_us.re_us1` 
WHERE bathrooms IS NULL

/* 16297 null values in the bathrooms column. Enormously high values (more than 11) in the bathroom column in 210 rows.
There are more bathrooms than bedrooms in these rows. Maybe it's a mistake. But we don't know exactly; it's not the goal of our analysis right now.
And it will not skew the results; we will leave it as it is. */


SELECT
    *
FROM `myproject8888-357816.real_estate_us.re_us1` 
WHERE state IS NULL



SELECT
    state,
    COUNT(state) AS counts
FROM `myproject8888-357816.real_estate_us.re_us1` 
GROUP BY state
ORDER BY counts DESC


/* There are no null values in the "state" column. 
Virginia (7), Georgia (5), South Carolina, Tennessee, Wyoming, and West Virginia (1) have a low quantity of rows. 
We will exclude them from our analysis. */



SELECT
    *
FROM 
    `myproject8888-357816.real_estate_us.re_us1` 
WHERE 
    sold_date IS NULL
 
 
 /* There are 54092 null values in the "sold_date" column. These rows cannot be used for time-series analysis.
So, let's create two tables: one for analysis by time periods and prediction, and another for the basic exploration. */



/* Remove the states of Virginia, Georgia, South Carolina, Tennessee, Wyoming, and West Virginia; "ready_to_build' status. 
Drop the status, full_address, and zipcode columns.
I use CREATE OR DROP TABLE because DML is not available in the Bigquery Sandbox. */

CREATE OR REPLACE TABLE `myproject8888-357816.real_estate_us.re_us1`
AS
SELECT
    state,
    city,
    street,
    price,
    bedrooms,
    bathrooms,
    acre_lot,
    house_size,
    sold_date
FROM 
    `myproject8888-357816.real_estate_us.re_us1` 
WHERE 
    status != 'ready_to_build' AND
    state != 'Virginia'AND
    state != 'Georgia' AND
    state != 'South Carolina' AND
    state != 'Tennessee' AND
    state != 'Wyoming' AND
    state != 'West Virginia' 


/* Inspect city column */
SELECT 
    city,
    COUNT(city) AS counts,
    state
FROM `myproject8888-357816.real_estate_us.re_us1` 
GROUP BY city, state
ORDER BY counts DESC


SELECT 
    city,
    COUNT(city) AS counts,
    state
FROM `myproject8888-357816.real_estate_us.re_us1`
WHERE city LIKE 'N%' AND state = 'New York'
GROUP BY city, state
ORDER BY counts DESC


SELECT 
    city,
    COUNT(city) AS counts,
    REPLACE(REPLACE(REPLACE(city, 'New York City', 'New York'),'Nyc', 'New York'), 'Ny', 'New York') AS ny,
    state
FROM `myproject8888-357816.real_estate_us.re_us1`
WHERE city LIKE 'N%' AND state = 'New York'
GROUP BY city, state
ORDER BY counts DESC



/* Create second table only with not null values in the 'sold_date' column */

CREATE OR REPLACE TABLE `myproject8888-357816.real_estate_us.re_us_sold`
AS
SELECT 
    *
FROM 
    `myproject8888-357816.real_estate_us.re_us1` 
WHERE
    sold_date IS NOT NULL
