SELECT * FROM pet;

DESCRIBE pet;

SELECT * FROM pet ORDER BY birthday DESC;

SELECT name, breed FROM pet LIMIT 5;

SELECT * FROM pet WHERE city = "Fort Wayne";

SELECT * FROM pet WHERE name LIKE "B%";

SELECT * FROM pet WHERE species = "Cat" OR species = "Dog";

SELECT * FROM pet WHERE birthday LIKE "2020%";

SELECT * FROM  pet WHERE age > 3 AND age < 7;

SELECT species FROM pet DISTINCT;
