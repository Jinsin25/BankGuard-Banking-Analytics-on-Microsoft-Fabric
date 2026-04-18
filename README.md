# BankGuard-Banking-Analytics-on-Microsoft-Fabric

## 🎯 What This Project Does

BankGuard is a banking analytics solution built on **Microsoft Fabric** that answers three questions every bank cares about:

1. 📊 **How are customers spending?** — Transaction trends, channel usage, top merchant categories
2. 💳 **Which loans are at risk?** — NPA tracking, overdue loans, customer risk segmentation
3. 🔍 **Who might default next?** — Simple rule-based credit risk scoring (beginner ML)

---

## 🏗️ Architecture

```
CSV Files (Simulated Bank Data)
         │
         ▼
  ┌─────────────┐
  │   BRONZE    │  ← Raw data as-is (PySpark Notebook)
  │  Lakehouse  │
  └──────┬──────┘
         │  Clean & Transform
         ▼
  ┌─────────────┐
  │   SILVER    │  ← Cleaned, typed, enriched (PySpark Notebook)
  │  Lakehouse  │
  └──────┬──────┘
         │  Aggregate for reporting
         ▼
  ┌─────────────┐
  │    GOLD     │  ← Final tables for dashboards (PySpark Notebook)
  │  Lakehouse  │
  └──────┬──────┘
         │
         ▼
  ┌─────────────┐
  │  Power BI   │  ← Executive dashboards
  │  Dashboard  │
  └─────────────┘
```


---

## 📁 Project Structure

```
bankguard-fabric/
│
├── 📂 notebooks/
│   ├── 01_load_bronze.ipynb         # Load raw CSVs into Lakehouse
│   ├── 02_transform_silver.ipynb    # Clean and enrich data
│   ├── 03_build_gold.ipynb          # Build reporting tables
│   └── 04_credit_risk_scoring.ipynb # Simple risk scoring (beginner ML)
│
├── 📂 sql/
│   ├── npa_report.sql               # NPA summary query
│   └── top_customers.sql            # Top customer analysis
│
├── 📂 data_samples/
│   ├── transactions.csv             # 500 sample transactions
│   ├── customers.csv                # 100 sample customers
│   └── loans.csv                    # 80 sample loans
│
├── 📂 docs/
│   ├── SETUP.md                     # How to set this up
│   └── DATA_DICTIONARY.md           # What each column means
│
└── README.md
```

---

## 📊 What Each Notebook Does

### Notebook 1 — Load Bronze
- Reads CSV files from the Lakehouse Files section
- Adds ingestion metadata (load date, source)
- Saves as Delta tables — no transformation yet

### Notebook 2 — Transform Silver
- Fixes data types (dates, decimals)
- Removes duplicate records
- Adds useful derived columns (age, transaction hour, NPA classification)
- Masks PII columns (email, phone)

### Notebook 3 — Build Gold
- Aggregates data for Power BI
- Creates `customer_summary`, `monthly_transactions`, `loan_portfolio_summary`
- These are the tables Power BI connects to

### Notebook 4 — Credit Risk Scoring
- Beginner-level: rule-based scoring (no complex ML libraries)
- Scores each customer 0–100 based on simple rules
- Saves scores to Gold for the dashboard

---

## 🛠️ Technologies Used

| Technology | What You Learn |
|---|---|
| Fabric Lakehouse | How OneLake stores Delta tables |
| PySpark Notebooks | Data transformation at scale |
| Delta Lake | ACID transactions, time travel |
| Fabric Warehouse (SQL) | Querying data with SQL |
| Power BI in Fabric | Building dashboards on top of Lakehouse |

---

## 📈 Sample Dashboard Pages (Power BI)

1. **Executive Overview** — Total transactions, total loan book, NPA ratio
2. **Transaction Analysis** — Spend by channel, by category, by month
3. **Loan Portfolio** — NPA breakdown, DPD distribution, loan type mix
4. **Customer Risk Map** — Risk segment distribution, high-risk customer list

---

## ⚙️ Setup (Step by Step)


**Quick start:**
1. Create a Fabric workspace (free trial works)
2. Create a Lakehouse named `bankguard`
3. Upload the 3 CSV files from `data_samples/`
4. Run the 4 notebooks in order
5. Connect Power BI to the Gold Lakehouse

---

## 📬 Skills Demonstrated

This project shows:
- ✅ Build a Medallion Architecture (Bronze → Silver → Gold)
- ✅ Write PySpark transformations in Fabric Notebooks
- ✅ Work with Delta tables on OneLake
- ✅ Write SQL queries on Fabric Data Warehouse
- ✅ Build a Power BI report on top of Fabric data
- ✅ Apply basic data quality checks

---
