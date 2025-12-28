-- Table datasets used for the analysis

SELECT *
FROM financial_data;

SELECT *
FROM inventory_data;

SELECT *
FROM patient_data;

SELECT *
FROM vendor_data;

-- Removing non-required columns

ALTER TABLE inventory_data
DROP Item_ID
;

ALTER TABLE patient_data
DROP Patient_ID
;

ALTER TABLE patient_data
DROP Room_Type
;

ALTER TABLE patient_data
DROP Bed_Days
;


-- Changing category of Surgical Mask to 'Supplies' which was categorized as 'Staffing' and 'Equipment' in financial data table

UPDATE 
	financial_data
SET Expense_Category = 'Supplies'
WHERE Description = 'Surgical masks'
;


-- Removing the apostrophe(') from Surgeon's salaries in financial data table

UPDATE financial_data
SET Description = REPLACE(Description, 'Surgeons'' salaries', 'Surgeons salaries')
WHERE Description LIKE '%Surgeons'' salaries%';


-- Changing category of Surgeons salaries to 'Staffing' which was categorized as 'Supplies' in financial data table

UPDATE 
	financial_data
SET Expense_Category = 'Staffing'
WHERE Description = 'Surgeons salaries'
;


-- Changing category of ventilators to 'Equipment' which was categorized as 'Supplies' in financial data table

UPDATE 
	financial_data
SET Expense_Category = 'Equipment'
WHERE Description = 'Ventilators'
;


-- Resolving the error in the calculation due to signs

UPDATE
	inventory_data
SET Unit_Cost =	REPLACE(REPLACE(Unit_Cost, '$', ''), ',', '')
;

UPDATE
	vendor_data
SET Cost_Per_Item =	REPLACE(REPLACE(Cost_Per_Item, '$', ''), ',', '')
;


-- Fixing error where Item_Name and Item_type are mismatched

UPDATE 
	inventory_data
SET Item_type = CASE  Item_Name
	WHEN 'Ventilators'     THEN 'Equipment'
    WHEN 'X-ray Machine'  THEN 'Equipment'
    WHEN 'Surgical Mask'  THEN 'Consumable'
    WHEN 'Gloves'         THEN 'Consumable'
    ELSE Item_Type
END
;


-- Fixing error where Primary_Diagnosis and Procedure_Performed are mismatched

UPDATE
	patient_data
SET Primary_Diagnosis =	CASE Procedure_Performed
		WHEN 'Appendectomy' THEN 'Appendicitis'
        WHEN 'Chest X-ray' THEN 'Pneumonia'
        WHEN 'Blood Test' THEN 'Diabetes'
        WHEN 'MRI' THEN 'Fracture'
ELSE Primary_Diagnosis
END
;


-- Fixing error where Primary_Diagnosis and Equipment_Used are mismatched

UPDATE
	patient_data
SET Equipment_Used = CASE Procedure_Performed
		WHEN 'Appendectomy' THEN 'Surgical Table'
        WHEN 'Chest X-ray' THEN 'X-ray Machine'
        WHEN 'Blood Test' THEN 'Surgical Table'
        WHEN 'MRI' THEN 'MRI Machine'
ELSE Equipment_Used
END
;


-- Total expense by category

SELECT 
	Expense_Category,
    ROUND(SUM(Amount), 2) AS Total_Amount
FROM financial_data
GROUP BY Expense_Category
ORDER BY 2 DESC
;


-- Total operating expenditure by description 

SELECT 
	Description,
    ROUND(SUM(Amount), 2) AS Total_Amount
FROM financial_data
GROUP BY Description
ORDER BY 2 DESC
;


-- Total average of items used (high to low)

SELECT 
	Item_Name,
    SUM(Avg_Usage_Per_Day) AS Total_Avg_Usage_Per_Day
FROM inventory_data
GROUP BY Item_Name
ORDER BY 2 DESC
;


-- Total average usage per day by item name and vendor

SELECT 
	Item_Name,
    Vendor_ID,
    SUM(Avg_Usage_Per_Day) AS Total_Avg_Usage_Per_Day
FROM inventory_data
GROUP BY Item_Name, Vendor_ID
ORDER BY 3 DESC
;


-- Total item usage supplied by different vendors

SELECT 
	Vendor_ID,
    SUM(Avg_Usage_Per_Day) AS Total_Avg_Usage_Per_Day
FROM inventory_data
GROUP BY Vendor_ID
ORDER BY 2 DESC
;

-- Dates Where items were overstocked

SELECT 
	Date,
    Item_Type,
	Item_Name,
    Current_Stock,
	Max_Capacity
FROM inventory_data
WHERE Max_Capacity <= Current_Stock
;


-- Total instances where items were over-stocked

SELECT COUNT(*) AS Total_Understocked_Instances
FROM inventory_data
WHERE Max_Capacity <= Current_Stock
;


-- Dates Where items were under-stocked

SELECT 
	Date,
    Item_Type,
	Item_Name,
    Min_Required,
    Current_Stock
FROM inventory_data
WHERE Min_Required >= Current_Stock
ORDER BY 4 DESC
;

-- Total instances where items were under-stocked

SELECT COUNT(*) AS Total_Understocked_Instances
FROM inventory_data
WHERE Min_Required >= Current_Stock
;


-- Required time to restock different items (high to low)

SELECT
	Item_Name, 
	Restock_Lead_Time,
    Vendor_ID
FROM inventory_data
ORDER BY 2 DESC
;


-- Ranking the amount spent on different items (high to low)

SELECT 
	Item_Name,
    ROUND(SUM(Unit_Cost), 2) AS Unit_Cost
FROM inventory_data
GROUP BY Item_Name
ORDER BY 2 DESC
;


-- Ranking most common diagnosis by total cases

SELECT 
	Primary_Diagnosis,
	COUNT(*) AS Total_cases 
FROM patient_data 
WHERE Primary_Diagnosis IS NOT NULL AND Primary_Diagnosis != ''
GROUP BY Primary_Diagnosis
ORDER BY 2 DESC
;


-- Total usage of different equipments

SELECT 
	Equipment_Used,
	COUNT(*) AS Total_usage
FROM patient_data
WHERE Equipment_Used IS NOT NULL AND Equipment_Used != ''
GROUP BY Equipment_Used
ORDER BY 2  DESC
;


-- Total usage of different supplies

SELECT 
	Supplies_Used,
	COUNT(*) AS Total_usage
FROM patient_data
WHERE Supplies_Used IS NOT NULL AND Supplies_Used != ''
GROUP BY Supplies_Used
ORDER BY 2  DESC
;


-- Total usage of different supplies by primary diagnosis

SELECT 
	Primary_Diagnosis,
	Supplies_Used,
	COUNT(*) AS Total_usage
FROM patient_data
WHERE Supplies_Used IS NOT NULL AND Supplies_Used != ''
GROUP BY Supplies_Used, Primary_Diagnosis
ORDER BY 3  DESC
;