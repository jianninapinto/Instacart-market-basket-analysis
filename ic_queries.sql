/* Project Objective: Analyze Instacart's market data to understand business trends over time without using explicit dates.
Use SQL queries to derive insights from the data set. */

-- 1. Data Exploration and Understanding
-- Tables Data Structure
SELECT *
FROM ic_order_products_curr
LIMIT 5;

| "order_id" | "product_id" | "add_to_cart_order" | "reordered" |
|------------|--------------|---------------------|-------------|
| 1          | 49302        | 1                   | true        |
| 1          | 11109        | 2                   | true        |
| 1          | 10246        | 3                   | false       |
| 1          | 49683        | 4                   | false       |
| 1          | 43633        | 5                   | true        |

SELECT *
FROM ic_order_products_prior
LIMIT 5;

| "order_id" | "product_id" | "add_to_cart_order" | "reordered" |
|------------|--------------|---------------------|-------------|
| 1742049    | 47059        | 3                   | true        |
| 1742049    | 6343         | 4                   | true        |
| 1742049    | 6750         | 5                   | true        |
| 1742049    | 18740        | 6                   | true        |
| 1742049    | 27845        | 7                   | true        |

SELECT *
FROM ic_products
LIMIT 5;

| "product_id" | "product_name"                                                      | "aisle_id" | "department_id" |
|--------------|---------------------------------------------------------------------|------------|-----------------|
| 1            | "Chocolate Sandwich Cookies"                                        | 61         | 19              |
| 2            | "All-Seasons Salt"                                                  | 104        | 13              |
| 3            | "Robust Golden Unsweetened Oolong Tea"                              | 94         | 7               |
| 4            | "Smart Ones Classic Favorites Mini Rigatoni With Vodka Cream Sauce" | 38         | 1               |
| 5            | "Green Chile Anytime Sauce"                                         | 5          | 13              |

SELECT *
FROM ic_departments
LIMIT 5;

| "department_id" | "department"                                         |
|-----------------|------------------------------------------------------|
| 1               | "frozen                                            " |
| 2               | "other                                             " |
| 3               | "bakery                                            " |
| 4               | "produce                                           " |
| 5               | "alcohol                                           " |

SELECT *
FROM ic_aisles
LIMIT 5;

| "aisle_id" | "aisle"                                              |
|------------|------------------------------------------------------|
| 1          | "prepared soups salads                             " |
| 2          | "specialty cheeses                                 " |
| 3          | "energy granola bars                               " |
| 4          | "instant foods                                     " |
| 5          | "marinades meat preparation                        " |

-- Total number of products ordered in the previous quarter (Q2)
SELECT COUNT(*)
FROM ic_order_products_prior;

| "count"  |
|----------|
| 32434489 |

-- Total number of products ordered in the current quarter (Q3)
SELECT COUNT(*)
FROM ic_order_products_curr;

| "count" |
|---------|
| 1384617 |

-- 2. Data Quality Check
-- Check for missing values in ic_order_products_curr table
SELECT 
    COUNT(*) AS total_rows,
    COUNT(order_id) AS non_null_order_id,
    COUNT(product_id) AS non_null_product_id,
    COUNT(add_to_cart_order) AS non_null_add_to_cart_order,
    COUNT(reordered) AS non_null_reordered
FROM ic_order_products_curr;

| "total_rows" | "non_null_order_id" | "non_null_product_id" | "non_null_add_to_cart_order" | "non_null_reordered" |
|--------------|---------------------|-----------------------|------------------------------|----------------------|
| 1384617      | 1384617             | 1384617               | 1384617                      | 1384617              |


-- Check for missing values in ic_order_products_prior table
SELECT 
    COUNT(*) AS total_rows,
    COUNT(order_id) AS non_null_order_id,
    COUNT(product_id) AS non_null_product_id,
    COUNT(add_to_cart_order) AS non_null_add_to_cart_order,
    COUNT(reordered) AS non_null_reordered
FROM ic_order_products_prior;

| "total_rows" | "non_null_order_id" | "non_null_product_id" | "non_null_add_to_cart_order" | "non_null_reordered" |
|--------------|---------------------|-----------------------|------------------------------|----------------------|
| 32434489     | 32434489            | 32434489              | 32434489                     | 32434489             |

-- Check for missing values in ic_products table
SELECT 
    COUNT(*) AS total_rows,
    COUNT(product_id) AS non_null_product_id,
    COUNT(product_name) AS non_null_product_name,
    COUNT(aisle_id) AS non_null_aisle_id,
    COUNT(department_id) AS non_null_department_id
FROM ic_products;

| "total_rows" | "non_null_product_id" | "non_null_product_name" | "non_null_aisle_id" | "non_null_department_id" |
|--------------|-----------------------|-------------------------|---------------------|--------------------------|
| 49688        | 49688                 | 49688                   | 49688               | 49688                    |

-- Check for missing values in ic_departments table
SELECT 
    COUNT(*) AS total_rows,
    COUNT(department_id) AS non_null_department_id,
    COUNT(department) AS non_null_department
FROM ic_departments;

| "total_rows" | "non_null_department_id" | "non_null_department" |
|--------------|--------------------------|-----------------------|
| 21           | 21                       | 21                    |


-- Check for missing values in ic_aisles table
SELECT 
    COUNT(*) AS total_rows,
    COUNT(aisle_id) AS non_null_aisle_id,
    COUNT(aisle) AS non_null_aisle
FROM ic_aisles;

| "total_rows" | "non_null_aisle_id" | "non_null_aisle"                   |
|--------------|---------------------|------------------------------------|
| 134          | 134                 | 134                                |

-- Total number of unique products ordered in the current quarter (Q3)
SELECT COUNT (DISTINCT product_id)
FROM ic_order_products_curr;

| "count" |
|---------|
| 39123   |

-- Total number of unique products ordered in the previous quarter (Q2)
SELECT COUNT (DISTINCT product_id)
FROM ic_order_products_prior;

| "count" |
|---------|
| 49677   |

-- Using CASE statement to convert 'reordered' into numerical values
SELECT
    order_id,
    product_id,
    add_to_cart_order,
    CASE WHEN reordered = 'true' THEN 1 ELSE 0 END AS reordered_numeric
FROM ic_order_products_curr
LIMIT 5;


-- Using CAST to convert 'reordered' into numerical values
SELECT
    order_id,
    product_id,
    add_to_cart_order,
    (reordered::boolean)::integer AS reordered_numeric
FROM ic_order_products_curr
LIMIT 5;

-- 3. Data Analysis

-- Create a view of the sampled data for the ic_order_products_prior
CREATE VIEW sampled_order_products_prior_view AS
SELECT * FROM ic_order_products_prior TABLESAMPLE SYSTEM (0.80);

-- Create a view of the sampled data for the ic_order_products_curr
CREATE VIEW sampled_order_products_curr_view AS
SELECT * FROM ic_order_products_curr TABLESAMPLE SYSTEM (0.80);


-- Average number of products per order in the current quarter (Q3)

-- CTE to calculate the number of products per order from sampled data
WITH order_product_counts_curr_cte AS (
	SELECT
		order_id, 
		COUNT(product_id) AS products_per_order
	FROM sampled_order_products_prior_view
	GROUP BY order_id
)

SELECT 
	ROUND(AVG(products_per_order), 0) AS avg_products_per_order
FROM order_product_counts_curr_cte;

| "avg_products_per_order" |
|--------------------------|
| 10                       |


-- Average number of products per order in previous quarter (Q2)

-- CTE to calculate the number of products per order from sampled data
WITH order_product_counts_prior_cte AS (
	SELECT
		order_id, 
		COUNT(product_id) AS products_per_order
	FROM sampled_order_products_prior_view
	GROUP BY order_id
)

SELECT 
	ROUND(AVG(products_per_order), 0) AS avg_products_per_order
FROM order_product_counts_prior_cte;

| "avg_products_per_order" |
|--------------------------|
| 10                       |


-- The 10 most reordered products for the current quarter (Q3)

WITH order_product_counts_curr_cte AS (
    SELECT
        order_id,
        COUNT(product_id) AS products_per_order
    FROM sampled_order_products_curr_view
    GROUP BY order_id
)

SELECT
    products.product_id,
    products.product_name,
    COUNT(current_order.reordered) AS total_reordered
FROM ic_order_products_curr AS current_order
INNER JOIN ic_products AS products
	ON current_order.product_id = products.product_id
GROUP BY products.product_id, products.product_name
ORDER BY total_reordered DESC
LIMIT 10;

| "product_id" | "product_name"           | "total_reordered" |
|--------------|--------------------------|-------------------|
| 24852        | "Banana"                 | 18726             |
| 13176        | "Bag of Organic Bananas" | 15480             |
| 21137        | "Organic Strawberries"   | 10894             |
| 21903        | "Organic Baby Spinach"   | 9784              |
| 47626        | "Large Lemon"            | 8135              |
| 47766        | "Organic Avocado"        | 7409              |
| 47209        | "Organic Hass Avocado"   | 7293              |
| 16797        | "Strawberries"           | 6494              |
| 26209        | "Limes"                  | 6033              |
| 27966        | "Organic Raspberries"    | 5546              |



-- The 10 most reordered products for the previous quarter (Q2)

WITH order_product_counts_prior_cte AS (
    SELECT
        order_id,
        COUNT(product_id) AS products_per_order
    FROM sampled_order_products_prior_view
    GROUP BY order_id
)

SELECT
    products.product_id,
    products.product_name,
    COUNT(prior_order.reordered) AS total_reordered
FROM ic_order_products_prior AS prior_order
INNER JOIN ic_products AS products
	ON prior_order.product_id = products.product_id
GROUP BY products.product_id, products.product_name
ORDER BY total_reordered DESC
LIMIT 10;

| "product_id" | "product_name"           | "total_reordered" |
|--------------|--------------------------|-------------------|
| 24852        | "Banana"                 | 472565            |
| 13176        | "Bag of Organic Bananas" | 379450            |
| 21137        | "Organic Strawberries"   | 264683            |
| 21903        | "Organic Baby Spinach"   | 241921            |
| 47209        | "Organic Hass Avocado"   | 213584            |
| 47766        | "Organic Avocado"        | 176815            |
| 47626        | "Large Lemon"            | 152657            |
| 16797        | "Strawberries"           | 142951            |
| 26209        | "Limes"                  | 140627            |
| 27845        | "Organic Whole Milk"     | 137905            |


-- Products reordered less than 10 times in Q2 that have been reordered more than 10 or more times in Q3

SELECT
      products.product_id,
      products.product_name,
      products.aisle_id,
      products.department_id,
      departments.department,
      aisles.aisle,
      SUM(CASE WHEN prior_orders.reordered::int = 1 THEN 1 ELSE 0 END) AS prior_reorders,
      SUM(CASE WHEN curr_orders.reordered::int = 1 THEN 1 ELSE 0 END) AS curr_reorders
  FROM
      ic_products AS products
  JOIN
      sampled_order_products_prior_view AS prior_orders
      ON products.product_id = prior_orders.product_id
  JOIN
      sampled_order_products_curr_view AS curr_orders
      ON products.product_id = curr_orders.product_id
  JOIN
      ic_departments AS departments
      ON products.department_id = departments.department_id
  JOIN
      ic_aisles AS aisles
      ON products.aisle_id = aisles.aisle_id
  GROUP BY
      products.product_id,
      products.product_name,
      products.aisle_id,
      products.department_id,
      departments.department,
      aisles.aisle
  HAVING
      SUM(CASE WHEN prior_orders.reordered::int = 1 THEN 1 ELSE 0 END) < 10
      AND SUM(CASE WHEN curr_orders.reordered::int = 1 THEN 1 ELSE 0 END) >= 10
  ORDER BY
      curr_reorders DESC;


| product_id | product_name                               | aisle_id | department_id | department  | aisle                           | prior_reorders  | curr_reorders |
|------------|--------------------------------------------|----------|---------------|-------------|---------------------------------|----------------|---------------|
| 16462      | Ready-to-Bake 9 Inch Pie Crusts            | 105      | 13            | pantry      | doughs gelatins bake mixes      | 8              | 38            |
| 44303      | Organic Shredded Unsweetened Coconut       | 17       | 13            | pantry      | baking ingredients              | 6              | 35            |
| 8006       | Chopped Organic Garlic                     | 110      | 13            | pantry      | pickled goods olives            | 4              | 34            |
| 45002      | Organic Balsamic Vinegar Of Modena         | 19       | 13            | pantry      | oils vinegars                   | 9              | 32            |
| 35269      | Vegetable Tray With Low Fat Dressing       | 32       | 4             | produce     | packaged produce                | 6              | 30            |
| 19767      | Old Fashioned Oatmeal                      | 130      | 14            | breakfast   | hot cereal pancake mixes        | 6              | 30            |
| 43920      | Organic Powdered Sugar                     | 17       | 13            | pantry      | baking ingredients              | 3              | 27            |
| 17679      | San Marzano Peeled Tomatoes                | 81       | 15            | canned goods| canned jarred vegetables        | 8              | 26            |
| 9871       | Beef Loin New York Strip Steak             | 122      | 12            | meat seafood| meat counter                    | 8              | 26            |
| 25861      | Freshly Shaved Parmesan Cheese             | 21       | 16            | dairy eggs | packaged cheese                  | 6              | 26            |
...
| Total: 289 rows                                   |

