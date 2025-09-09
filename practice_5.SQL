SHOW databases;
USE demo;
SHOW tables;
SELECT * FROM pets;

SELECT count(*) AS total_pets FROM pets;

SELECT avg(age) AS average_age FROM pets;

SELECT max(age) 
AS oldest_pet, min(age) AS youngest_pet FROM pets;

SELECT age FROM pets ORDER BY age DESC LIMIT 1;

SELECT max(age) AS oldest_pet, min(age) AS youngest_pet, avg(age) AS avg_age_pet FROM pets;

SELECT species, count(*) AS num_pets FROM pets GROUP BY species;

SELECT owner, species, count(*) AS num_pets FROM pets GROUP BY owner;

SELECT city, avg(age) AS avg_age FROM pets GROUP BY city;

