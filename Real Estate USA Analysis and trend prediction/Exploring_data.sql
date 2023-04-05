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
    state
ORDER BY 
    num_of_property DESC 
    
 SELECT
    year,
    state,  
    COUNT(state) AS num_of_property,
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
    `myproject8888-357816.real_estate_us.re_us_property`
WHERE 
    year IS NOT NULL
GROUP BY
    state, year
ORDER BY 
    num_of_property DESC 
     
    

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


/* Explore bathrooms */    


SELECT 
    state,
    bathrooms,
    COUNT(bathrooms) AS count_bath,
    AVG(price) AS avg_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price,
    AVG(house_size_m2) AS avg_size,
    MIN(house_size_m2) AS min_size,
    MAX(house_size_m2) AS max_size,
FROM 
    `myproject8888-357816.real_estate_us.re_us_property`
GROUP BY 
    state, bathrooms
ORDER BY 
    count_bath DESC, state
    

SELECT 
    bathrooms,
    COUNT(bathrooms) AS count_bath,
    AVG(price) AS avg_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price,
    AVG(house_size_m2) AS avg_size,
    MIN(house_size_m2) AS min_size,
    MAX(house_size_m2) AS max_size,
FROM 
    `myproject8888-357816.real_estate_us.re_us_property`
GROUP BY 
    bathrooms
ORDER BY 
    count_bath DESC
    
    
    
/* Explore bedrooms */

SELECT 
    state,
    bedrooms,
    COUNT(bedrooms) AS count_bed,
    AVG(price) AS avg_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price,
    AVG(house_size_m2) AS avg_size,
    MIN(house_size_m2) AS min_size,
    MAX(house_size_m2) AS max_size,
FROM 
    `myproject8888-357816.real_estate_us.re_us_property`
GROUP BY 
    bedrooms, state
ORDER BY 
    count_bed DESC
    

SELECT 
    bedrooms,
    COUNT(bedrooms) AS count_bed,
    AVG(price) AS avg_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price,
    AVG(house_size_m2) AS avg_size,
    MIN(house_size_m2) AS min_size,
    MAX(house_size_m2) AS max_size,
FROM 
    `myproject8888-357816.real_estate_us.re_us_property`
GROUP BY 
    bedrooms
ORDER BY 
    count_bed DESC


/* Adding "year" column. */

CREATE OR REPLACE TABLE `myproject8888-357816.real_estate_us.re_us_property`
AS
SELECT 
    *,
    EXTRACT(YEAR FROM sold_date) AS year,
    FROM `myproject8888-357816.real_estate_us.re_us_property` 
    
    
/* Query data for Power BI exploration by year. */    
SELECT
    state,
    city,
    year,
    bedrooms,
    bathrooms,  
    COUNT(state) AS num_of_property,
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
    `myproject8888-357816.real_estate_us.re_us_property`
WHERE year IS NOT NULL
GROUP BY
    state, city, year, bedrooms, bathrooms
ORDER BY 
    num_of_property DESC 



/* Query data for Power BI exploration by year and month. */    
SELECT
    state,
    city,
    year,
    FORMAT_DATE('%B', sold_date) AS month,
    bedrooms,
    bathrooms,  
    COUNT(state) AS num_of_property,
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
    `myproject8888-357816.real_estate_us.re_us_property`
WHERE year IS NOT NULL
GROUP BY
    state, city, year, month, bedrooms, bathrooms
ORDER BY 
    num_of_property DESC 
 




