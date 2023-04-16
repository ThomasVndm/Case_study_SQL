SELECT * FROM weekly_sales LIMIT 10;

-- Data Cleansing

CREATE TABLE clean_weekly_sales AS 
SELECT week_date, 
week(week_date) AS week_number,
month(week_date) AS month_number,
year(week_date) AS calendar_year,
region, platform,

CASE WHEN segment=null THEN 'Unknown'
ELSE segment
END AS segment,

CASE WHEN RIGHT(segment,1)='1' THEN 'Young Adults'
	WHEN RIGHT(segment,2)='2' THEN 'Middle Aged'
	WHEN RIGHT(segment,2) IN ('3','4') THEN 'Retirees'
ELSE 'Unknown'
END AS age_band,

CASE WHEN LEFT(segment,1)='C' THEN 'Couples'
	WHEN LEFT(segment,1)='F' THEN 'Families'
ELSE 'Unknown'
END AS demographic,

customer_type, transactions, sales,
ROUND(sales/transactions,2) AS avg_transaction
FROM weekly_sales;
