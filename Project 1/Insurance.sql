CREATE Database Insurance;

-- Show All Columns for All Patients.
SELECT * FROM Insurance.insurance_data;

-- Display the Average Claim Amount for Patients in Each Region.
SELECT Region,Avg(claim) AS Average_Claim FROM Insurance.insurance_data
GROUP BY region;

-- Show the Maximum and Minimum BMI Values in the table.
SELECT Max(bmi) AS max_bmi,Min(bmi) AS min_bmi FROM Insurance.insurance_data;

-- Show the PatientID, Age, and BMI for Patients with a BMI between 40 and 50.
SELECT PatientID,Age,bmi FROM Insurance.insurance_data WHERE bmi BETWEEN 40 AND 50;

-- Show the Number of Smokers in Each Region
SELECT Region,Count(PatientID) FROM Insurance.insurance_data WHERE smoker="Yes"
GROUP BY Region;

-- Average Claim Amount for Patients Who are Both Diabetic and Smokers
SELECT AVG(claim) AS Average_Claim FROM Insurance.insurance_data WHERE diabetic="Yes" AND smoker="Yes";

-- Retrieve All Patients Who Have a BMI greater than the Average BMI of Patients Who are Smokers.
SELECT * FROM Insurance.insurance_data WHERE smoker="Yes" AND  
bmi > (SELECT AVG(bmi) FROM Insurance.insurance_data WHERE smoker="Yes");

-- Average Claim Amount for Patients in Each Age Group.
SELECT 
	CASE WHEN age < 18 THEN "Under 18"
    WHEN age BETWEEN 18 AND 30 THEN "18-30"
    WHEN age BETWEEN 31 AND 50 THEN "31-50"
    ELSE "Over 50"
END AS age_group,
Round(Avg(claim),2) AS avg_claim
FROM Insurance.insurance_data
GROUP BY age_group;

-- Retrieve the Total Claim Amount for Each Patient, Along with the Average Claim Amount Across All Patients.
SELECT *,Sum(claim) OVER(PARTITION BY PatientID) AS total_claim,
AVG(claim) OVER() AS avg_claim FROM Insurance.insurance_data;

-- The details of Patients Who Have a Claim Amount greater than the Average Claim Amount for their Region.
SELECT * FROM Insurance.insurance_data t1
WHERE claim > (SELECT AVG(claim) FROM Insurance.insurance_data t2 WHERE t2.region = t1.region);

-- The Details of Patients Along with their Claim Amount, and their Rank based on Claim Amount within their Region.
SELECT * , RANK() OVER(ORDER BY claim DESC) FROM Insurance.insurance_data;





