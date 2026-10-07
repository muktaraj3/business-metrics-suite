# SQL Business Metrics & Performance Suite

A structured repository containing production-grade SQL queries engineered to solve core business intelligence and operational reporting questions.

## Database Compatibility
* PostgreSQL 13+
* MySQL 8.0+
* Snowflake / BigQuery (with minor date function adjustments)

## Metrics Covered
1. **Financial Growth:** Month-over-Month (MoM) revenue velocity using window lag functions.
2. **Customer Retention:** Cohort-based retention tracking indexed by signup period.
3. **Product Performance:** Top-N ranked products by category via `DENSE_RANK()`.
4. **Trend Analysis:** Cumulative running totals and 7-day rolling moving averages.
5. **Marketing Segmentation:** RFM (Recency, Frequency, Monetary) quartiles via `NTILE()`.

## Quickstart
1. Clone the repository.
2. Run `Table_Creation.sql` inside your SQL client (DBeaver, pgAdmin, DataGrip).
3. Execute any script in the `/queries` folder to view the generated metrics.
