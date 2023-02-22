/* Exploring data about real estate in USA in SQL
Skills used:*/

------------------------------------------------------------------------


SELECT 
    year, 
    COUNT(year) AS property_sold
FROM 
    `myproject8888-357816.real_estate_us.re_us2` 
GROUP BY
    year
ORDER BY 
    property_sold DESC
    
/* 2023 - highest, 1901 - lowest */


/* Explore state */

SELECT
    state,  
    COUNT(state) AS num_of_property,
    AVG(price) AS avg_price,
FROM 
    `myproject8888-357816.real_estate_us.re_us2` 
GROUP BY
    state
ORDER BY 
    num_of_property DESC
    
    
SELECT
    year,
    state,  
    COUNT(state) AS num_of_property,
    AVG(price) AS avg_price   
FROM 
    `myproject8888-357816.real_estate_us.re_us2`
WHERE 
    year IS NOT NULL 
GROUP BY
    state, year
ORDER BY 
    state, year DESC     
    
    

/* Explore city */    
    
SELECT    
    city,  
    COUNT(city) AS num_of_property,
    AVG(price) AS avg_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price,
    AVG(house_size_m2) AS avg_size,
    MIN(house_size_m2) AS min_size,
    MAX(house_size_m2) AS max_size,
    AVG(hectare_lot) AS avg_lot,
    MIN(hectare_lot) AS min_lot,
    MAX(hectare_lot) AS max_lot,   
FROM 
    `myproject8888-357816.real_estate_us.re_us4`
GROUP BY
    city
ORDER BY 
    num_of_property DESC 
    
    
 
///////////////////////////////////////////////////


SELECT    
    state,  
    COUNT(state) AS num_of_property,
    AVG(price) AS avg_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price   
FROM 
    `myproject8888-357816.real_estate_us.re_us2`
GROUP BY
    state
ORDER BY 
    num_of_property DESC 
    
    
    
SELECT
    year,
    state,  
    COUNT(state) AS num_of_property,
    AVG(price) AS avg_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price   
FROM 
    `myproject8888-357816.real_estate_us.re_us2`
WHERE 
    year IS NOT NULL 
GROUP BY
    state, year
ORDER BY 
    state, year DESC 
    
    
    
    
SELECT 
    state,
    bathrooms,
    COUNT(bathrooms) AS count_bath,
    AVG(price) AS avg_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price
FROM 
    `myproject8888-357816.real_estate_us.re_us2`
GROUP BY 
    state, bathrooms
ORDER BY 
    count_bath DESC, state
    
    
   
SELECT 
    bathrooms,
    COUNT(bathrooms) AS count_bath,
    AVG(price) AS avg_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price
FROM 
    `myproject8888-357816.real_estate_us.re_us_sold`
GROUP BY 
    bathrooms
ORDER BY 
    count_bath DESC
    
    
SELECT 
    bathrooms,
    COUNT(bathrooms) AS count_bath
FROM 
    `myproject8888-357816.real_estate_us.re_us2`
WHERE 
    state = 'New York'
GROUP BY 
    bathrooms
ORDER BY 
    count_bath DESC
    
    

SELECT    
    state,  
    COUNT(state) AS num_of_property,
    AVG(price) AS avg_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price   
FROM 
    `myproject8888-357816.real_estate_us.re_us_sold`
GROUP BY
    state
ORDER BY 
    num_of_property DESC 
    
    
    
CREATE OR REPLACE TABLE`myproject8888-357816.real_estate_us.re_us3` 
AS
SELECT 
    DISTINCT  
    state,
    city,
    price,
    bedrooms,
    bathrooms,
    acre_lot,
    house_size,
    sold_date   
FROM 
    `myproject8888-357816.real_estate_us.re_us2`
 
 
 
 
 
 CREATE OR REPLACE TABLE`myproject8888-357816.real_estate_us.re_us3` 
AS
SELECT 
    ROW_NUMBER() OVER(ORDER BY price DESC) AS id,
    *  
FROM
    `myproject8888-357816.real_estate_us.re_us4`  



SELECT
    *
FROM 
    `myproject8888-357816.real_estate_us.re_us4`
WHERE 
    acre_lot IS NOT NULL AND house_size IS NULL and bathrooms IS NULL and bedrooms IS NULL



CREATE OR REPLACE TABLE `myproject8888-357816.real_estate_us.re_us31`
AS
SELECT 
    DISTINCT  
    state,
    city,
    price,
    bedrooms,
    bathrooms,
    acre_lot,
    hectare_lot,
    house_size,
    house_size_m2,
    sold_date   
FROM 
    `myproject8888-357816.real_estate_us.re_us3` 
ORDER BY 
    price DESC
    
    
    
CREATE OR REPLACE TABLE `myproject8888-357816.real_estate_us.re_us_duplicates`
AS
SELECT 
    state,
    city,
    price,
    bedrooms,
    bathrooms,
    acre_lot,
    house_size,  
    sold_date,
    COUNT(*) as counts
FROM `myproject8888-357816.real_estate_us.re_us4`
GROUP BY 
    state,
    city,
    price,
    bedrooms,
    bathrooms,
    acre_lot,
    house_size, 
    sold_date

HAVING COUNT(*) > 1
ORDER BY price DESC




SELECT *
FROM `myproject8888-357816.real_estate_us.re_us4`
WHERE bathrooms is null and bedrooms is null and acre_lot is null and house_size is null


SELECT *, b.street
FROM `myproject8888-357816.real_estate_us.re_us_duplicates` a
LEFT JOIN 
`myproject8888-357816.real_estate_us.re_us4` b
ON a.state = b.state AND
    a.city = b.city AND
    a.price = b.price AND
    a.bedrooms = b.bedrooms AND 
    a.bathrooms = b.bathrooms AND
    a.acre_lot = b.acre_lot AND
    a.house_size = b.house_size AND
    a.sold_date = b.sold_date
