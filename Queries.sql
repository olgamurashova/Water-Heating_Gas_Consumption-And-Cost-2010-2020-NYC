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
    
    
--Query2 Create Gas_Consumption_Cost table
 
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
    
--Query 3
