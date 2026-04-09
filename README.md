# Tech Layoffs SQL Analysis (2020–2024)

This is a complete end-to-end SQL project covering data cleaning, standardization, and exploratory data analysis (EDA) of global tech industry layoffs from March 2020 through early 2024, sourced from Kaggle. This project demonstrates how raw workforce event data can be transformed into decision-ready insights using SQL, replicating real-world analytics workflows used in People Analytics and Workforce Planning.
 
 ## Real-World Use Case
- Workforce planning during economic downturns
- Identifying high-risk industries for talent mobility
- Benchmarking layoffs vs funding efficiency

## Project Overview

### Context:
The global tech industry experienced significant workforce disruptions between 2020 and 2024, triggered by the COVID-19 pandemic and subsequent market corrections as major tech companies reversed aggressive pandemic-era hiring surges. This project was motivated by the need to analyze these layoffs in a structured way, using real-world data to uncover patterns, trends, and insights that can support business and economic decision-making. Understanding the scale, distribution, and patterns of these layoffs is valuable for analysts, job seekers, HR professionals, and business leaders to make informed decisions.
### Problem Statement:
This project addressed two connected challenges: first, how can a raw, uncleaned dataset of approximately 2,360 global tech layoff events be transformed into a reliable, analysis-ready resource? Second, which companies, industries, geographies, and time periods were most severely impacted between March 2020 and early 2024, and what patterns emerge around the distribution and drivers of tech layoffs when the data is examined at scale?
### Approach:
This project implemented a structured SQL workflow beginning with rigorous data cleaning — covering deduplication, standardization, NULL resolution, and type conversion — applied across dedicated staging tables to preserve the raw data. This was followed by an exploratory data analysis (EDA) phase answering 12 key business questions across company performance, industry impact, geographic distribution, and time-series trends, using aggregations, window functions, CTEs, and year-over-year rankings.
### Outcome:
The project produced a fully cleaned, analysis-ready dataset and a set of well-documented SQL scripts surfacing actionable insights into global tech layoffs across company, industry, geography, funding stage, and time dimensions. Together, these deliverables demonstrate end-to-end analytical SQL proficiency on a real-world dataset and provide a reusable framework applicable to similar workforce analytics projects. The insights uncovered in this project can help workforce planners identify structurally unstable industries and adjust hiring forecasts accordingly.

---

## Key Findings


- **Scale:** Between `[2020-03-11]` and `[2023-03-06]`, approximately `[1,628]` companies were affected, with a combined `[383,659]` people laid off across all layoff events. [see screenshot image Q1.](https://github.com/igbekoyiclementina/Tech-Layoffs-SQL-Analysis-2020-2024-/blob/main/Screenshot%20--%20Q1..png)

- **Shutdowns:** `[116]` companies cut 100% of their workforce, including several that had raised over `$100M` in funding prior to closing. The several companies that raised >$100M but still shut down shows inefficiency in their process/system [see screenshot image Q2.](https://github.com/igbekoyiclementina/Tech-Layoffs-SQL-Analysis-2020-2024-/blob/main/Screenshot%20--%20Q2..png) [see screenshot image 4b.](https://github.com/igbekoyiclementina/Tech-Layoffs-SQL-Analysis-2020-2024-/blob/main/Screenshot%20--%20Q4b..png) 

- **Company:** Companies such as Amazon, Google, Meta and Salesforce had the most cumulative layoffs across all events, of 18150, 12000, 11000, 10090 total staff layoffs, and 3, 1, 1, 4 layoff events respectively. [see screenshot image Q3.](https://github.com/igbekoyiclementina/Tech-Layoffs-SQL-Analysis-2020-2024-/blob/main/Screenshot%20--%20Q3..png)

Netflix, Meta, Uber had major layoffs being despite highly-funded, which shows that high funding does not equate the need for large workforce. [see screenshot image Q4a.](https://github.com/igbekoyiclementina/Tech-Layoffs-SQL-Analysis-2020-2024-/blob/main/Screenshot%20--%20Q4a..png)

- **Industry:** `[Consumer]` led in total headcount reductions. `[Education]` had the highest average percentage of workforce cut among industries with 5+ events.
The top 5 industries that had the highest total headcount reductions are Consumer (45182), Retail (43613), Transportation (33748), Finance (28344), 
Healthcare (25953), while the least 5 industries are Legal (836), Energy (802), Aerospace (661), Fin-Tech (215), Manufacturing (20). [see screenshot image Q5.](https://github.com/igbekoyiclementina/Tech-Layoffs-SQL-Analysis-2020-2024-/blob/main/Screenshot%20--%20Q5..png)

The top 5 industries that had the highest average % of workforce cut are Education, Travel, Food, Recruiting and Real Estate with average percentage laid off as 35.7, 34.9, 32.3, 32.3 and 31.7 respectively. [see screenshot image Q6.](https://github.com/igbekoyiclementina/Tech-Layoffs-SQL-Analysis-2020-2024-/blob/main/Screenshot%20--%20Q6..png) 

- **Geography:** While the top 5 countries with most layoffs are United States, India, Netherlands, Sweden and Brazil, the United States accounted for the vast majority of total layoffs, with the SF Bay Area, Seattle, and New York ranking as the top three US locations. [see screenshot image Q7.](https://github.com/igbekoyiclementina/Tech-Layoffs-SQL-Analysis-2020-2024-/blob/main/Screenshot%20--%20Q7..png)
 [see screenshot image Q8.](https://github.com/igbekoyiclementina/Tech-Layoffs-SQL-Analysis-2020-2024-/blob/main/Screenshot%20--%20Q8.%20.png)

- **Peak period:** Layoffs peaked in Q1 2023, aligning with macroeconomic tightening [see screenshot image Q9.](https://github.com/igbekoyiclementina/Tech-Layoffs-SQL-Analysis-2020-2024-/blob/main/Screenshot%20--%20Q9..png)

The rolling 3-month total peaked around `[March 2023]`, coinciding with the post-pandemic correction period when major tech companies reversed pandemic-era hiring surges. [see screenshot image Q10.](https://github.com/igbekoyiclementina/Tech-Layoffs-SQL-Analysis-2020-2024-/blob/main/Screenshot%20--%20Q10..png)

- **Funding stage:** Companies that are at the Post IPO stage had the most layoffs of 204,132 in total, which depicts that most companies in this stage are actively involved in executing growth strategies, dealing with stock price fluctuations, navigating strict reporting/compliance requirements, and managing investor relations which might result into downsizing as a part of growth strategy. [see screenshot image Q11.](https://github.com/igbekoyiclementina/Tech-Layoffs-SQL-Analysis-2020-2024-/blob/main/Screenshot%20--%20Q11..png)

- **Year-over-year:** In 2020, layoffs were concentrated in travel and consumer sectors. By 2022–2023, the largest cuts shifted to core tech — Amazon, Meta, and Google entered the top rankings. [see screenshot image Q12a.](https://github.com/igbekoyiclementina/Tech-Layoffs-SQL-Analysis-2020-2024-/blob/main/Screenshot%20--%20Q12a..png) [see screenshot image Q12b.](https://github.com/igbekoyiclementina/Tech-Layoffs-SQL-Analysis-2020-2024-/blob/main/Screenshot%20--%20Q12b..png)

---

## Project Structure

```
tech-layoffs-sql-project/
│
├── README.md
│
├── data/
│   └── layoffs.csv          ← Raw dataset (download from Kaggle — link below)
│
└── queries/
    ├── 01_data_cleaning.sql          ← Full cleaning pipeline (staging, deduplication, standardization)
    └── 02_exploratory_analysis.sql   ← 12 business questions answered across 7 analytical sections
```

---

## Dataset

| Detail | Info |
|---|---|
| Source | [Kaggle — Layoffs 2022 by swaptr](https://www.kaggle.com/datasets/swaptr/layoffs-2022) |
| Rows | ~2,360 layoff events |
| Columns | 9 — `company`, `location`, `industry`, `total_laid_off`, `percentage_laid_off`, `date`, `stage`, `country`, `funds_raised_millions` |
| Coverage | March 2020 – early 2024 |
| Tool | MySQL 8.0+ |

---

## Project Review

## Part 1: Data Cleaning

The raw dataset required significant cleaning before any reliable analysis could be carried out. The cleaning process followed a strict staging-first methodology, the raw table was never modified directly. All transformations were applied to dedicated staging tables, preserving the original data throughout, which is a best practice.

## Cleaning Workflow

**Step 1 — Creating the staging table**

I created a replica of the raw `layoffs` table named `layoffs_staging` using `CREATE TABLE ... LIKE` and populated it with `INSERT INTO ... SELECT`. This ensured the original data remained untouched for the entire project.

**Step 2 — To identify and remove duplicates**

Because the dataset had no unique row identifier, I used `ROW_NUMBER()` with `PARTITION BY` across all meaningful columns — `company`, `location`, `industry`, `total_laid_off`, `percentage_laid_off`, `date`, `stage`, `country`, and `funds_raised_millions` to flag exact duplicate rows. A second staging table (`layoffs_staging2`) was then created with the row number column included, allowing duplicates (where `row_num > 1`) to be safely deleted. Individual companies like `Casper` were manually spot-checked before deletion to confirm that the flagged rows were genuine duplicates.

**Step 3 — To standardize text fields**

The three areas of inconsistency below were identified and corrected:

- **Company names:** `TRIM()` was applied to remove leading and trailing whitespace that would cause identical company names to group separately in the `GROUP BY` queries.
- **Industry names:** The `SELECT DISTINCT` audit revealed variations like `Crypto`, `Crypto Currency`, and `CryptoCurrency` all referring to the same industry. These were consolidated to `Crypto` using `UPDATE ... WHERE industry LIKE 'Crypto%'`.
- **Country names:** Spelling of `United States.` (with a trailing period) was found alongside `United States`. I used `TRIM(TRAILING '.' FROM country)` corrected all affected rows.

**Step 4 — Converting date format**

The `date` column was imported as a text string in `MM/DD/YYYY` format. The `STR_TO_DATE()` function was used to convert it to a proper MySQL `DATE` type, and `ALTER TABLE ... MODIFY COLUMN` was then applied to change the column's data type, which enabled date functions and chronological sorting in the EDA phase.

**Step 5 — Resolving NULL and blank values**

- Blank string values in the `industry` column were first converted to `NULL` for consistent handling.
- A self-join on `company` was used to fill missing `industry` values where another row for the same company had a valid entry (e.g. Airbnb had three rows and one of it had a NULL industry, so it was populated from the other rows).
- Rows where both `total_laid_off` and `percentage_laid_off` were `NULL` were removed entirely — these rows contained no usable numeric data and would have distorted aggregation results.

**Step 6 — To delete/drop the helper column**

The `row_num` column added earlier for deduplication was dropped using `ALTER TABLE ... DROP COLUMN` as it was no longer needed, leaving a clean, analysis-ready table.

---

## Part 2: Exploratory Data Analysis

Having cleaned the dataset in `layoffs_staging2`, the analysis was structured across 7 sections addressing 12 major business questions. Each query was designed to surface a distinct and meaningful insight to better understand the dataset and support real-world decision-making.

**A. Overview**

**Q1 — Overall scale of the tech layoffs dataset**

A single summary query using `COUNT(DISTINCT company)`, `SUM()`, `AVG()`, `MIN()`, and `MAX()` established the headline numbers for the entire dataset, showing how many unique companies were affected, the total headcount lost, the average percentage of workforce cut, and the full date range covered.

**Q2 — Companies that shut down entirely**

Filtering on `percentage_laid_off = 1` (where `1` represents 100% in the decimal-stored column) and ordering by `total_laid_off DESC` surfaced every company that fully closed during this period, ranging from small startups to well-funded operations. Including `funds_raised_millions` in the output highlighted cases where significant venture capital was raised prior to complete collapse.

**B. Company Level**

**Q3 — Cumulative layoffs per company across all events**

Because a large company like Amazon or Meta may appear in the dataset multiple times (one row per layoff round), `SUM(total_laid_off)` grouped by `company` was required to calculate true cumulative totals of layoff events. Additional columns for `COUNT(*)` (number of separate layoff events), `MIN(date)`, and `MAX(date)` added context about the timeline of each company's cuts. Results were limited to the top 15.

**Q4a — Highly-funded companies with major layoffs**

Grouping by `company`, `industry`, `stage`, and `funds_raised_millions` and ordering by `funds_raised_millions DESC` revealed which best-funded companies still experienced the largest absolute headcount reductions, highlighting cases where funding alone did not protect against workforce cuts.

**Q4b — Companies with 100% layoffs despite funding**

An extension of Q4a filtered to `percentage_laid_off = 1` to specifically surface companies that received significant funding yet still shut down entirely, providing an analytically striking contrast between capital raised and operational survival.

**C. Industry Level**

**Q5 — Industries with highest total headcount reductions**

Aggregating `SUM(total_laid_off)` by `industry` alongside `COUNT(DISTINCT company)` and `AVG(total_laid_off)` provided a complete picture of which sectors were hit hardest in absolute terms, and whether that impact was spread across many companies or concentrated in a few.

**Q6 — Industries with highest average percentage of workforce cut**

`AVG(percentage_laid_off)` by industry, combined with `HAVING COUNT(*) >= 5` to exclude industries with insufficient data points, surfaced sectors where layoffs were proportionally severe relative to total headcount, a more meaningful measure of structural damage than aggregate numbers alone.

**D. Geographical Locations**

**Q7 — Countries most affected by total layoffs**

Grouping by `country` with `SUM(total_laid_off)` and `COUNT(DISTINCT company)` produced a global ranking of affected nations, revealing the geographic concentration of tech workforce reductions.

**Q8 — US cities with the most layoffs**

Filtering on `country = 'United States'` and grouping by `location`, this query used the dataset's city-level location field to surface which US tech hubs experienced the greatest absolute headcount losses, providing a more granular domestic picture beyond country-level totals.

**E. Time Series**

**Q9 — Monthly layoff trend (2020–2024)**

Using `SUBSTRING(date, 1, 7)` to extract the `YYYY-MM` portion of each date enabled month-level grouping without a separate date column. This produced a chronological month-by-month view of layoff volume, making it possible to identify peaks, troughs, and the overall trajectory of the layoff cycle over time.

**Q10 — Rolling 3-months total and cumulative total**

A CTE (`monthly_totals`) was used to first calculate total layoffs per month. The outer query then applied two window functions on top of that result:

- `SUM() OVER (ORDER BY year_month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)` , a rolling 3-months window that smooths out single-month spikes and highlights trend direction.
- `SUM() OVER (ORDER BY year_month)` , a running cumulative total showing the compounding scale of layoffs over the full period.

**F. Funding Stage**

**Q11 — Layoff patterns by company funding stage**

Grouping by `stage` (Seed, Series A–D, Post-IPO, Acquired, etc.) and calculating both `SUM(total_laid_off)` and `AVG(percentage_laid_off)` revealed how funding stage affects the scale and severity of layoffs. Post-IPO companies tended to dominate in raw headcount due to larger workforces; early-stage public listed companies frequently appeared at the higher percentage end.

**G. Year-over-Year Rankings**

**Q12 — Top 5 companies per year using `DENSE_RANK()`**

Two CTEs were chained together. The first (`yearly_company_totals`) summed layoffs per company per year using `YEAR(date)`, while the second (`ranked`) applied `DENSE_RANK() OVER (PARTITION BY year ORDER BY total_laid_off DESC)` — the `PARTITION BY year` clause resets the rank counter at the start of each year, producing an independent top-5 list per year rather than a single global ranking. The outer query filtered to `company_rank <= 5` to return the final result. An alternative version using named CTE columns (`Company_Year`, `Company_Year_Rank`) was also written to demonstrate the same logic with a slightly different CTE structuring approach.

---

## SQL Skills Demonstrated

| Skill | Where Used |
|---|---|
| Staging table strategy (`CREATE TABLE LIKE`) | Data Cleaning — Step 1 |
| `ROW_NUMBER() OVER (PARTITION BY ...)` | Data Cleaning — Step 2 (deduplication) |
| `TRIM()`, `TRIM(TRAILING ...)` | Data Cleaning — Step 3 (standardization) |
| `STR_TO_DATE()`, `ALTER TABLE MODIFY COLUMN` | Data Cleaning — Step 4 (type conversion) |
| Self-join (`JOIN ... ON t1.company = t2.company`) | Data Cleaning — Step 5 (NULL backfill) |
| `COUNT(DISTINCT ...)`, `SUM()`, `AVG()`, `MIN()`, `MAX()` | EDA — Sections A through G |
| `GROUP BY` with multiple columns | EDA — Sections B, C, D, F |
| `HAVING` to filter aggregated results | EDA — Section C, Q6 |
| `SUBSTRING(date, 1, 7)` for month extraction | EDA — Section E |
| `CTE (WITH ... AS)` — single and chained | EDA — Sections E (Q10), G (Q12) |
| `SUM() OVER (ROWS BETWEEN ...)` — rolling window | EDA — Section E, Q10 |
| `SUM() OVER (ORDER BY ...)` — cumulative total | EDA — Section E, Q10 |
| `DENSE_RANK() OVER (PARTITION BY year ...)` | EDA — Section G, Q12 |
| `YEAR()`, `SUBSTRING()` for date part extraction | EDA — Sections E and G |

---

## How to Run This Project

**Requirements:** MySQL 8.0 or later

1. Download `layoffs.csv` from [Kaggle](https://www.kaggle.com/datasets/swaptr/layoffs-2022) or from my GitHub Repository [Tina-layoff-Github](https://github.com/igbekoyiclementina/Tech-Layoffs-SQL-Analysis-2020-2024-/blob/main/layoffs.csv) and import it into MySQL as a table named `layoffs`.
2. Open (https://github.com/igbekoyiclementina/Tech-Layoffs-SQL-Analysis-2020-2024-/blob/main/Layoffs_Analysis.sql) and run it in full, this produces the `01_data_cleaning.sql` and `02_exploratory_analysis.sql` below
3. Open `01_data_cleaning.sql` and run it in full — this produces the cleaned `layoffs_staging2` table.
4. Open `02_exploratory_analysis.sql` and run each section in order — all queries read from `layoffs_staging2`.

---

## Author

Clementina Igbekoyi
Data Analyst | SQL | Excel | Power Bi | Tableau 
- *[linkedin](https://linkedin.com/in/clementinaigbekoyi)*
- *[GitHub](https://github.com/igbekoyiclementina)*

---

## License

Dataset sourced from Kaggle under its original license. All SQL scripts in this repository are free to use and adapt.

 
