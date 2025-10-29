import pandas as pd
import os

# Input file (your current combined CSV)
input_file = "supply_chain_data.csv"

# Output folder for divided CSVs
output_dir = "data"
os.makedirs(output_dir, exist_ok=True)

# Read the raw dataset
df = pd.read_csv(input_file)

# --- PRODUCTS TABLE ---
products = df[["SKU", "Product type", "Price"]].drop_duplicates().rename(
    columns={"Product type": "product_type", "Price": "price"}
)
products.to_csv(f"{output_dir}/products.csv", index=False)

# --- INVENTORY TABLE ---
inventory = df[["SKU", "Stock levels", "Availability"]].rename(
    columns={
        "Stock levels": "stock_level",
        "Availability": "availability"
    }
)
inventory["warehouse_name"] = "Main Warehouse"
inventory.to_csv(f"{output_dir}/inventory.csv", index=False)

# --- SUPPLIERS TABLE ---
suppliers = df[["Supplier name", "Location"]].drop_duplicates().reset_index(drop=True)
suppliers["supplier_id"] = suppliers.index + 1
suppliers = suppliers[["supplier_id", "Supplier name", "Location"]].rename(
    columns={"Supplier name": "supplier_name", "Location": "location"}
)
suppliers.to_csv(f"{output_dir}/suppliers.csv", index=False)

# --- PRODUCTION TABLE ---
production = df[["SKU", "Supplier name", "Production volumes", "Manufacturing lead time", "Manufacturing costs"]].rename(
    columns={
        "Supplier name": "supplier_name",
        "Production volumes": "production_volume",
        "Manufacturing lead time": "manufacturing_lead_time_days",
        "Manufacturing costs": "manufacturing_cost_per_unit"
    }
)
production = production.merge(suppliers, on="supplier_name", how="left")
production.drop(columns=["supplier_name", "location"], inplace=True)
production.to_csv(f"{output_dir}/production.csv", index=False)

# --- ORDERS TABLE ---
orders = df[["SKU", "Order quantities", "Number of products sold", "Revenue generated", "Customer demographics"]].rename(
    columns={
        "Order quantities": "order_quantity",
        "Number of products sold": "units_sold",
        "Revenue generated": "revenue",
        "Customer demographics": "customer_demographics"
    }
)
orders["order_id"] = range(1, len(orders) + 1)
orders.to_csv(f"{output_dir}/orders.csv", index=False)

# --- SHIPMENTS TABLE ---
shipments = df[["SKU", "Supplier name", "Shipping carriers", "Shipping times", "Shipping costs", "Transportation modes", "Routes", "Lead times"]].rename(
    columns={
        "Supplier name": "supplier_name",
        "Shipping carriers": "shipping_carrier",
        "Shipping times": "shipping_time_days",
        "Shipping costs": "shipping_cost",
        "Transportation modes": "transportation_mode",
        "Routes": "route",
        "Lead times": "lead_time_days"
    }
)
shipments = shipments.merge(suppliers, on="supplier_name", how="left")
shipments.drop(columns=["supplier_name", "location"], inplace=True)
shipments["shipment_id"] = range(1, len(shipments) + 1)
shipments.to_csv(f"{output_dir}/shipments.csv", index=False)

# --- INSPECTIONS TABLE ---
inspections = df[["SKU", "Inspection results", "Defect rates"]].rename(
    columns={
        "Inspection results": "inspection_result",
        "Defect rates": "defect_rate"
    }
)
inspections["inspection_id"] = range(1, len(inspections) + 1)
inspections.to_csv(f"{output_dir}/inspections.csv", index=False)

# --- COSTS SUMMARY TABLE (optional) ---
costs = df[["SKU", "Costs"]].rename(columns={"Costs": "total_cost"})
costs.to_csv(f"{output_dir}/costs.csv", index=False)

print(f"✅ Split completed! All files saved in folder: {output_dir}")
