Create database project;
USE project;


SET SQL_SAFE_UPDATES = 0;

update project.blinkit_data
set project.blinkit_data.Item_Fat_Content =
case 
when project.blinkit_data.Item_Fat_Content in ('LF','low fat') then 'Low Fat'
when project.blinkit_data.Item_Fat_Content = 'reg' then 'Regular'
Else project.blinkit_data.Item_Fat_Content
End;

SET SQL_SAFE_UPDATES = 1;

-- Total Sales: The overall revenue generated from all items sold.

SELECT 
    ROUND(SUM(blinkit_data.Total_Sales), 2) AS Total_Revenue
FROM
    blinkit_data;
    
    
-- Average Sales: The average revenue per sale.


SELECT 
    ROUND(AVG(blinkit_data.Total_Sales), 2) AS Average_Revenue
FROM
    blinkit_data;



-- Number of Items: The total count of different items sold.


SELECT 
    COUNT(DISTINCT (blinkit_data.Item_Identifier)) AS Total_Items
FROM
    blinkit_data;
    
    
-- Average Rating: The average customer rating for items sold. 


SELECT 
    ROUND(AVG(blinkit_data.Rating), 2) AS Avg_Rating
FROM
    blinkit_data;
    
    
-- Total Sales by Fat Content:


SELECT 
    blinkit_data.Item_Fat_Content,
    ROUND(SUM(blinkit_data.Total_Sales)) AS Total_Revenue
FROM
    blinkit_data
GROUP BY blinkit_data.Item_Fat_Content;


-- Total Sales by Item Type:


SELECT 
    blinkit_data.Item_Type,
    ROUND(SUM(blinkit_data.Total_Sales), 2) AS Total_Revenue
FROM
    blinkit_data
GROUP BY blinkit_data.Item_Type
ORDER BY Total_Revenue DESC;



-- Fat Content by Outlet for Total Sales


SELECT 
    blinkit_data.Outlet_Location_Type,
    ROUND(SUM(CASE
                WHEN blinkit_data.Item_Fat_Content = 'Low Fat' THEN Total_Sales
                ELSE 0
            END),
            2) AS Low_Fat,
    ROUND(SUM(CASE
                WHEN blinkit_data.Item_Fat_Content = 'Regular' THEN Total_Sales
                ELSE 0
            END),
            2) AS Regular
FROM
    blinkit_data
GROUP BY blinkit_data.Outlet_Location_Type;


-- Total Sales by Outlet Establishment

SELECT 
    blinkit_data.Outlet_Establishment_Year,
    ROUND(SUM(blinkit_data.Total_Sales), 2) AS Total_Revenue
FROM
    blinkit_data
GROUP BY blinkit_data.Outlet_Establishment_Year
ORDER BY blinkit_data.Outlet_Establishment_Year;


-- Percentage of Sales by Outlet Size


SELECT 
    blinkit_data.Outlet_Size,
    ROUND(SUM(blinkit_data.Total_Sales) / (SELECT 
                    SUM(blinkit_data.Total_Sales)
                FROM
                    blinkit_data) * 100,
            2) AS Percentage_Sales
FROM
    blinkit_data
GROUP BY blinkit_data.Outlet_Size;


-- Sales by Outlet Location

SELECT 
    blinkit_data.Outlet_Location_Type,
    ROUND(SUM(blinkit_data.Total_Sales), 2) AS Total_Revenue
FROM
    blinkit_data
GROUP BY blinkit_data.Outlet_Location_Type
ORDER BY Total_Revenue DESC;



-- All Metrics by Outlet Type:


SELECT 
    blinkit_data.Outlet_Type,
    ROUND(SUM(blinkit_data.Total_Sales), 2) AS Total_Sales,
    ROUND(AVG(blinkit_data.Total_Sales)) AS Avg_Sales,
    COUNT(blinkit_data.Item_Identifier) AS Number_of_Items,
    ROUND(AVG(blinkit_data.Rating), 2) AS AVG_Rating
FROM
    blinkit_data
GROUP BY blinkit_data.Outlet_Type
ORDER BY Total_Sales DESC;
    


