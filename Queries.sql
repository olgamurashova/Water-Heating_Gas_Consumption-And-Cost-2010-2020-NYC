--Query 1: Create Water_Consumption_Cost table

-- Table: public.Water_Consumption_Cost

-- DROP TABLE IF EXISTS public."Water_Consumption_Cost";

CREATE TABLE IF NOT EXISTS public."Water_Consumption_Cost"
(
    "Development Name" text COLLATE pg_catalog."default",
    "Borough" text COLLATE pg_catalog."default",
    "Account Name" text COLLATE pg_catalog."default",
    "Location" text COLLATE pg_catalog."default",
    "Meter AMR" text COLLATE pg_catalog."default",
    "Meter Scope" text COLLATE pg_catalog."default",
    "TDS #" text COLLATE pg_catalog."default",
    "EDP" numeric,
    "RC Code" text COLLATE pg_catalog."default",
    "Funding Source" text COLLATE pg_catalog."default",
    "AMP #" text COLLATE pg_catalog."default",
    "Vendor Name" text COLLATE pg_catalog."default",
    "UMIS BILL ID" numeric,
    "Revenue Month" text COLLATE pg_catalog."default",
    "Service Start Date" timestamp without time zone,
    "Service End Date" timestamp without time zone,
    "# days" numeric,
    "Meter Number" text COLLATE pg_catalog."default",
    "Estimated" text COLLATE pg_catalog."default",
    "Current Charges" numeric,
    "Rate Class" text COLLATE pg_catalog."default",
    "Bill Analyzed" text COLLATE pg_catalog."default",
    "Consumption (HCF)" real,
    "WaterSewer Charges" numeric,
    "Other Charges" numeric
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Water_Consumption_Cost"
    OWNER to postgres;
    
    
--Query 2: Create Gas_Consumption_Cost table
 
 -- Table: public.Gas_Consumption_Cost

-- DROP TABLE IF EXISTS public."Gas_Consumption_Cost";

CREATE TABLE IF NOT EXISTS public."Gas_Consumption_Cost"
(
    "Development Name" text COLLATE pg_catalog."default",
    "Borough" text COLLATE pg_catalog."default",
    "Account Name" text COLLATE pg_catalog."default",
    "Location" text COLLATE pg_catalog."default",
    "Meter AMR" text COLLATE pg_catalog."default",
    "Meter Scope" text COLLATE pg_catalog."default",
    "TDS #" text COLLATE pg_catalog."default",
    "EDP" numeric,
    "RC Code" text COLLATE pg_catalog."default",
    "Funding Source" text COLLATE pg_catalog."default",
    "AMP #" text COLLATE pg_catalog."default",
    "Vendor Name" text COLLATE pg_catalog."default",
    "UMIS BILL ID" numeric,
    "Revenue Month" text COLLATE pg_catalog."default",
    "Service Start Date" timestamp without time zone,
    "Service End Date" timestamp without time zone,
    "# days" numeric,
    "Meter Number" text COLLATE pg_catalog."default",
    "Estimated" text COLLATE pg_catalog."default",
    "Current Charges" numeric,
    "Rate Class" text COLLATE pg_catalog."default",
    "Bill Analyzed" text COLLATE pg_catalog."default",
    "Consumption (Therms)" real,
    "ES Commodity" text COLLATE pg_catalog."default",
    "Underlying Utility" text COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Gas_Consumption_Cost"
    OWNER to postgres;
    
--Query 3: Returning 5 developments with with the highest water consumption rate in 2020:

SELECT "Development Name",
"Borough",
MAX("Consumption (HCF)") AS "Highest_Water_Consumers"
FROM Public."Water_Consumption_Cost"
WHERE "Service End Date" BETWEEN '01/01/2020' AND '12/31/2020'
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 5;

--Query 4: Returning five developments with the highest rate of heating gas consumption in 2020

SELECT "Development Name",
"Borough",
MAX("Consumption (Therms)") AS "Highest_Heating_Gas_Consumers"
FROM Public."Gas_Consumption_Cost"
WHERE "Service End Date" BETWEEN '01/01/2020' AND '12/31/2020'
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 5;

--Query 5: Returning five developments with the highest total water charges and their corresponding total heating gas charges in 2020

SELECT 
w."Development Name",
w."Borough",
SUM(w."Current Charges") AS "Total_Water_Charges",
SUM(g."Current Charges") AS "Total_Gas_Charges"
FROM Public."Water_Consumption_Cost" as w
JOIN Public."Gas_Consumption_Cost" as g
ON w."TDS #" = g."TDS #"
WHERE w."Service End Date" BETWEEN '01/01/2020' AND '12/31/2020'
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 5;

--Query 6: Returning five developments with the highest total heating gas charges and their corresponding water charges in 2020

SELECT 
w."Development Name",
w."Borough",
SUM(g."Current Charges") AS "Total_Gas_Charges",
SUM(w."Current Charges") AS "Total_Water_Charges"
FROM Public."Water_Consumption_Cost" as w
JOIN Public."Gas_Consumption_Cost" as g
ON w."TDS #" = g."TDS #"
WHERE w."Service End Date" BETWEEN '01/01/2020' AND '12/31/2020'
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 5;

--Query 7: Comparing total water consumption charges for Williamsburg development in 2020 and 2015:

SELECT "Development Name",
"Borough",
SUM("Current Charges") AS "2020_Water_Charges",
(SELECT
SUM("Current Charges")
FROM Public."Water_Consumption_Cost"
WHERE "Development Name" = 'WILLIAMSBURG'
AND "Service End Date" BETWEEN '01/01/2015' AND '12/31/2015') AS "2015_Water_Charges",
SUM("Current Charges") -
(SELECT
SUM("Current Charges")
FROM Public."Water_Consumption_Cost"
WHERE "Development Name" = 'WILLIAMSBURG'
AND "Service End Date" BETWEEN '01/01/2015' AND '12/31/2015') AS Diff
FROM Public."Water_Consumption_Cost"
WHERE "Development Name" = 'WILLIAMSBURG'
AND "Service End Date" BETWEEN '01/01/2020' AND '12/31/2020'
GROUP BY 1,2;

--Query 8: Comparing average water consumption in Hundred Cubic Feet in Queens and Brooklyn in 2020:

SELECT
ROUND(AVG("Consumption_HCF"), 2) AS "QNS_Water_Avg_2020",
(SELECT
ROUND(AVG("Consumption_HCF"), 2) 
FROM Public."Water_Consumption_Cost"
WHERE "Borough" = 'BROOKLYN'
AND "Service End Date" >= '01/01/2020' AND "Service End Date" <= '12/31/2020'
) AS "BK_Water_Avg_2020"
FROM Public."Water_Consumption_Cost"
WHERE "Borough" = 'QUEENS'
AND "Service End Date" >= '01/01/2020' AND "Service End Date" <= '12/31/2020';

--Query 9: Calculating max water consumption and charges by development name for 2015-05 revenue month.

SELECT 
	"Development Name",
	"Borough",
	"Location",
	"TDS #",
	"Revenue Month",
    MAX("Consumption_HCF") OVER(PARTITION BY "Development Name") AS Max_HCF, 
    MAX("Current Charges") OVER(PARTITION BY "Development Name") AS Max_Charge
FROM public."Water_Consumption_Cost"
WHERE 
	"Borough" = 'QUEENS'
	AND "Revenue Month" = '2015-05'
ORDER BY 6 DESC;















--SELECT
ROUND(AVG("Consumption_HCF"), 2) AS "QNS_Water_Avg_2020",
(SELECT ROUND(AVG("Consumption_Therms"), 2)
FROM Public."Gas_Consumption_Cost"
WHERE "Borough" = 'QUEENS'
AND "Service End Date" >= '01/01/2020' AND "Service End Date" <= '12/31/2020') AS "QNS_Gas_Avg_2020"
FROM Public."Water_Consumption_Cost" AS w
JOIN Public."Gas_Consumption_Cost" AS g
ON w."TDS #" = g."TDS #"
WHERE w."Borough" = 'QUEENS'
AND w."Service End Date" >= '01/01/2020' AND w."Service End Date" <= '12/31/2020';
















--SELECT "Development Name", 
--Replace(Replace("Development Name", '(', ''), ')', '')
--FROM Public."Water_Consumption_Cost";
