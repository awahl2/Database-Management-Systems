-- In Class Demo using Pets Table

-- Notes:
-- 
-- Question: How do we know we have the right final data?
-- Potential solutions: create a fake database and run commands or throw data into excel to test commands
-- 
-- upper() : converts to uppercase
-- lower() : converts to lowercase
-- concat(value1, value2, valuen) : concatenate values
--

-- 1. How can you see all the tables from the demo database?
SHOW databases;

-- 2. Display the structure of the pets table (field names and data types).
DESCRIBE pets;

-- 3. Show all columns and rows from the pets table sorted oldest to youngest by birthday.
SELECT * FROM pets ORDER BY birthday;

-- 4. List the names and species of the first 5 pets.
SELECT name, species FROM pet LIMIT 5;

-- 5. Find all pets that live in the city of "Fort Wayne."
SELECT * FROM pets WHERE city = "Fort Wayne";

-- 6. List all pets whose names start with the letter "B."
SELECT * FROM pets WHERE name LIKE "B%";

-- 7. Show all pets that are either cats or dogs.
SELECT * FROM pets WHERE species = "Cat" OR species = "Dog";

-- 8. Find pets with birthdays in the year 2020.
SELECT * FROM pets WHERE birthday LIKE "2020%";

-- 9. List pets with ages between 3 and 7 years old.
SELECT * FROM  pets WHERE age >= 3 AND age =< 7;

-- 10. List all of the species of pets (each species listed one time).
SELECT DISTINCT species FROM pets;

