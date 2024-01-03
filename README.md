# Financial-Institution-Data-Analysis

This project will deal with the complete analysis of banking data.Here i will do the analysis for 5 years of data and all the required details are below

Project Requirements
1)Data Model - A reference data model has been shared with you. You can add more entities and relationships. 
2)Steps:
a)Create a SQL database with the data model
b)Using Python (Pandas) generates sample data for a period of 5 years. 
i)The trends and the variation samples shared need to be incorporated in the sample data
ii)ID needs to be in the form of UUID
iii)Take realistic sample name
c)Once the SQL tables have been created, write SQL queries to create aggregate tables in your database
i)You may need to create multiple tables for the purpose
ii)You may need to create business logic which will allow you to join the tables
d)The aggregate tables need to be connected to a dashboarding tool of your choice
e)Present the dashboards with one panel for each KPI
f)Create an inference document from the data set writing the stories around the variations

	Data Model
Certainly! Here's an example of a data model that can help you calculate the mentioned KPIs for financial services:

**Entities:**
1. Financial Institution: Represents a financial services institution (e.g., bank, investment firm).
   - Attributes: InstitutionID, InstitutionName, Location

2. Investment Product: Represents an investment product or service offered by a financial institution.
   - Attributes: ProductID, ProductName, InstitutionID (foreign key)

3. Customer: Represents a customer or client of a financial institution.
   - Attributes: CustomerID, CustomerName, Location

4. Investment Account: Represents an investment account held by a customer.
   - Attributes: AccountID, CustomerID (foreign key), ProductID (foreign key), AccountBalance

5. Loan Account: Represents a loan account held by a customer.
   - Attributes: LoanID, CustomerID (foreign key), ProductID (foreign key), LoanAmount, LoanStatus

6. Customer Satisfaction Survey: Represents a customer satisfaction survey response.
   - Attributes: SurveyID, CustomerID (foreign key), SurveyDate, NPSRating

**Relationships:**
1. Institution-Product: Represents the relationship between a financial institution and its investment products.
   - Attributes: InstitutionID (foreign key), ProductID (foreign key)

2. Customer-Account: Represents the relationship between a customer and their investment accounts.
   - Attributes: CustomerID (foreign key), AccountID (foreign key)

3. Customer-Loan: Represents the relationship between a customer and their loan accounts.
   - Attributes: CustomerID (foreign key), LoanID (foreign key)

**KPI Calculations:**
1. Return on Investment (ROI): Measures the profitability of investments.
   - Calculation: (Investment Gain - Investment Cost) / Investment Cost * 100

2. Assets Under Management (AUM): Total value of assets being managed by the financial institution.
   - Calculation: Sum of the AccountBalance for all active investment accounts.

3. Customer Acquisition Cost (CAC): Cost incurred to acquire a new customer.
   - Calculation: Total marketing and sales expenses / Number of new customers acquired

4. Net Promoter Score (NPS): Measures customer satisfaction and loyalty.
   - Calculation: Percentage of Promoters (customers rating 9 or 10) - Percentage of Detractors (customers rating 0 to 6)

5. Loan Default Rate: Percentage of loan accounts that have defaulted.
   - Calculation: (Number of defaulted loans / Total number of loans) * 100

This data model provides a basic structure to capture and organize the necessary data for calculating the mentioned KPIs. You can customize and extend the model based on your specific financial services and requirements, such as adding more attributes or relationships to capture additional data points. Additionally, you would need to populate the model with real data to perform the calculations accurately.


List of KPIs
Financial services:
   - Return on investment (ROI)
   - Assets under management (AUM)
   - Customer acquisition cost (CAC)
   - Net promoter score (NPS)
   - Loan default rate


Seasonal Variations
Seasonal variations in the KPIs for financial services can occur due to several factors. Here are five causes for seasonal variations in the mentioned KPIs:

1. Economic Conditions: Economic fluctuations and seasonal trends can impact financial services KPIs. Factors such as interest rates, consumer spending patterns, and market conditions can vary seasonally, influencing KPIs like ROI and AUM.
   - Example: During a holiday season, consumer spending may increase, leading to higher AUM and potentially affecting ROI as investment returns may vary based on market conditions.

2. Tax Seasons: Tax seasons can significantly affect financial services, particularly in areas related to tax preparation and filing. This can impact KPIs like CAC and NPS.
   - Example: Tax preparation firms may experience a surge in customer acquisition during tax seasons, resulting in higher CAC. Additionally, customer satisfaction levels, as measured by NPS, may be influenced by the quality and efficiency of tax services provided during this period.

3. Investment and Loan Activity: Certain periods may witness increased investment or loan activity, resulting in seasonal variations in KPIs such as AUM and loan default rate.
   - Example: Year-end or fiscal year-end periods might see higher investment activity as individuals and businesses aim to optimize tax planning or meet financial targets. This can impact AUM and loan default rates accordingly.

4. Seasonal Financial Goals: Individuals and businesses may have specific financial goals aligned with particular seasons, leading to variations in financial services KPIs.
   - Example: For individuals, saving for vacations or holiday expenses may be a seasonal financial goal, potentially influencing AUM and ROI for specific products or services. Similarly, businesses may have seasonal financial goals related to inventory management or capital investments.

5. Regulatory Changes: Seasonal variations can also be driven by regulatory changes or reporting requirements that occur periodically throughout the year. These changes can impact KPIs like NPS and loan default rate.
   - Example: Certain financial regulations or compliance requirements, such as annual audits or reporting deadlines, may lead to changes in customer sentiment (NPS) or loan default rates as financial institutions enforce stricter guidelines or review portfolios during these periods.

Understanding these seasonal variations and their causes is important for financial service providers to effectively plan and allocate resources, manage customer expectations, and optimize performance during specific periods. Analyzing historical data and identifying patterns associated with these factors can help in forecasting and decision-making.

# Requirements--:
1-Jupyter Notebook or VScode
2- MySql
3- Workbench
4-Python and Pandas
5-Looker Studio for data analysis
