# Letterboxd Data
USE letterboxd_reviews;


-- LETTERBOXD CLEANING 

# Outer joining letterboxd and genre 
SELECT DISTINCT * FROM letterboxd
LEFT JOIN genre ON letterboxd.New_Movie_Name = genre.movie_name
UNION
SELECT DISTINCT * FROM letterboxd
RIGHT JOIN genre ON letterboxd.New_Movie_Name = genre.movie_name;

SELECT COUNT(*) FROM letterboxd;


-- CLEANED LETTERBOXD
-- Still need to do some cleaning for some of the columns 

# Shows me how many times each distinct combo of (movie name, reviewer name, review) appears
SELECT Clean_Movie_Name, `Reviewer name`, Clean_Review, COUNT(*) 
FROM letterboxd_clean 
GROUP BY Clean_Movie_Name, `Reviewer name`, Clean_Review;

# Counts the number for times each distinct combo of (movie name, reviewer name, review) appears, i.e. takes out any duplicates 
# if they exist. Turns out no duplicates in letterboxd_clean
SELECT COUNT(DISTINCT Clean_Movie_Name, `Reviewer name`, Clean_Review)
FROM letterboxd_clean;

-- Removing extra columns in new_genre_test
ALTER TABLE new_genre_test
	DROP COLUMN `raw`,
    DROP COLUMN `1`,
    DROP COLUMN `2`,
    DROP COLUMN `3`;

SELECT * FROM new_genre_test; # 1000 rows

-- Clean_Review column cleaning:

# Taking out rows where the reviews mostly contain symbols and no proper sentence structure 
DELETE FROM letterboxd_clean WHERE (`Movie name` = 'Minions: The Rise of Gru' AND `Reviewer name` = 'Santiago Rodr??guez')
	OR `Movie name` = 'Lux ??terna';
# Ran line above
DELETE FROM letterboxd_clean WHERE (`Movie name` = 'Moonrise Kingdom' AND `Reviewer name` = '?????? Liam ??????')
	OR `Movie name` = 'Whisper of the Heart';
# Ran line above
DELETE FROM letterboxd_clean WHERE Clean_Review LIKE '#NAME%' OR Clean_Review LIKE '#VALUE%';
# Ran line above
DELETE FROM letterboxd_clean WHERE Clean_Review LIKE "'" 
	OR Clean_Review LIKE '?'
    OR Clean_Review LIKE "'?"
    OR Clean_Review LIKE "''"
    OR Clean_Review LIKE '.';
# Ran line above
DELETE FROM letterboxd_clean WHERE `Movie name` = 'Midsommar' AND `Review date` = '08-May-20'
	OR `Movie name` = 'Midsommar (2019)' AND `Reviewer name` = '#1 gizmo fan'
	OR `Movie name` = 'Tokyo Godfathers'
    OR `Movie name` = 'Howl???s Moving Castle' AND `Reviewer name` = 'Roberto_'
    OR `Movie name` = 'Grown Ups 2'
    OR `Movie name` = 'Titane' AND `Reviewer name` = 'Nakul'
    OR `Movie name` = 'Burning' AND `Reviewer name` = 'davidehrlich';
# Ran line above
DELETE FROM letterboxd_clean WHERE `Movie name` = 'Marcel the Shell with Shoes On' AND `Reviewer name` = 'Tim'
	OR `Movie name` = 'M3GAN' AND `Reviewer name` = 'hollie amanda'
    OR `Movie name` = 'The Banshees of Inisherin' AND `Reviewer name` = 'Chris Feil'
    OR `Movie name` = 'Eyes Wide Shut' AND `Reviewer name` = 'Roberta'
    OR `Movie name` = 'Marcel the Shell with Shoes On' AND `Reviewer name` = 'emma';
# Ran line above
DELETE FROM letterboxd_clean WHERE `Movie name` = '10 Things I Hate About You' AND `Reviewer name` = 'ally ????'
	OR `Movie name` = 'Before Sunrise' AND `Reviewer name` = 'Lucy'
    OR `Movie name` = 'Don???t Look Up' AND `Reviewer name` = 'Andy ????????'
    OR `Movie name` = 'Ferris Bueller???s Day Off' AND `Reviewer name` = 'Grooveman'
    OR `Movie name` = 'Fresh (2022)' AND `Reviewer name` = 'tyler'
	OR `Movie name` = 'Legally Blonde' AND `Reviewer name` = 'shay'
    OR `Movie name` = 'Porco Rosso' AND `Reviewer name` = 'Adrian'
    OR `Movie name` = 'Portrait of a Lady on Fire' AND `Reviewer name` = 'Roberto_';
# Ran line above 
DELETE FROM letterboxd_clean WHERE `Movie name` = 'Spider-Man: No Way Home (2021)' AND `Reviewer name` = 'kait ????'
	OR `Movie name` = 'Avatar: The Way of Water (2022)' AND `Reviewer name` = 'the film drunk';
# Ran line above
DELETE FROM letterboxd_clean WHERE `Movie name` = 'Possession' AND `Reviewer name` = 'DirkH'
	OR `Movie name` = 'Possession' AND `Reviewer name` = 'Lucy';
# Ran line above
DELETE FROM letterboxd_clean WHERE `Movie name` = 'Inglourious Basterds' AND `Reviewer name` = 'Lucy'
	OR `Movie name` = 'It Follows' AND `Reviewer name` = 'Lucy'
    OR `Movie name` = 'The Two Popes' AND `Reviewer name` = '???? lindsay ????'
    OR `Movie name` = 'Harry Potter and the Goblet of Fire' AND `Reviewer name` = '???? lindsay ????'
    OR `Movie name` = 'RRR (2022)' AND `Reviewer name` = 'Patrick Willems';
# Ran line above

# 3072 rows left after queries above 

SELECT * FROM letterboxd_clean WHERE `Movie name` = 'Inglourious Basterds' AND `Reviewer name` = 'Lucy'
	OR `Movie name` = 'It Follows' AND `Reviewer name` = 'Lucy'
    OR `Movie name` = 'The Two Popes' AND `Reviewer name` = '???? lindsay ????'
    OR `Movie name` = 'Harry Potter and the Goblet of Fire' AND `Reviewer name` = '???? lindsay ????'
    OR `Movie name` = 'RRR (2022)' AND `Reviewer name` = 'Patrick Willems';
    
SELECT * FROM letterboxd_clean; # 3072 rows

-- CLEANING LIKE COUNT 

UPDATE letterboxd_clean
SET `Like count` = REPLACE(`Like count`, ' ', '');

UPDATE letterboxd_clean
SET `Like count` = REPLACE(`Like count`, 'likes', '');

UPDATE letterboxd_clean
SET `Like count` = REPLACE(`Like count`, '06-Apr-13', '');



-- INNER JOINING letterboxd_clean and new_genre_test 

SELECT movie_name, `Release Year`, `Reviewer name`, Clean_Review_date, Clean_Review, `Clean_Comment Count`, `Like count`, genre
FROM letterboxd_clean
INNER JOIN new_genre_test
ON letterboxd_clean.`Movie name` = new_genre_test.raw_movie_name;


SELECT * FROM temporary_letterboxd_clean;

-- MISSING MOVIES FROM GENRE TABLE

# Outer joining letterboxd_genre_clean and letterboxd_clean to see what movies are missing from lgc, i.e. genre table 
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


# Outer join new_letterboxd_genre_clean with letterboxd_clean to see if any movies are missing 

SELECT nlgc.Clean_Movie_Name AS nlgc_movie_name, 
	   lg.`Movie name` AS lg_movie_name,
	   nlgc.Review AS nlgc_review, 
       lg.Review AS lg_review
FROM new_letterboxd_genre_clean AS nlgc
LEFT JOIN letterboxd_clean AS lg 
ON nlgc.Clean_Movie_Name = lg.`Movie name` 
UNION
SELECT nlgc.Clean_Movie_Name AS nlgc_movie_name, 
	   lg.`Movie name` AS lg_movie_name,
	   nlgc.Review AS nlgc_review, 
       lg.Review AS lg_review 
FROM new_letterboxd_genre_clean AS nlgc
RIGHT JOIN letterboxd_clean AS lg 
ON nlgc.Clean_Movie_Name = lg.`Movie name`
ORDER BY nlgc_movie_name, lg_movie_name ASC; 


