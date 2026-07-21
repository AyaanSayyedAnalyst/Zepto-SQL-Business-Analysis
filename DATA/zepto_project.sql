DROP TABLE IF EXISTS zepto;

CREATE TABLE zepto(
sku_id SERIAL PRIMARY KEY,
category VARCHAR(120),
name VARCHAR(120) NOT NULL,
mrp NUMERIC(8,2),
discountpercent NUMERIC(5,2),
availablequantity INTEGER,
discountedsellingprice NUMERIC(8,2),
weightingms INTEGER,
outofstock BOOLEAN,
quantity INTEGER
);

--DATA EXPLORATION--

--COUNT OF ROWS--

SELECT COUNT(*) FROM zepto;

--SAMPLE DATA--

SELECT * FROM zepto
LIMIT 10;

--NULL VALUES--

SELECT * FROM zepto
WHERE category IS NULL
OR
name IS NULL
OR
mrp IS NULL
OR
discountpercent IS NULL
OR
availablequantity IS NULL
OR
discountedsellingprice IS NULL
OR
weightingms IS NULL
OR
outofstock IS NULL
OR
quantity IS NULL;

--DIFFERENT PRODUCT CATEGORIES--

SELECT DISTINCT(category)
FROM zepto
ORDER BY category;

--PRODUCTS IN STOCK VS OUT OF STOCK--

SELECT outofstock, COUNT(sku_id)
FROM zepto
GROUP BY outofstock;

--PRODUCTS NAMES PRESENT MULTIPLE TIMES--

SELECT name, COUNT(sku_id) AS "NUMBER OF SKUs"
FROM zepto
GROUP BY name
HAVING COUNT(sku_id) > 1
ORDER BY COUNT(sku_id) DESC;

--DATA CLEANING--

--PRODUCTS WITH PRICE 0--

SELECT * FROM zepto
WHERE mrp = 0 OR discountedsellingprice = 0;

DELETE FROM zepto
WHERE sku_id = 3607;

--CONVERT PAISE TO RUPEE--

UPDATE zepto
SET mrp = mrp/100.0,
discountedsellingprice = discountedsellingprice/100.0;

SELECT mrp, discountedsellingprice FROM zepto;

--Q1. Find the top 10 best-value products based on the discount percentage.


SELECT DISTINCT name,mrp,discountpercent
FROM zepto
ORDER BY discountpercent DESC
LIMIT 10;

--Q2. What are the products with HIGH MRP but Out Of Stock.

SELECT DISTINCT name, mrp
FROM zepto
WHERE outofstock = True AND mrp > 300
ORDER BY mrp DESC;

--Q3. Calculate Estimated Revenue for each category.

SELECT category,
SUM(discountedsellingprice * availablequantity) AS TOTAL_REVENUE
FROM zepto
GROUP BY category
ORDER BY TOTAL_REVENUE;

--Q4. Find all products where MRP is greater than 500 and discount is less than 10%.

SELECT DISTINCT name, mrp, discountpercent
FROM zepto
WHERE mrp > 500 AND discountpercent < 10
ORDER BY mrp DESC, discountpercent DESC;

--Q5. Identify the TOP 5 categories offering the highest average discount percentage.

SELECT category, ROUND(AVG(discountpercent),2) AS "Highest AVG"
FROM zepto
GROUP BY category
ORDER BY AVG(discountpercent) DESC
LIMIT 5;

--Q6. Find the price per gram for products above 100g and sort by best value.

SELECT DISTINCT name, weightingms, discountedsellingprice,
ROUND(discountedsellingprice/weightingms,2) AS price_per_gram
FROM zepto
WHERE weightingms >= 100
ORDER BY price_per_gram;

--Q7. Group the products into categories like low, Medium, Bulk.

SELECT DISTINCT name, weightingms,
CASE WHEN weightingms < 1000 THEN 'low'
	 WHEN weightingms < 5000 THEN 'Mideum'
	 ELSE 'Bulk'
	 END AS weight_category
FROM zepto;

--Q8. What is the Total inventry weight per category.

SELECT category,
SUM(weightingms * availablequantity) AS total_weight
FROM zepto
GROUP BY category
ORDER BY total_weight;