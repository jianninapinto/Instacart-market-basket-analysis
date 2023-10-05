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


