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
    
    
 
