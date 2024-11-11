-- Show All Columns and Rows in the table.
SELECT * FROM SF_Salaries.salaries;

-- Show Only the EmployeeName and JobTitle Columns.
SELECT EmployeeName,JobTitle FROM SF_Salaries.salaries;

-- Show the Number of Employees in the table.
SELECT COUNT(*) FROM SF_Salaries.salaries;

-- Show the Unique Job Titles in the table.
SELECT DISTINCT JobTitle FROM SF_Salaries.salaries;

-- Show the Job Title and Overtime Pay for All Employees with Overtime Pay greater than 50000
SELECT JobTitle,OvertimePay FROM SF_Salaries.salaries
WHERE OvertimePay > 50000;

-- Show the Average Base Pay for All Employees.
SELECT AVG(BasePay) AS "Average BasePay" FROM SF_Salaries.salaries;

-- Show the Top 10 Highest Paid Employees.
SELECT EmployeeName,TotalPay FROM SF_Salaries.salaries
ORDER BY TotalPay DESC
LIMIT 10;

-- Show All Employees Who Have the Word "Manager" in Their Job Title.
SELECT EmployeeName,JobTitle FROM SF_Salaries.salaries
WHERE JobTitle LIKE '%Manager%';

-- Show All Employees with A Total Pay Between 50,000 and 75,000.
SELECT * FROM SF_Salaries.salaries
WHERE TotalPay>=50000 AND TotalPay <=75000
;
SELECT * FROM SF_Salaries.salaries
WHERE TotalPay BETWEEN 50000 AND 75000;

-- Show All Employees with A Base Pay less than 50,000 or A Total Pay greater than 100,000.
SELECT * FROM SF_Salaries.salaries
WHERE BasePay < 50000 OR TotalPay > 100000;

-- Show All Employees with A Total Pay Benefits Value between 125,000 and 150,000 and A Job Title Containing the word "Director".
SELECT * FROM SF_Salaries.salaries
WHERE TotalPayBenefits BETWEEN 125000 AND 150000 
AND JobTitle LIKE "%Director%";

-- Show All Employees Ordered by Their Total Pay Benefits in Descending Order.
SELECT * FROM SF_Salaries.salaries
ORDER BY TotalPayBenefits DESC;

-- Show All Job Titles with an Average Base Pay of at least 100,000 and Order them by the Average Base Pay in Descending Order.
SELECT JobTitle, AVG(BasePay) AS "AverageBasePay" FROM SF_Salaries.salaries
GROUP BY JobTitle
HAVING AVG(BasePay) >=100000
ORDER BY AverageBasePay DESC;

-- Delete the Column.
SELECT * FROM SF_Salaries.salaries;
ALTER TABLE SF_Salaries.salaries
DROP COLUMN Notes;

SELECT * FROM SF_Salaries.salaries;

-- Update the Base Pay of All Employees with the Job Title Containing "Manager" by Increasing it by 10%.
UPDATE SF_Salaries.salaries
SET BasePay = BasePay * 1.1
WHERE JobTitle LIKE "%Manager%";

SELECT * FROM SF_Salaries.salaries;

-- Delete All Employees Who Have No OvertimePay.
SELECT COUNT(*) FROM SF_Salaries.salaries
WHERE OvertimePay =0;
DELETE FROM SF_Salaries.salaries
WHERE OvertimePay =0;

SELECT COUNT(*) FROM SF_Salaries.salaries
WHERE OvertimePay =0;








