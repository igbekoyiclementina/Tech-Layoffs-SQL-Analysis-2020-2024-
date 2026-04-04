-- ============================================================ -- 
-- DATA CLEANING

SELECT *
FROM layoffs;

-- The data cleaning steps:
-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Null values or blank values
-- 4. Remove any Columns not in use, but ensure to create stagging dataset

-- To create a staging table by replicating our raw file.
CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT *
FROM layoffs_staging;

INSERT layoffs_staging
SELECT *
FROM layoffs;

-- To create rows numbers that helps with the removing of duplicates as there is no unique identifier for each row/data in this table
SELECT *,
ROW_NUMBER () OVER(
PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`) AS row_num
FROM layoffs_staging;

-- To validate the duplicates before removing them

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER () OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, 
country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

-- To double check the dataset in each of the duplicate observed in the table

SELECT *
FROM layoffs_staging
WHERE company = 'Casper';

-- To delete the exact duplicates from the one we want to keep
-- Let us first create a new database named layoffs_staging2 before proceeding to delete duplicates

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER () OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, 
country, funds_raised_millions) AS row_num
FROM layoffs_staging;

SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

SELECT @@SQL_SAFE_UPDATES;

DELETE
FROM layoffs_staging2
WHERE row_num > 1;

SELECT *
FROM layoffs_staging2
ORDER BY country;

-- Standardizing the data

-- Removing excess space using Trim
SELECT company, TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

-- To check/view the categories of industries we have in this database, to aid proper Standardization
SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;

SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

-- The Standardization
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- To fix country trailing periods (.)
SELECT *
FROM layoffs_staging2
WHERE country LIKE 'United States%';

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

-- To change the date format from text to date format

SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

SELECT *
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;


-- Working to clean Null values or blanks

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';

SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';

SELECT t1.industry, t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;


-- Deleting 

-- Remove rows where both laid off columns are NULL
SELECT *
FROM layoffs_staging2
WHERE company LIKE 'Bally%';

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- To delete an entire column 
SELECT *
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

-- ============================================================ -- 
-- Exploratory Data Analysis 
-- Tech Layoffs Project (2020–2024)

-- ============================================================ -- 
-- A. OVERVIEW 
SELECT *
FROM layoffs_staging2;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;

-- Q1. What is the overall scale of tech layoffs? (total companies, people, date range)
SELECT
    COUNT(DISTINCT company)              AS companies_affected,
    SUM(total_laid_off)                  AS total_people_laid_off,
    ROUND(AVG(percentage_laid_off) * 100, 1) AS avg_pct_laid_off,
    MIN(`date`)                     AS earliest_layoff,
    MAX(`date`)                     AS latest_layoff
FROM layoffs_staging2;

-- Q2. Which companies shut down entirely (100% laid off)?
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

-- ============================================================ -- 
-- B. COMPANY LEVEL 

-- Q3. Which companies had the most cumulative layoffs across all events?
-- A company like Amazon appear many times (one row per layoff event), so SUM groups them all together to get the true total per company

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT 
    company, 
    SUM(total_laid_off)   AS total_laid_off,
    COUNT(*)              AS layoff_events,       -- how many separate rounds/ lay off event
    MIN(`date`)           AS first_layoff,        -- when did they start the cutting / lay off
    MAX(`date`)           AS latest_layoff        -- most recent cut / lay off
FROM layoffs_staging2
WHERE total_laid_off IS NOT NULL
GROUP BY company
ORDER BY 2 DESC
LIMIT 15;

-- Q4a. Which companies had major layoffs being despite highly-funded? -- Limit it to 15

SELECT
    company,
    industry,
    stage,
    ROUND(funds_raised_millions, 0)  AS funds_raised_millions,
    SUM(total_laid_off)              AS total_laid_off,
    COUNT(*)                         AS layoff_events
FROM layoffs_staging2
WHERE funds_raised_millions IS NOT NULL
  AND total_laid_off IS NOT NULL
GROUP BY company, industry, stage, funds_raised_millions
ORDER BY funds_raised_millions DESC
LIMIT 15;

-- Q4b. Companies that had 100% layoffs despite funding
SELECT
    company,
    industry,
    stage,
    ROUND(funds_raised_millions, 0)  AS funds_raised_in_millions,
    SUM(total_laid_off)              AS total_laid_off,
    COUNT(*)                         AS layoff_events,
    percentage_laid_off
FROM layoffs_staging2
WHERE percentage_laid_off = 1
	AND funds_raised_millions IS NOT NULL
  AND total_laid_off IS NOT NULL
GROUP BY company, industry, stage, funds_raised_millions, percentage_laid_off
ORDER BY funds_raised_millions DESC;

-- ============================================================ -- 
-- C. INDUSTRY LEVEL

-- Q5. Which industries had the highest total headcount reductions?
SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

SELECT
    industry,
    COUNT(DISTINCT company)           AS companies_affected,
    SUM(total_laid_off)               AS total_laid_off,
    ROUND(AVG(total_laid_off), 0)     AS avg_laid_off_per_event
FROM layoffs_staging2
WHERE industry IS NOT NULL
  AND total_laid_off IS NOT NULL
GROUP BY industry
ORDER BY total_laid_off DESC;


-- Q6. Which industries had the highest average % of workforce cut?

SELECT
    industry,
    COUNT(*)                                    AS layoff_events,
    ROUND(AVG(percentage_laid_off) * 100, 1)   AS avg_pct_laid_off,
    ROUND(MAX(percentage_laid_off) * 100, 1)   AS max_pct_laid_off,
    ROUND(MIN(percentage_laid_off) * 100, 1)   AS min_pct_laid_off
FROM layoffs_staging2
WHERE industry IS NOT NULL
  AND percentage_laid_off IS NOT NULL
GROUP BY industry
HAVING layoff_events >= 5
ORDER BY avg_pct_laid_off DESC;

-- ============================================================ -- 
-- D. GEOGRAPHICAL LOCATIONS

-- Q7. Which countries were most affected by the total layoffs?
SELECT
    country,
    COUNT(DISTINCT company)   AS companies_affected,
    SUM(total_laid_off)       AS total_laid_off,
    COUNT(*)                  AS layoff_events
FROM layoffs_staging2
WHERE total_laid_off IS NOT NULL
GROUP BY country
ORDER BY total_laid_off DESC
LIMIT 15;

SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;
 
 
-- Q8. Which US cities had the most layoffs?
-- To achieve this I filtered to United States only, then group by the location column

SELECT
    location,
    COUNT(DISTINCT company)   AS companies,
    SUM(total_laid_off)       AS total_laid_off,
    COUNT(*)                  AS layoff_events
FROM layoffs_staging2
WHERE country = 'United States'
  AND total_laid_off IS NOT NULL
GROUP BY location
ORDER BY total_laid_off DESC
LIMIT 15;


-- ---- -- ---- -- ---- -- ----
SELECT VERSION();
-- ---- -- ---- -- ---- -- ----

-- ============================================================ -- 
-- E. TIME SERIES

SELECT *
FROM layoffs_staging2;

-- Q9. What does the monthly layoff trend look like from 2020–2024?

SELECT
    SUBSTRING(`date`, 1, 7)    AS `year_month`,
    SUBSTRING(`date`, 6, 2)    AS `month`,
    COUNT(DISTINCT company)    AS companies,
    SUM(total_laid_off)        AS monthly_laid_off
FROM layoffs_staging2
WHERE `date` IS NOT NULL
  AND total_laid_off IS NOT NULL
GROUP BY `year_month`, `month`
ORDER BY `year_month`, `month` ASC;
 
-- Q10. Rolling 3-month total AND cumulative total over time

WITH monthly_totals AS (
    SELECT
        SUBSTRING(`date`, 1, 7)   AS `year_month`,
        SUM(total_laid_off)       AS monthly_laid_off
    FROM layoffs_staging2
    WHERE `date` IS NOT NULL
      AND total_laid_off IS NOT NULL
    GROUP BY `year_month`
)
SELECT
    `year_month`,
    monthly_laid_off,
    SUM(monthly_laid_off) OVER (
        ORDER BY `year_month`
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    )                             AS rolling_3mo_total,
    SUM(monthly_laid_off) OVER (
        ORDER BY `year_month`
    )                             AS cumulative_total
FROM monthly_totals
ORDER BY `year_month`;

-- ============================================================ -- 

-- F. FUNDING STAGE REVIEW
 
-- Q11. Do early-stage vs post-IPO companies lay off differently?

SELECT
    stage,
    COUNT(DISTINCT company)                      AS companies,
    SUM(total_laid_off)                          AS total_laid_off,
    ROUND(AVG(total_laid_off), 0)                AS avg_per_event,
    ROUND(AVG(percentage_laid_off) * 100, 1)     AS avg_pct_laid_off,
    ROUND(MAX(percentage_laid_off) * 100, 1)     AS max_pct_laid_off
FROM layoffs_staging2
WHERE stage IS NOT NULL
  AND total_laid_off IS NOT NULL
GROUP BY stage
ORDER BY total_laid_off DESC;

SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;


-- ============================================================
-- G. YEAR-OVER-YEAR RANKINGS
 
-- Q12. Top 5 companies by layoffs in each year 

WITH yearly_company_totals AS (
    SELECT
        company,
        YEAR(`date`)          AS `year`,
        SUM(total_laid_off)   AS total_laid_off
    FROM layoffs_staging2
    WHERE `date` IS NOT NULL
      AND total_laid_off IS NOT NULL
    GROUP BY company, YEAR(`date`)
),
ranked AS (
    SELECT
        company,
        `year`,
        total_laid_off,
        DENSE_RANK() OVER (PARTITION BY `year`
            ORDER BY total_laid_off DESC)  AS company_rank
    FROM yearly_company_totals)
SELECT
    `year`,
    company,
    total_laid_off,
    company_rank
FROM ranked
WHERE company_rank <= 5
ORDER BY `year`, company_rank;


WITH Rolling_Total AS
(
SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
)
SELECT `MONTH`, total_off, SUM(total_off) OVER(ORDER BY `MONTH`) AS rolling_total
FROM Rolling_Total;

-- ============================================================ -- 
-- further EDA 
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 2 ASC;

SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;

WITH Company_Year (company, years, total_laid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
)
SELECT*,
DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_Year
WHERE years IS NOT NULL
ORDER BY Ranking ASC;

WITH Company_Year (company, years, total_laid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
), 
Company_Year_Rank AS 
(SELECT*,
DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_Year
WHERE years IS NOT NULL)
SELECT *
FROM Company_Year_Rank
WHERE Ranking <= 5
;

SELECT `date`, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY `date`
ORDER BY 1 DESC;

SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;

SELECT SUBSTRING(`date`,6,2) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY `MONTH`
ORDER BY 2 DESC;

SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC;

