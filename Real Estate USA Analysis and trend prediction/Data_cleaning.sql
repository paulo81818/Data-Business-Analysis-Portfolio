/* Data cleaning using SQL
Skills used: CREATE, GROUP BY, ORDER BY, REPLACE, CASE, Remove duplicates, inadequate, and unnecessary data.*/

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
FROM
    `myproject8888-357816.real_estate_us.re_us1` 
    
    
    
/*Check distint values in the status column and quantity*/    
SELECT 
    status,
    COUNT(status)
FROM 
    `myproject8888-357816.real_estate_us.re_us1` 
GROUP BY 
    status



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
GROUP BY 
    bedrooms
ORDER BY
    count_bed DESC



SELECT 
    *
FROM 
    `myproject8888-357816.real_estate_us.re_us1` 
WHERE 
    bedrooms > 11



SELECT 
    *
FROM 
    `myproject8888-357816.real_estate_us.re_us1` 
WHERE 
    bedrooms IS NULL

/* Here are some rows with an enormously high quantity of bedrooms; for example, 123 is the maximum value. However, a portion of the rows do not have a null sold_date.
There aren't many rows like this. We will leave it as is. 17516 with null values in this column */



/* Check the other columns */ 

SELECT 
    bathrooms,
    COUNT(bathrooms) as count_bath
FROM 
    `myproject8888-357816.real_estate_us.re_us1` 
GROUP BY
    bathrooms
ORDER BY
    count_bath DESC

SELECT 
    *
FROM 
    `myproject8888-357816.real_estate_us.re_us1` 
WHERE bathrooms > 12

SELECT 
    *
FROM 
    `myproject8888-357816.real_estate_us.re_us1` 
WHERE 
    bathrooms IS NULL

/* 16297 null values in the bathrooms column. Enormously high values (more than 11) in the bathroom column in 210 rows.
There are more bathrooms than bedrooms in these rows. Maybe it's a mistake. But we don't know exactly; it's not the goal of our analysis right now.
And it will not skew the results; we will leave it as it is. */


SELECT
    *
FROM 
    `myproject8888-357816.real_estate_us.re_us1` 
WHERE 
    state IS NULL



SELECT
    state,
    COUNT(state) AS counts
FROM 
    `myproject8888-357816.real_estate_us.re_us1` 
GROUP BY 
    state
ORDER BY 
    counts DESC


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
GROUP BY 
   city, 
   state
ORDER BY 
    counts DESC


SELECT 
    city,
    COUNT(city) AS counts,
    state
FROM `myproject8888-357816.real_estate_us.re_us1`
WHERE city LIKE 'N%' AND state = 'New York'
GROUP BY city, state
ORDER BY counts DESC



/*There are different spellings of New York(New York City, Ny, Nyc). Let's fix it */

SELECT 
    city,
    COUNT(city) AS counts,
    REPLACE(REPLACE(REPLACE(city, 'New York City', 'New York'),'Nyc', 'New York'), 'Ny', 'New York') AS ny,
    state
FROM
    `myproject8888-357816.real_estate_us.re_us1`
WHERE 
    city LIKE 'N%' AND state = 'New York'
GROUP BY 
    city, 
    state
ORDER BY 
    counts DESC


CREATE OR REPLACE TABLE
    `myproject8888-357816.real_estate_us.re_us1`
AS
SELECT
    state, 
    REPLACE(REPLACE(REPLACE(city, 'New York City', 'New York'),'Nyc', 'New York'), 'Ny', 'New York') AS city,
    street,
    price, 
    bedrooms,
    bathrooms,
    acre_lot, 
    house_size,
    sold_date
FROM 
    `myproject8888-357816.real_estate_us.re_us1`



/* Fixing 23 null values in the "city" column and add excract year from 'sold_date'. 
Checking null and suspiciously low values values(51 rows) is 'price' column and removing them  */

SELECT 
    *
FROM 
    `myproject8888-357816.real_estate_us.re_us1`
WHERE
    city IS NULL
    

SELECT 
    *
FROM 
    `myproject8888-357816.real_estate_us.re_us2`
WHERE 
    price IS NULL
    
    
    
SELECT 
    *
FROM 
    `myproject8888-357816.real_estate_us.re_us2`
WHERE 
    price < 5000



CREATE OR REPLACE TABLE `myproject8888-357816.real_estate_us.re_us2`
AS
SELECT 
    state,
CASE
    WHEN street IN ('163 Union and Mt Wash Ea','155-A La Vallee Nb','123 Catherines Hope Eb', '21 N Grapetree Eb', '42 43 Shoys Ea', '8-B Teagues Bay Eb', '242 Union and Mt Wash Ea', '96 Hard Labor Pr')  AND city IS NULL 
    THEN 'Christiansted'
    WHEN street IN ('4 Prosperity Nb', '20 River Pr', '17 Prosperity Nb', '94V I Corp Lands Pr', '14 Diamond Pr', '192 La Vallee Nb')  AND city IS NULL THEN 'Frederiksted'
    WHEN street IN ('240 St John Qu') AND city IS NULL THEN 'Saint John'
    WHEN street IN ('230 S Stevens Ave') AND city IS NULL THEN 'South Amboy'
    WHEN street IN ('0 Block 32 Quinton Alloway Quinton Rd Lot 11 01') AND city IS NULL THEN 'Quinton'
    WHEN street = '641 State Route 82' AND city IS NULL THEN 'Hopewell Junction'
    WHEN street = '32 Devereux Dr' AND city IS NULL THEN 'Manchester Township'
    WHEN street = '9-11 Putnam Park Rd' AND city IS NULL THEN 'Bethel'
    WHEN street = '68 Avondale St' AND city IS NULL THEN 'Valley Stream'
    WHEN street = '824-26 Berckman St' AND city IS NULL THEN 'Plainfield'
    WHEN street = '689 Luis M Marin Blvd Unit 1009' AND city IS NULL THEN 'Jersey City'
    ELSE city
END AS city,
    street,
    price, 
    bedrooms,
    bathrooms,
    acre_lot, 
    house_size,
    sold_date,
    EXTRACT(YEAR FROM sold_date) AS year
FROM 
    `myproject8888-357816.real_estate_us.re_us1`
WHERE 
    price > 5000


/* Create house_size_m2 and hectare_lot columns.
Replace incorrect highest value, update new highest value according to realtor.com data */


SELECT
    *
FROM 
    `myproject8888-357816.real_estate_us.re_us2`
ORDER BY 
    price DESC
    
    
    
SELECT 
    state,
    city,
    street,
    CASE 
        WHEN street = '952 E 223 St Units 4858 & 66' AND price = 875000000 THEN 850000
        WHEN street = '432 Park Ave Unit Penthouse' AND price = 169000000 Then 180000000
        ELSE price
    END AS price,
    bedrooms,
    bathrooms,
    acre_lot,
    acre_lot*0.404686 AS hectare_lot,
    house_size,
    house_size/10.7639 AS house_size_m2,
    sold_date 
FROM 
    `myproject8888-357816.real_estate_us.re_us2`
ORDER BY 
    price DESC
    
    
    
/* Create second table only with not null values in the 'sold_date' column */

CREATE OR REPLACE TABLE `myproject8888-357816.real_estate_us.re_us_sold`
AS
SELECT 
    *
FROM 
    `myproject8888-357816.real_estate_us.re_us2` 
WHERE
    sold_date IS NOT NULL
