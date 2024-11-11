Create Database Titanic_Project;

-- Show the First 10 Rows of the Dataset.
SELECT * FROM Titanic_Project.titanic LIMIT 10;
SELECT * FROM Titanic_Project.titanic ORDER BY PassengerId DESC LIMIT 10;

 -- Find the Number of Passengers Who Survived.
 SELECT Count(*) AS "Passengers Survived" FROM Titanic_Project.titanic WHERE Survived = 1;
 
 -- Find the Average Age of All Passengers.
 SELECT AVG(age) FROM Titanic_Project.titanic;
 
 -- Find the Number of Passengers in Each Class.
 SELECT Pclass,Count(*) AS "No of Passengers" FROM Titanic_Project.titanic GROUP BY Pclass;
 
 -- Find the First 10 Rows of the Dataset Sorted by Passenger Class in Descending Order.alter
 SELECT * FROM Titanic_Project.titanic ORDER BY Pclass DESC LIMIT 10;
 
 -- Find the Number of Passengers in Each Class Sorted by Class in Ascending Order.
 SELECT Pclass, Count(*) FROM Titanic_Project.titanic GROUP BY Pclass ORDER BY Pclass ASC;
 
 -- Find the Average Fare Paid by Passengers in Each Class.
SELECT Pclass,AVG(Fare) AS "Average Fare" FROM Titanic_Project.titanic GROUP BY Pclass;
SELECT Pclass,AVG(Fare) AS "Average Fare" FROM Titanic_Project.titanic GROUP BY Pclass ORDER BY Pclass ASC;

-- Find the Name of the Passenger with the Highest Fare.
SELECT NAME,Fare FROM Titanic_Project.titanic WHERE Fare = (SELECT Max(Fare) FROM Titanic_Project.titanic);

-- Find the Name of the Passenger Who Had the Highest Age among the Survivors.
SELECT NAME,age FROM Titanic_Project.titanic WHERE Age= (SELECT Max(age) FROM Titanic_Project.titanic WHERE Survived = 1)
AND Survived =1;

-- Find the Number of Passengers Who Paid more than the Average Fare.
SELECT Count(*) AS passengers_number FROM Titanic_Project.titanic WHERE Fare > (SELECT AVG(Fare) FROM Titanic_Project.titanic);

-- Find the Name of the Passenger Who Had the most Parents or Children on board.
SELECT NAME FROM Titanic_Project.titanic WHERE Parch = (SELECT Max(Parch) FROM Titanic_Project.titanic);

-- Find the Number of Male and Female Passengers Who Survived.
SELECT Sex,Count(*) AS Survived FROM Titanic_Project.titanic WHERE Survived = 1
GROUP BY Sex 
ORDER BY Sex ASC;

-- Find the Name, Age and Fare of the Oldest Passenger Who Survived.
SELECT Name,Age,Fare FROM Titanic_Project.titanic 
WHERE Age = (Select Max(Age) FROM Titanic_Project.titanic WHERE Survived =1)
AND Survived =1;

-- Find the Name and Age of the Youngest Female Passenger Who Survived in Third Class.
SELECT Name,Age FROM Titanic_Project.titanic WHERE Sex = "Female" AND Pclass = 3 AND Survived = 1
AND Age = (SELECT Min(Age) FROM Titanic_Project.titanic WHERE Sex = "Female" AND Pclass = 3 AND Survived = 1);

-- Find Number of Male and Female Passengers.
SELECT 
Sum(CASE WHEN Sex = "Male" THEN 1 ELSE 0 END) AS Male,
Sum(CASE WHEN Sex = "Female" THEN 1 ELSE 0 END) AS Female 
FROM Titanic_Project.titanic;

-- Select All Passengers Who Traveled in A Cabin that was not Shared by Other Passengers.
SELECT * FROM Titanic_Project.titanic WHERE cabin NOT IN 
(SELECT Cabin FROM Titanic_Project.titanic GROUP BY Cabin HAVING Count(*) > 1);









