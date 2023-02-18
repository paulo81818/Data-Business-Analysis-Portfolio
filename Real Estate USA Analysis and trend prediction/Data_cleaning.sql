/* Data cleaning using SQL */


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

/* Status column contains 2 distinct values and most of them are 'for sale' - 113512
. All rows with 'ready_to_build'(277 rows) have no sold date.*/
    


/*Check bed column*/

SELECT 
    bed,
    COUNT(bed) as count_bed
FROM 
    `myproject8888-357816.real_estate_us.re-us` 
GROUP BY bed
ORDER BY count_bed DESC



SELECT 
    *
FROM 
    `myproject8888-357816.real_estate_us.re_us1` 
WHERE bed > 11



SELECT 
    *
FROM 
    `myproject8888-357816.real_estate_us.re_us1` 
WHERE bedrooms IS NULL

/* Here are some rows with an enormously high quantity of bedrooms; for example, 123 is the maximum value. However, a portion of the rows do not have a null sold_date.
There aren't many rows like this. We will leave it as is. 17516 with null values in this column */



/* Check the other columns */ 



