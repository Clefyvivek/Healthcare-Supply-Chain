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
| Category | Item / Metric | Value / Count | Notes / Context | Query Results | 
| -------- | ------------- | ------------- | --------------- | ------------- |
| **Operating Expenditure** | Personnel expenses | $4.37M | Largest operating cost (staffing & surgeons’ salaries) | <img width="468" height="281" alt="image" src="https://github.com/user-attachments/assets/b3bc5194-741b-4202-9f28-e3c47446dbab" /> |
| **Capital Expenditure** | Surgical masks | $4.26M | Highest-value capital item by aggregate expenditure | <img width="468" height="281" alt="image" src="https://github.com/user-attachments/assets/7cc87ecd-9994-4dff-982b-b91f2439203d" /> |
| **Capital Expenditure** | Ventilators | $3.71M | Second-highest by aggregate expenditure; longest restocking lead time (30 days) | <img width="468" height="281" alt="image" src="https://github.com/user-attachments/assets/d7c2c219-03bf-484a-8165-df2620c8f768" /> |
| **Capital Expenditure** | IV Drips | 27,534 units / $1.11M | Most used capital item by total units | <img width="567" height="339" alt="image" src="https://github.com/user-attachments/assets/3d451ea9-4bc8-4fc0-b966-af25cfcbbf81" /> |
| **Vendor Performance** | MedSupplies Inc. (Vendor V001) | 45,779 items delivered $1.90 million total cost | Leading supplier by volume and cost | <img width="604" height="336" alt="image" src="https://github.com/user-attachments/assets/4235c1e3-eed1-43c8-9e4b-e56e003ecddc" /> |
| **Inventory Management** | Overstocking | 187 days | Indicates excess supply | <img width="556" height="299" alt="image" src="https://github.com/user-attachments/assets/a595f71f-f7e2-43d5-b739-eb1d6dde4925" /> |
| **Inventory Management** | Understocking | 43 days | Indicates shortages | <img width="559" height="295" alt="image" src="https://github.com/user-attachments/assets/bc2e31c1-1a24-4a32-a89c-3301bac47c0a" /> |
| **Capital Expenditures** | X-ray machines (from MedSupplies Inc., V001) | $457,114 | Highest capital expenditure across vendors | <img width="583" height="346" alt="image" src="https://github.com/user-attachments/assets/63ca1229-0d55-4b2f-beb5-6d6ff51f7306" /> |
| **Clinical Insights** | Fracture diagnoses | 133 out of 500 cases | Leading diagnosis (26.6% of cases) | <img width="654" height="332" alt="image" src="https://github.com/user-attachments/assets/2635f289-3908-48d3-a3b7-ef1eddc56b90" /> |
| **Equipment Utilization** | X-ray machine | 173 usage count | Most utilized equipment | <img width="589" height="401" alt="image" src="https://github.com/user-attachments/assets/35d081ad-8eba-418b-a688-cc2993d3f3f3" /> |


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
- Clone the repository
- Import the database
- Explore the data
- That's it! You should now have a fully populated database ready for querying and further exploration. Feel free to modify the queries or extend the analysis. Contributions and suggestions are welcome!

### About Me:

Data Analyst, passionate about sustainable finance. Connect on [LinkedIn](https://www.linkedin.com/in/vivek-sharma-b74950241/)  | View more projects [here](https://github.com/Clefyvivek) Thanks for visiting!














