# Supply Chain Efficiency Dashboard

This project focuses on analyzing and optimizing the **supply chain of a Fashion and Beauty startup** that produces makeup products.  
The project involves **data cleaning, SQL-based analysis, and Power BI dashboarding** to uncover insights into supplier performance, inventory efficiency, production bottlenecks, logistics costs, and profitability.

---

## 🎯 Objectives

1. **Build a relational supply chain database** by splitting the master dataset into domain-specific tables:
   - Products, Suppliers, Production, Orders, Inventory, Shipments, Inspections, and Costs.
2. **Perform SQL-based data analysis** to:
   - Measure supplier efficiency (lead time, defect rate).
   - Analyze production and manufacturing costs.
   - Assess inventory turnover and stock levels.
   - Evaluate logistics metrics (shipping time, carrier cost).
   - Compute total and average costs across the chain.
   - Calculate profit margins per SKU.
3. **Design an interactive Power BI dashboard** to visualize KPIs like:
   - Total Revenue, Total Cost, Profit Margin %
   - Stock Turnover Rate
   - Average Lead Time and Defect Rate by Supplier
   - Average Shipping Time and Cost by Carrier
   - End-to-End Supply Chain Overview

---

## 🧩 Dataset Description

The dataset simulates real-world supply chain data for a beauty products company.  
It includes information across multiple dimensions:

| Category | Key Features |
|-----------|---------------|
| **Product Data** | Product Type, SKU, Price, Availability, Revenue Generated |
| **Supplier Data** | Supplier Name, Location, Lead Time |
| **Production Data** | Manufacturing Lead Time, Costs, Production Volumes |
| **Inventory Data** | Stock Levels |
| **Orders Data** | Order Quantities, Products Sold |
| **Shipping Data** | Carriers, Routes, Times, Costs |
| **Inspection Data** | Inspection Results, Defect Rates |
| **Cost Data** | Overall supply chain costs |

---

## ⚙️ Tools and Technologies

- **Excel / Python (Pandas)** – Data cleaning and CSV creation  
- **SQL (PostgreSQL / MySQL / SQLite)** – Data querying and transformation  
- **Power BI** – Interactive dashboard creation and visualization  

---

## 🗃️ SQL Queries

All major transformations and KPI calculations were implemented using SQL.  
You can find the complete query list in the file [`supply_chain_queries.sql`](./supply_chain_queries.sql).

### Key SQL Operations Used:
- `SELECT`, `FROM`, `WHERE` – Data extraction  
- `JOIN` – Combining multiple tables (Products, Suppliers, etc.)  
- `GROUP BY`, `ORDER BY`, `HAVING` – Aggregation and ranking  
- `CREATE VIEW` – Creating reusable logical views  
- `ROUND()` and mathematical expressions – Deriving ratios and percentages  

### Main Analytical Views:
- `revenue_per_product` – Total revenue and sales per SKU  
- `supplier_performance` – Average lead time and defect rate per supplier  
- `inventory_efficiency` – Stock turnover rate  
- `shipping_summary` – Average cost and time by carrier  
- `profit_margin` – Profit and margin % per SKU  
- `supply_chain_overview` – End-to-end KPI summary (Power BI import table)

---

## 📊 Power BI Dashboard

The Power BI dashboard consolidates KPIs from all supply chain dimensions to enable decision-making through visual insights.

### Steps Followed:
1. **Data Connection**
   - Imported cleaned CSVs (`products.csv`, `suppliers.csv`, etc.) into Power BI.
   - Established relationships between tables using the SKU field.
   - Imported SQL views from `supply_chain_queries.sql`.

2. **Data Modeling**
   - Created calculated columns and DAX measures such as:
     - `Total Revenue = SUM(Products[Revenue Generated])`
     - `Total Cost = SUM(Costs[Costs])`
     - `Profit Margin % = DIVIDE([Total Revenue] - [Total Cost], [Total Cost]) * 100`
     - `Stock Turnover Rate = DIVIDE([Units Sold], [Stock Levels])`

3. **Dashboard Design**
   - Visuals included:
     - **Card visuals** for Total Revenue, Profit Margin %, Avg Lead Time
     - **Clustered bar charts** for supplier comparison
     - **Line charts** for revenue and cost trends
     - **Matrix/Table** for end-to-end KPI summary
     - **Slicers and filters** by product type, supplier, and carrier
     - **Maps** to visualize supplier locations and performance geographically

4. **Interactivity**
   - Added filters and slicers for real-time exploration.
   - Used drill-through to analyze supplier-level performance and cost breakdowns.

---

## 🧠 Insights Derived

- Identified suppliers with **high lead times and defect rates**, impacting product delivery timelines.  
- Found optimal **shipping carriers and routes** minimizing cost and delivery time.  
- Determined **low-performing SKUs** with poor sales-to-cost ratios.  
- Highlighted production units with **high manufacturing cost** but low output efficiency.  
- Calculated **overall profit margin improvement** opportunities through cost optimization.

---

## 🧾 Outcome

The project demonstrates how **data-driven decision-making** can enhance supply chain visibility and performance.  
It integrates **SQL analysis, data modeling, and Power BI visualization** to deliver a complete business intelligence solution.

---

## 📚 Skills Demonstrated

- Data Cleaning & Structuring  
- SQL Data Analysis  
- Power BI Dashboarding  
- Business Intelligence & KPI Design  
- Supply Chain Analytics  

---

