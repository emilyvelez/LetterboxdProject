USE letterboxd;

# taking a look at dataset
#there are 4578 rows in the new letterboxd reviews dataset
SELECT COUNT(*)
FROM new_letterboxd_reviews;

SELECT DISTINCT movie_name 
FROM genre;

# taking a look at dataset
SELECT *
FROM new_letterboxd_reviews;

#learned how to call a column name that has a space
SELECT `Movie name` 
FROM new_letterboxd_reviews;

#housekeeping
ALTER TABLE letterboxd_clean 
RENAME COLUMN `Movie name` TO movie_name;

# renamed column name since string format was cumbersome
ALTER TABLE new_letterboxd_reviews
RENAME COLUMN `Movie name` TO movie_name; 

#checked how many distinct films there are = 1254 
SELECT COUNT(*)
FROM new_letterboxd_reviews;

#want to see how many movie reviews we have
SELECT *
FROM new_letterboxd_reviews;

#want to see how films are grouped
SELECT *
FROM new_letterboxd_reviews
ORDER BY movie_name ASC;

#created a table for genre to land
CREATE TABLE genre (
    movie_name VARCHAR(255) PRIMARY KEY,
    genre VARCHAR(255)
);

SELECT COUNT(DISTINCT(movie_name))
FROM genre;

SELECT * FROM new_letterboxd_reviews;
DELETE FROM new_letterboxd_reviews
WHERE `Release Year` = "";
DELETE FROM new_letterboxd_reviews
WHERE movie_name = "(500)";
ALTER TABLE new_letterboxd_reviews
ADD COLUMN New_Movie_Name VARCHAR(255);
UPDATE new_letterboxd_reviews
SET New_Movie_Name = TRIM(SUBSTRING_INDEX(movie_name, '(', 1));
UPDATE new_letterboxd_reviews
SET `Release Year` = REPLACE(`Release Year`, ' ', '');
UPDATE new_letterboxd_reviews
SET `New_Movie_Name` = REPLACE(`New_Movie_Name`, '???', "'");

#checking how many unique films there are in new movie column
SELECT COUNT(DISTINCT(new_movie_name))
FROM new_letterboxd_reviews;

SELECT movie_name, new_movie_name
FROM new_letterboxd_reviews
ORDER BY new_movie_name ASC;

#full outer join on MySQL
SELECT * FROM new_letterboxd_reviews
LEFT JOIN genre ON new_letterboxd_reviews.new_movie_name = genre.movie_name
UNION
SELECT * FROM new_letterboxd_reviews
RIGHT JOIN genre ON new_letterboxd_reviews.new_movie_name = genre.movie_name;

#full outer join on clean_letterboxd and genre
SELECT * FROM clean_letterboxd
LEFT JOIN genre ON clean_letterboxd.clean_movie_name = genre.movie_name
UNION
SELECT * FROM clean_letterboxd
RIGHT JOIN genre ON clean_letterboxd.clean_movie_name = genre.movie_name;

#JUST FOR FUN JOIN!!!!!!!!
SELECT * FROM clean_letterboxd
LEFT JOIN new_letterboxd_reviews ON clean_letterboxd.clean_movie_name = new_letterboxd_reviews.new_movie_name
UNION
SELECT * FROM clean_letterboxd
RIGHT JOIN new_letterboxd_reviews ON clean_letterboxd.clean_movie_name = new_letterboxd_reviews.new_movie_name;

#used to count how many film names are in common between the two tables and match = 3935 (before cleaning)
#after cleaning (removing '"') = 3980
#after fixing Top Gun, Top Gun Maverick fiasco = 4004
#after glass onion added = 4035
#after adding some other movies = 4037
SELECT COUNT(*)
FROM new_letterboxd_reviews
INNER JOIN genre
ON new_letterboxd_reviews.new_movie_name = genre.movie_name;

#used to count clean_letterboxd
#after initial cleaning = 2369
#after next cleaning = 2430
#after like concate functino = 2572
SELECT COUNT(*)
FROM clean_letterboxd
INNER JOIN genre
ON clean_letterboxd.clean_movie_name = genre.movie_name;

#removing quotation marks from movie names in genre file
UPDATE genre
SET movie_name = REPLACE(movie_name, '"', '')
WHERE movie_name LIKE '%"%' OR movie_name LIKE '%"%';

#used to update genre that says 'Maverick' to say 'Action'
UPDATE genre
SET genre = 'Action'
WHERE genre = 'Maverick';

#adding a row in genre that is "Top Gun: Maverick" to corresponding value "Action"
INSERT INTO genre (movie_name, genre)
VALUES ('Top Gun: Maverick', 'Action');

#adding a row in genre that is "How to Train Your Dragon', 'Animation"
INSERT INTO genre (movie_name, genre)
VALUES ('How to Train Your Dragon', 'Animation');

#update Glass Onion name 
UPDATE genre
SET movie_name = 'Glass Onion: A Knives Out Mystery'
WHERE movie_name = 'Glass Onion';

#adding a row in genre that is "How to Train Your Dragon 2', 'Animation"
INSERT INTO genre (movie_name, genre)
VALUES ('How to Train Your Dragon: The Hidden World', 'Animation');

#deleting any rows that have any columns as null 
#DELETE FROM new_letterboxd_reviews
#WHERE movie_name 
#IS NULL;

#deleting any rows that have any columns as null 
WHERE 'release year' 
IS NULL OR 'review date'
IS NULL OR 'review'
IS NULL OR 'comment count'
IS NULL OR 'like count' IS NULL;

#deleting rows that have 'This review may contain spoilers.'
#DELETE FROM new_letterboxd_reviews
#deleting rows that have 'I can handle the truth'
#DELETE FROM new_letterboxd_reviews
#WHERE Review = 'I can handle the truth.';

#JOIN b/w letterboxd genre clean and letterboxd genre?? (what's lg?)
SELECT lgc.Clean_Movie_Name AS lgc_movie_name,
	   lg.`Movie name` AS lg_movie_name,
	   lgc.Review AS lgc_review,
       lg.Review AS lg_review
FROM letterboxd_genre_clean AS lgc
LEFT JOIN letterboxd_clean AS lg
ON lgc.Clean_Movie_Name = lg.`Movie name`
UNION
SELECT lgc.Clean_Movie_Name AS lgc_movie_name,
	   lg.`Movie name` AS lg_movie_name,
	   lgc.Review AS lgc_review,
       lg.Review AS lg_review
FROM letterboxd_genre_clean AS lgc
RIGHT JOIN letterboxd_clean AS lg
ON lgc.Clean_Movie_Name = lg.`Movie name`
ORDER BY lgc_movie_name, lg_movie_name ASC;

#checking for uniqueness in letterboxd_clean
#SELECT Clean_Movie_Name, `Reviewer name`, Clean_Review, COUNT(*) 
#FROM letterboxd_clean 
#GROUP BY Clean_Movie_Name, `Reviewer name`, Clean_Review;

#same function as the query above (checking for uniqueness) but does so using count 
#SELECT COUNT(DISTINCT Clean_Movie_Name, `Reviewer name`, Clean_Review)
#FROM letterboxd_clean;

SELECT DISTINCT clean_movie_name
FROM clean_letterboxd;

#cleaning movie names
START TRANSACTION;
UPDATE clean_letterboxd
SET clean_movie_name = 'Dahmer – Monster: The Jeffrey Dahmer Story'
WHERE clean_movie_name = 'Dahmer ??? Monster: The Jeffrey Dahmer Story';

UPDATE clean_letterboxd
SET clean_movie_name = 'Se7en'
WHERE clean_movie_name = 'Se 6  en';

UPDATE clean_letterboxd
SET clean_movie_name = '1916'
WHERE clean_movie_name = '191 6  ';
COMMIT;

#second transaction
START TRANSACTION;
UPDATE clean_letterboxd
SET clean_movie_name = 'WALL-E'
WHERE clean_movie_name = 'WALL??E';

UPDATE clean_letterboxd
SET clean_movie_name = 'Once Upon a Time in Hollywood'
WHERE clean_movie_name = 'Once Upon a Time??? in Hollywood';

UPDATE clean_letterboxd
SET clean_movie_name = 'When Harry Met Sally'
WHERE clean_movie_name = 'When Harry Met Sally???';

UPDATE genre
SET movie_name = 'When Harry Met Sally'
WHERE movie_name = 'When Harry Met Sally...';

UPDATE clean_letterboxd
SET clean_movie_name = 'La Jetée'
WHERE clean_movie_name = 'La Jet??e';

UPDATE clean_letterboxd
SET clean_movie_name = 'Amélie'
WHERE clean_movie_name = 'Am??lie';

UPDATE clean_letterboxd
SET clean_movie_name = 'Homecoming: A Film by Beyoncé'
WHERE clean_movie_name = 'Homecoming: A Film by Beyonc??';

UPDATE clean_letterboxd
SET clean_movie_name = 'Léon: The Professional'
WHERE clean_movie_name = 'L??on: The Professional';

UPDATE clean_letterboxd
SET clean_movie_name = 'Cléo from 5 to 7'
WHERE clean_movie_name = 'Cl??o from 5 to  6  ';

UPDATE clean_letterboxd
SET clean_movie_name = 'Lux Æterna'
WHERE clean_movie_name = 'Lux ??terna';

UPDATE clean_letterboxd
SET clean_movie_name = 'One Night in Miami…'
WHERE clean_movie_name = 'One Night in Miami???';

UPDATE clean_letterboxd
SET clean_movie_name = 'tick, tick...BOOM!'
WHERE clean_movie_name = 'tick, tick???BOOM!';

UPDATE clean_letterboxd
SET clean_movie_name = 'Tar'
WHERE clean_movie_name = 'T??R';

UPDATE clean_letterboxd
SET clean_movie_name = 'Y Tu Mamá También'
WHERE clean_movie_name = 'Y Tu Mam?? Tambi??n';
COMMIT;

#removed double quotes from the beginingg and end of movie names
UPDATE new_genre_test
SET raw_movie_name = TRIM(BOTH '"' FROM raw_movie_name);

#JOIN ON new_genre_test AND letterboxd_clean
SELECT * FROM letterboxd_clean
LEFT JOIN new_genre_test ON letterboxd_clean.movie_name = new_genre_test.raw_movie_name
UNION
SELECT * FROM letterboxd_clean
RIGHT JOIN new_genre_test ON letterboxd_clean.movie_name = new_genre_test.raw_movie_name;

#count of all rows in inner join
SELECT COUNT(*)
FROM letterboxd_clean
INNER JOIN new_genre_test
ON letterboxd_clean.movie_name = new_genre_test.raw_movie_name;

#grouping movies by release year to see distribution of sample
SELECT `release year`, COUNT(`release year`)
FROM letterboxd_clean 
group by `release year` 
ORDER BY `RELEASE YEAR` ASC; 

