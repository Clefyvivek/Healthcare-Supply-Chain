# Healthcare-Supply-Chain

## Executive Summary
- **Personnel expenses dominate operating costs**, totaling **$4.37M**, underscoring the financial weight of staffing and surgeon salaries in hospital operations.
- **Surgical masks and ventilators drive capital expenditure**, with masks accounting for **$4.26M** and ventilators **$3.71M**, highlighting critical reliance on protective and life-support equipment.
- **Inventory inefficiencies persist**, with **187 days of overstocking** and **43 days of understocking**, while ventilators face the longest restocking lead time (30 days), exposing supply chain vulnerabilities.
- **MedSupplies Inc. (Vendor V001)** emerges as the leading supplier, delivering **45,779 items** worth **$1.90M**, including the highest vendor-specific capital item (X-ray machines at **$457,114**).
- **Clinical demand is concentrated in pneumonia cases (138/500)**, and the **surgical table** is the most utilized equipment (**231 uses**), reflecting operational priorities in patient care.

### Goals: 
- The highest expenditure by category and sub-category
- Equipment with the highest average usage per day
- Vendor with the highest sales by product category
- Items with overstock

### Key Takeaway:</br>
Personnel costs dominate operating expenses, while surgical masks and ventilators drive the majority of capital spend. Heavy reliance on a single vendor (MedSupplies Inc.) and frequent overstocking highlight opportunities for cost optimization through diversified sourcing, improved demand forecasting, and targeted inventory controls—potentially yielding significant savings without compromising care delivery.


### Key Insights:
| Category | Item / Metric | Value / Count | Notes / Context |
| -------- | ------------- | ------------- | --------------- |
| **Operating Expenditure** | Personnel expenses | $4.37M | Largest operating cost (staffing & surgeons’ salaries) | 
| **Capital Expenditure** | Surgical masks | $4.26M | Highest-value capital item by aggregate expenditure |
| **Capital Expenditure** | Ventilators | $3.71M | Second-highest by aggregate expenditure; longest restocking lead time (30 days) |
| **Capital Expenditure** | IV Drips | 27,534 units / $1.11M | Most used capital item by total units |
| **Vendor Performance** | MedSupplies Inc. (Vendor V001) | 45,779 items delivered $1.90 million total cost | Leading supplier by volume and cost | 
| **Inventory Management** | Overstocking | 187 days | Indicates excess supply | 
| **Inventory Management** | Understocking | 43 days | Indicates shortages |
| **Capital Expenditures** | X-ray machines (from MedSupplies Inc., V001) | $457,114 | Highest capital expenditure across vendors | 
| **Clinical Insights** | Pneumonia diagnoses | 138 out of 500 cases | Leading diagnosis (27.6% of cases) | 
| **Equipment Utilization** | Surgical table | 231 usage count | Most utilized equipment |

### Data & Modeling</br>
- Dataset: hospital_supply_chain (2003 rows) covering financial data, stocking data, patient diagnosis, equipment usage, etc.
- Tools: MySQL aggregations (SUM, COUNT ), ALTER TABLE (ADD), Data Manipulation Language (UPDATE), Wildcards (LIKE,%,''), Numeric function (ROUND), String function (REPLACE), CASE expression, NULL values, etc.
- Approach: Cleaned data from unrelated columns (Item ID, Patient ID, Room type, etc.), grouped by Item name/primary diagnosis/equipment used, etc.; calculated sums, rankings, and changes.

### Sample SQL Highlights: -- Fixing error where Primary_Diagnosis and Equipment_Used are mismatched
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
                                     

### Recommendations:
- Hospital Administrators / CFOs:
  - Optimize personnel expenses (the highest operating cost at $4.37M) by balancing staffing efficiency with patient care quality. Consider opting for outsourcing surgeons in certain non-emergency cases to reduce long-term staffing expenses.
  - Invest in predictive inventory management to reduce overstocking (187 days) and understocking (43 days), improving cost control and patient safety.

- Procurement & Supply Chain Managers:
  - Negotiate better contracts with MedSupplies Inc. (Vendor V001), the leading supplier, to diversify risk and avoid vendor dependency.
  - Shorten ventilator lead times (30 days) by exploring alternative suppliers or maintaining safety stock for critical equipment.

- Clinicians & Medical Staff:
   - Prioritize availability of high-demand items (IV drips: 27,534 units; surgical tables: 231 uses) to ensure uninterrupted patient care.
   - Align equipment usage with clinical demand (e.g., pneumonia cases: 138/500) to better forecast supply needs.

- Policy Makers / Regulators:
   - Encourage hospitals to adopt digital supply chain monitoring to reduce inefficiencies and improve resilience
   - Provide incentives for hospitals that demonstrate balanced inventory practices and reduced dependency on single vendors.

### Limitations & Next Steps:
- Data is limited for October 2024 for vendor data; longer supply data is needed.
- No data for the number of cases in a single day for a particular disease diagnosed.
- Future: Integrate Python/Power BI for interactive dashboards or ML predictions.  

### How to Run:
-
-
-

About Me: Data Analyst, passionate about sustainable finance. Connect on LinkedIn | View more projects [here]. Thanks for visiting!














