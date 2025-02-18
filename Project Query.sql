-- View the first 10 rows
SELECT TOP 10 * FROM Walmart_Data;

-- Count total records
SELECT COUNT(*) AS Total_Records FROM Walmart_Data;

-- Check unique categories
SELECT DISTINCT category FROM Walmart_Data;

-- Get total sales per year
SELECT year, SUM(Total_sale) AS Total_Sales 
FROM Walmart_Data 
GROUP BY year 
ORDER BY year;

-- Top 5 highest-selling categories
SELECT TOP 5 category, SUM(Total_sale) AS Sales 
FROM Walmart_Data 
GROUP BY category 
ORDER BY Sales DESC;

-- Monthly sales trend (if data spans multiple years)
SELECT YEAR(date) AS Year, MONTH(date) AS Month, SUM(Total_sale) AS Monthly_Sales
FROM Walmart_Data
GROUP BY YEAR(date), MONTH(date)
ORDER BY Year, Month;

-- Count of transactions per payment method
SELECT payment_method, COUNT(*) AS Transaction_Count
FROM Walmart_Data
GROUP BY payment_method
ORDER BY Transaction_Count DESC;

-- Total profit per category
SELECT category, SUM(Actual_profit) AS Total_Profit
FROM Walmart_Data
GROUP BY category
ORDER BY Total_Profit DESC;

-- Top 5 most profitable branches
SELECT TOP 5 Branch, SUM(Actual_profit) AS Profit
FROM Walmart_Data
GROUP BY Branch
ORDER BY Profit DESC;

-- Rank categories based on sales within each category
WITH CategorySales AS (
    SELECT category, 
           SUM(Total_sale) AS Total_Sales,
           RANK() OVER (PARTITION BY category ORDER BY SUM(Total_sale) DESC) AS Rank
    FROM Walmart_Data
    GROUP BY category
)
SELECT * FROM CategorySales WHERE Rank <= 3;

-- Monthly sales with growth rate
SELECT 
    YEAR(date) AS Sales_Year, 
    MONTH(date) AS Sales_Month, 
    SUM(Total_sale) AS Monthly_Sales, 
    LAG(SUM(Total_sale)) OVER (ORDER BY YEAR(date), MONTH(date)) AS Previous_Month_Sales,
    ((SUM(Total_sale) - LAG(SUM(Total_sale)) OVER (ORDER BY YEAR(date), MONTH(date))) / 
        NULLIF(LAG(SUM(Total_sale)) OVER (ORDER BY YEAR(date), MONTH(date)), 0)) * 100 AS Growth_Rate
FROM Walmart_Data
GROUP BY YEAR(date), MONTH(date)
ORDER BY Sales_Year, Sales_Month;

-- Top 5 profitable cities
SELECT TOP 5 City, SUM(Actual_profit) AS Total_Profit
FROM Walmart_Data
GROUP BY City
ORDER BY Total_Profit DESC;

-- Average order value per branch
SELECT Branch, AVG(Total_sale) AS Avg_Order_Value
FROM Walmart_Data
GROUP BY Branch
ORDER BY Avg_Order_Value DESC;

-- Average spending per order per category
SELECT category, 
       COUNT(*) AS Total_Transactions, 
       SUM(Total_sale) / COUNT(*) AS Avg_Spending_Per_Order
FROM Walmart_Data
GROUP BY category
ORDER BY Avg_Spending_Per_Order DESC;

-- Rank payment methods by transaction count per city
SELECT City, 
       payment_method, 
       COUNT(*) AS Payment_Count,
       RANK() OVER (PARTITION BY City ORDER BY COUNT(*) DESC) AS Rank
FROM Walmart_Data
GROUP BY City, payment_method;

-- Sales contribution per branch
SELECT Branch, 
       SUM(Total_sale) AS Total_Sales, 
       SUM(Total_sale) * 100 / (SELECT SUM(Total_sale) FROM Walmart_Data) AS Sales_Contribution_Percentage
FROM Walmart_Data
GROUP BY Branch
ORDER BY Sales_Contribution_Percentage DESC;

-- Sales per season
SELECT 
    CASE 
        WHEN MONTH(date) IN (12, 1, 2) THEN 'Winter'
        WHEN MONTH(date) IN (3, 4, 5) THEN 'Spring'
        WHEN MONTH(date) IN (6, 7, 8) THEN 'Summer'
        ELSE 'Fall'
    END AS Season,
    SUM(Total_sale) AS Total_Sales
FROM Walmart_Data
GROUP BY 
    CASE 
        WHEN MONTH(date) IN (12, 1, 2) THEN 'Winter'
        WHEN MONTH(date) IN (3, 4, 5) THEN 'Spring'
        WHEN MONTH(date) IN (6, 7, 8) THEN 'Summer'
        ELSE 'Fall'
    END
ORDER BY Total_Sales DESC;

-- Cumulative sales over time by year
SELECT 
    YEAR(date) AS Sales_Year, 
    MONTH(date) AS Sales_Month, 
    SUM(Total_sale) AS Monthly_Sales,
    SUM(SUM(Total_sale)) OVER (ORDER BY YEAR(date), MONTH(date)) AS Cumulative_Sales
FROM Walmart_Data
GROUP BY YEAR(date), MONTH(date)
ORDER BY Sales_Year, Sales_Month;

-- Total sales per city
SELECT City, SUM(total_sale) AS Total_Sales
FROM Walmart_Data
GROUP BY City
ORDER BY Total_Sales DESC;

-- Total sales per branch
SELECT Branch, SUM(total_sale) AS Total_Sales
FROM Walmart_Data
GROUP BY Branch
ORDER BY Total_Sales DESC;

-- Total profit per city
SELECT City, SUM(actual_profit) AS Total_Profit
FROM Walmart_Data
GROUP BY City
ORDER BY Total_Profit DESC;

-- Total profit per branch
SELECT Branch, SUM(actual_profit) AS Total_Profit
FROM Walmart_Data
GROUP BY Branch
ORDER BY Total_Profit DESC;

-- Total quantity sold per category
SELECT category, SUM(quantity) AS Total_Quantity_Sold
FROM Walmart_Data
GROUP BY category
ORDER BY Total_Quantity_Sold DESC;

-- Total revenue per category
SELECT category, SUM(total_sale) AS Total_Revenue
FROM Walmart_Data
GROUP BY category
ORDER BY Total_Revenue DESC;

-- Average order value per branch
SELECT Branch, AVG(total_sale) AS Avg_Order_Value
FROM Walmart_Data
GROUP BY Branch
ORDER BY Avg_Order_Value DESC;

-- Transaction count per payment method
SELECT payment_method, COUNT(*) AS Transaction_Count
FROM Walmart_Data
GROUP BY payment_method
ORDER BY Transaction_Count DESC;

-- Sales by month and year
SELECT year, MONTH(date) AS Month, SUM(total_sale) AS Total_Sales
FROM Walmart_Data
GROUP BY year, MONTH(date)
ORDER BY year, Month;

-- Yearly sales with growth rate
SELECT year, 
       SUM(total_sale) AS Total_Sales,
       LAG(SUM(total_sale)) OVER (ORDER BY year) AS Previous_Year_Sales,
       ((SUM(total_sale) - LAG(SUM(total_sale)) OVER (ORDER BY year)) / 
         NULLIF(LAG(SUM(total_sale)) OVER (ORDER BY year), 0)) * 100 AS Growth_Rate
FROM Walmart_Data
GROUP BY year
ORDER BY year;

-- Sales percentage per branch
SELECT Branch, 
       SUM(total_sale) AS Total_Sales, 
       SUM(total_sale) * 100 / (SELECT SUM(total_sale) FROM Walmart_Data) AS Sales_Percentage
FROM Walmart_Data
GROUP BY Branch
ORDER BY Sales_Percentage DESC;

-- Average unit price per category
SELECT category, AVG(unit_price) AS Avg_Unit_Price
FROM Walmart_Data
GROUP BY category
ORDER BY Avg_Unit_Price DESC;

-- Total transactions per year
SELECT year, COUNT(*) AS Total_Transactions
FROM Walmart_Data
GROUP BY year
ORDER BY year;

-- Total quantity sold per category
SELECT category, SUM(quantity) AS Total_Quantity_Sold
FROM Walmart_Data
GROUP BY category
ORDER BY Total_Quantity_Sold DESC;

-- Total profit per payment method
SELECT payment_method, SUM(actual_profit) AS Total_Profit
FROM Walmart_Data
GROUP BY payment_method
ORDER BY Total_Profit DESC;

-- Cities with lower than average sales
SELECT City, COUNT(*) AS Transactions, SUM(total_sale) AS Total_Sales
FROM Walmart_Data
GROUP BY City
HAVING SUM(total_sale) < (SELECT AVG(total_sale) FROM Walmart_Data)
ORDER BY Total_Sales;

-- Top 3 branches per city based on sales
WITH CityBranches AS (
    SELECT City, Branch, SUM(total_sale) AS Total_Sales,
           RANK() OVER (PARTITION BY City ORDER BY SUM(total_sale) DESC) AS Rank
    FROM Walmart_Data
    GROUP BY City, Branch
)
SELECT * FROM CityBranches WHERE Rank <= 3;

-- Cumulative sales over time by year
SELECT year, 
       SUM(total_sale) AS Monthly_Sales, 
       SUM(SUM(total_sale)) OVER (ORDER BY year) AS Cumulative_Sales
FROM Walmart_Data
GROUP BY year
ORDER BY year;

-- Branch performance ranking
SELECT Branch, 
       SUM(total_sale) AS Total_Sales, 
       SUM(actual_profit) AS Total_Profit, 
       RANK() OVER (ORDER BY SUM(actual_profit) DESC) AS Profit_Rank
FROM Walmart_Data
GROUP BY Branch;
