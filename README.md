
# 🛒 Zepto Inventory & Pricing Analysis – Quick Commerce Retail

_Analyzing product pricing, discounting, and inventory patterns across a quick-commerce grocery catalog using SQL._

---

## 📌 Table of Contents
- <a href="#overview">Overview</a>
- <a href="#business-problem">Business Problem</a>
- <a href="#dataset">Dataset</a>
- <a href="#tools--technologies">Tools & Technologies</a>
- <a href="#project-structure">Project Structure</a>
- <a href="#data-cleaning--preparation">Data Cleaning & Preparation</a>
- <a href="#exploratory-data-analysis-eda">Exploratory Data Analysis (EDA)</a>
- <a href="#research-questions--key-findings">Research Questions & Key Findings</a>
- <a href="#how-to-run-this-project">How to Run This Project</a>
- <a href="#final-recommendations">Final Recommendations</a>
- <a href="#author--contact">Author & Contact</a>

---
<h2><a class="anchor" id="overview"></a>Overview</h2>

This project explores a Zepto (quick-commerce grocery delivery) product catalog to uncover pricing, discounting, and inventory patterns across 14 categories. A complete SQL pipeline was built to clean the raw catalog data and answer targeted business questions around product value, stock availability, category revenue, and inventory weight distribution.

---
<h2><a class="anchor" id="business-problem"></a>Business Problem</h2>

Effective catalog and inventory management is critical for a quick-commerce platform to stay price-competitive while protecting margins. This project aims to:
- Identify the best-value, most-discounted products in the catalog
- Flag high-value products that are frequently out of stock
- Determine which categories generate the most estimated revenue
- Find premium products that are under-discounted relative to their price
- Identify which categories discount most aggressively
- Surface the best price-per-gram value products
- Understand how inventory is distributed across weight/package tiers
- Determine which categories carry the heaviest total inventory load

---
<h2><a class="anchor" id="dataset"></a>Dataset</h2>

- `zepto_v2.csv` — raw product catalog (category, name, MRP, discount %, available quantity, discounted selling price, weight in grams, stock status, order quantity)
- Loaded into a PostgreSQL table (`zepto`) for cleaning and analysis

---

<h2><a class="anchor" id="tools--technologies"></a>Tools & Technologies</h2>

- SQL (PostgreSQL — DDL, data cleaning, aggregation, filtering, `CASE` logic)
- GitHub

---
<h2><a class="anchor" id="project-structure"></a>Project Structure</h2>

```
zepto-inventory-analysis/
│
├── README.md
├── zepto_project.sql                       # Full SQL script: schema, cleaning, and analysis queries
├── zepto_v2.csv                             # Raw dataset
├── Zepto_Inventory_Analysis_Report.md       # Full write-up of findings
```

---
<h2><a class="anchor" id="data-cleaning--preparation"></a>Data Cleaning & Preparation</h2>

- Checked for and confirmed no null values across all columns
- Removed the one SKU with MRP and selling price both equal to 0 (invalid listing)
- Converted `mrp` and `discountedsellingprice` from paise to rupees
- Identified repeated product names (multiple SKUs per product across pack sizes) as expected catalog structure, not duplicates

---
<h2><a class="anchor" id="exploratory-data-analysis-eda"></a>Exploratory Data Analysis (EDA)</h2>

**Dataset Snapshot:**
- 3,731 rows after cleaning, across 14 categories
- 12.1% of SKUs (453) are out of stock
- Average discount across the catalog: 7.6%, ranging up to 51%

**Data Quality Notes:**
- One invalid zero-price row removed before analysis
- Several category pairs share identical row counts and, as a result, identical aggregate revenue/weight totals — flagged as a structural quirk in the source data

**Correlation Insights:**
- Very strong between MRP & Discounted Selling Price (0.97) — expected, since selling price is derived from MRP
- Weak between MRP & Discount % (0.17) — pricier items get only slightly deeper discounts
- Negligible between Weight & Discount % (0.01) — package size doesn't drive discount depth

---
<h2><a class="anchor" id="research-questions--key-findings"></a>Research Questions & Key Findings</h2>

1. **Best-Value Products**: Top discounts reach 51%, led by wafers, cheeses, and yogurts
2. **High-MRP Out-of-Stock Items**: 4 staple products above ₹300 MRP are out of stock, including ghee and atta
3. **Revenue by Category**: Ranges from ₹10.8K (Fruits & Vegetables) to ₹337K (Cooking Essentials / Munchies)
4. **Under-Discounted Premium Products**: 39 products above ₹500 MRP carry under 10% discount — mostly cooking oils and baby formula
5. **Top Discounting Categories**: Fruits & Vegetables (15.5%) and Meats, Fish & Eggs (11.0%) lead — consistent with moving perishables quickly
6. **Best Price-Per-Gram Value**: Bulk salt, onions, and potatoes offer the strongest value density
7. **Inventory by Weight Tier**: 91% of products fall under 1kg (Low tier), reflecting a small-basket, fast-delivery model
8. **Inventory Weight by Category**: Cooking Essentials and Munchies carry the heaviest total inventory load by far

📄 Full write-up with tables and commentary: [`Zepto_Inventory_Analysis_Report.md`](./Zepto_Inventory_Analysis_Report.md)

---
<h2><a class="anchor" id="how-to-run-this-project"></a>How to Run This Project</h2>

1. Clone the repository:
```bash
git clone https://github.com/yourusername/zepto-inventory-analysis.git
```
2. Load `zepto_v2.csv` into PostgreSQL (or your preferred SQL environment)
3. Run the full script to create the table, clean the data, and execute the analysis queries:
```bash
psql -d your_database -f zepto_project.sql
```
4. Review findings in [`Zepto_Inventory_Analysis_Report.md`](./Zepto_Inventory_Analysis_Report.md)

---
<h2><a class="anchor" id="final-recommendations"></a>Final Recommendations</h2>

- Restock high-MRP staples immediately to avoid disproportionate revenue loss
- Continue prioritizing deep discounts on perishables to prevent spoilage losses
- Test targeted promotions on under-discounted premium staples (oils, formula, hair color)
- Use commodity price-per-gram value (salt, onions, potatoes) as a marketing trust anchor
- Scale warehouse and logistics capacity to match Cooking Essentials and Munchies, the heaviest and highest-revenue categories
- Investigate the duplicated category-level totals in the source data before further modeling

---
<h2><a class="anchor" id="author--contact"></a>Author & Contact</h2>

**Ayaan Sayyed**  
Data Analyst  
📧 Email: ayaansayyed445@gmail.com  
🔗 [LinkedIn](https://www.linkedin.com/in/ayaan-sayyed-aba0a9250/)
