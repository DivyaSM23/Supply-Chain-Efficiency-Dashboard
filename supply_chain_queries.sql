-- ==========================================================
-- SUPPLY CHAIN EFFICIENCY DASHBOARD - SQL QUERIES
-- Dataset: Fashion and Beauty Startup (Makeup Products)
-- Description:
-- This file contains all SQL queries used for data analysis
-- and transformation before Power BI visualization.
-- ==========================================================

-- =============================
-- 1. Inspect raw tables
-- =============================

-- View first 10 records from each dataset
SELECT * FROM products LIMIT 10;
SELECT * FROM suppliers LIMIT 10;
SELECT * FROM production LIMIT 10;
SELECT * FROM inventory LIMIT 10;
SELECT * FROM orders LIMIT 10;
SELECT * FROM shipments LIMIT 10;
SELECT * FROM inspections LIMIT 10;
SELECT * FROM costs LIMIT 10;

-- =============================
-- 2. Join core datasets
-- =============================

-- Combine product, supplier, and production info
CREATE VIEW supply_chain_base AS
SELECT 
    p.SKU,
    p.Product_Type,
    p.Price,
    p.Availability,
    s.Supplier_Name,
    s.Location,
    pr.Manufacturing_Lead_Time,
    pr.Manufacturing_Costs,
    pr.Production_Volumes,
    i.Defect_Rates,
    i.Inspection_Results
FROM products p
LEFT JOIN suppliers s ON p.SKU = s.SKU
LEFT JOIN production pr ON p.SKU = pr.SKU
LEFT JOIN inspections i ON p.SKU = i.SKU;

-- =============================
-- 3. Revenue & Sales Metrics
-- =============================

-- Total revenue per product
CREATE VIEW revenue_per_product AS
SELECT 
    SKU,
    SUM(Revenue_Generated) AS Total_Revenue,
    SUM(Number_of_Products_Sold) AS Total_Units_Sold,
    AVG(Price) AS Avg_Price
FROM products
GROUP BY SKU
ORDER BY Total_Revenue DESC;

-- =============================
-- 4. Supplier Performance
-- =============================

-- Average lead time and defect rate per supplier
CREATE VIEW supplier_performance AS
SELECT 
    s.Supplier_Name,
    s.Location,
    AVG(pr.Lead_Time) AS Avg_Lead_Time,
    AVG(i.Defect_Rates) AS Avg_Defect_Rate,
    SUM(pr.Production_Volumes) AS Total_Production
FROM suppliers s
JOIN production pr ON s.SKU = pr.SKU
JOIN inspections i ON s.SKU = i.SKU
GROUP BY s.Supplier_Name, s.Location
ORDER BY Avg_Lead_Time;

-- =============================
-- 5. Inventory Efficiency
-- =============================

-- Stock turnover rate: how fast inventory sells
CREATE VIEW inventory_efficiency AS
SELECT 
    inv.SKU,
    inv.Stock_Levels,
    o.Number_of_Products_Sold,
    ROUND(o.Number_of_Products_Sold / NULLIF(inv.Stock_Levels, 0), 2) AS Stock_Turnover_Rate
FROM inventory inv
JOIN orders o ON inv.SKU = o.SKU;

-- =============================
-- 6. Shipping & Logistics Analysis
-- =============================

-- Average shipping cost and time per carrier
CREATE VIEW shipping_summary AS
SELECT 
    Shipping_Carriers,
    ROUND(AVG(Shipping_Costs), 2) AS Avg_Shipping_Cost,
    ROUND(AVG(Shipping_Times), 2) AS Avg_Shipping_Time,
    COUNT(SKU) AS Total_Shipments
FROM shipments
GROUP BY Shipping_Carriers
ORDER BY Avg_Shipping_Cost;

-- =============================
-- 7. Cost Analysis
-- =============================

-- Total supply chain cost per product
CREATE VIEW total_cost_analysis AS
SELECT 
    c.SKU,
    SUM(c.Costs) AS Total_Cost,
    AVG(c.Costs) AS Avg_Cost
FROM costs c
GROUP BY c.SKU
ORDER BY Total_Cost DESC;

-- =============================
-- 8. Profitability Analysis
-- =============================

-- Estimate profit margin per SKU
CREATE VIEW profit_margin AS
SELECT 
    r.SKU,
    r.Total_Revenue,
    t.Total_Cost,
    ROUND((r.Total_Revenue - t.Total_Cost), 2) AS Profit,
    ROUND(((r.Total_Revenue - t.Total_Cost) / NULLIF(t.Total_Cost, 0)) * 100, 2) AS Profit_Margin_Percent
FROM revenue_per_product r
JOIN total_cost_analysis t ON r.SKU = t.SKU
ORDER BY Profit DESC;

-- =============================
-- 9. End-to-End Supply Chain Overview
-- =============================

-- Combine all relevant KPIs
CREATE VIEW supply_chain_overview AS
SELECT 
    sb.SKU,
    sb.Product_Type,
    sb.Supplier_Name,
    sb.Location,
    sp.Avg_Lead_Time,
    sp.Avg_Defect_Rate,
    ie.Stock_Turnover_Rate,
    ss.Avg_Shipping_Cost,
    ss.Avg_Shipping_Time,
    pm.Profit_Margin_Percent
FROM supply_chain_base sb
LEFT JOIN supplier_performance sp ON sb.Supplier_Name = sp.Supplier_Name
LEFT JOIN inventory_efficiency ie ON sb.SKU = ie.SKU
LEFT JOIN shipping_summary ss ON sb.SKU = ss.Shipping_Carriers
LEFT JOIN profit_margin pm ON sb.SKU = pm.SKU;

-- =============================
-- 10. Export-ready summary
-- =============================

-- Final summarized data for Power BI import
SELECT * FROM supply_chain_overview;
