
-- Query 1: Title, Subject, Cost
-- simply selects the title, subject, and cost of each book. then sorted by the subject of the book, then by cost in ascending order
SELECT BOOK_TITLE, BOOK_SUBJECT, BOOK_COST
FROM BOOK
ORDER BY BOOK_SUBJECT, BOOK_COST ASC;

-- Query 2: Names of Patrons
-- gets first and last names of patrons from PATRON table
SELECT PAT_FNAME, PAT_LNAME
FROM PATRON;

-- Query 3: Year of publication
-- simply gets all unique publication years from the BOOK table using DISTINCT
SELECT DISTINCT BOOK_YEAR
FROM BOOK;

-- Query 3 BONUS
-- adds counts the number of books published in each year and groups abswer by year
SELECT BOOK_YEAR, COUNT(*) AS NUMBER_OF_BOOKS
FROM BOOK
GROUP BY BOOK_YEAR;


-- Query 4: All the books at 59.95
-- just gets titles of books from the BOOK table and gets cost if is 59.95
SELECT BOOK_TITLE
FROM BOOK
WHERE BOOK_COST = 59.95;

-- Query 5: Author's birthday
-- brings in first and last names of authors from the AUTHOR table while AU_BIRTHYEAR is NULL
SELECT AU_FNAME, AU_LNAME
FROM AUTHOR
WHERE AU_BIRTHYEAR IS NULL;

-- Query 6: Count of authored books
-- pulls full name of each author and the total number of books written by them. then grouped by author. COUNT gets total number of books for each author
SELECT CONCAT(AU_FNAME, ' ', AU_LNAME) AS AUTHOR_NAME, COUNT(*) AS BOOK_COUNT
FROM AUTHOR
JOIN WRITES ON AUTHOR.AU_ID = WRITES.AU_ID
JOIN BOOK ON WRITES.BOOK_NUM = BOOK.BOOK_NUM
GROUP BY AUTHOR.AU_ID;

-- Query 7: How long patron kept their checkout - calculation + join
-- calcul[ates num of days between OUT_DATE and IN_DATE for each checkout
-- also displays the patron full name, book title, and num days book was kept
SELECT CONCAT(PAT_FNAME, ' ', PAT_LNAME) AS PATRON_NAME, 
       BOOK.BOOK_TITLE, 
       DATEDIFF(CHECKOUT.CHECK_IN_DATE, CHECKOUT.CHECK_OUT_DATE) AS DAYS_KEPT
FROM CHECKOUT
JOIN PATRON ON CHECKOUT.PAT_ID = PATRON.PAT_ID
JOIN BOOK ON CHECKOUT.BOOK_NUM = BOOK.BOOK_NUM;



-- Query 8: Author + Book Title
-- gets full name of each author, the title of book and book subject. results sorted by book subject in ascending order
SELECT CONCAT(AU_FNAME, ' ', AU_LNAME) AS AUTHOR_NAME, 
       BOOK.BOOK_TITLE, 
       BOOK.BOOK_SUBJECT
FROM AUTHOR
JOIN WRITES ON AUTHOR.AU_ID = WRITES.AU_ID
JOIN BOOK ON WRITES.BOOK_NUM = BOOK.BOOK_NUM
ORDER BY BOOK.BOOK_SUBJECT;

-- Query 9: Books currently checked out
-- puts first and last names of patrons and the titles of books they currently checked out. book is checked out if CHECK_IN_DATE is NULL
SELECT PAT_FNAME, PAT_LNAME, BOOK.BOOK_TITLE
FROM CHECKOUT
JOIN PATRON ON CHECKOUT.PAT_ID = PATRON.PAT_ID
JOIN BOOK ON CHECKOUT.BOOK_NUM = BOOK.BOOK_NUM
WHERE CHECKOUT.CHECK_IN_DATE IS NULL;

-- Query 10: Popular Books Display
-- pulls the book number, title, and number of times each book was checked out.
-- results are sorted descending order by the number of checkouts like asked
-- if two books have same num of checkouts, sorted alphabetically by title start letters
SELECT BOOK.BOOK_NUM, BOOK.BOOK_TITLE, COUNT(CHECKOUT.BOOK_NUM) AS CHECKOUT_COUNT
FROM CHECKOUT
JOIN BOOK ON CHECKOUT.BOOK_NUM = BOOK.BOOK_NUM
GROUP BY BOOK.BOOK_NUM, BOOK.BOOK_TITLE
ORDER BY CHECKOUT_COUNT DESC, BOOK.BOOK_TITLE ASC;

-- Query 11: I picked to list authiors with most checkouts
-- my thing pulls the full name of each author, their book titles, and the number of times each book has been checked out
-- sorted by the num of checkouts in descending order
SELECT CONCAT(AU_FNAME, ' ', AU_LNAME) AS AUTHOR_NAME, 
       BOOK.BOOK_TITLE, 
       COUNT(CHECKOUT.BOOK_NUM) AS CHECKOUT_COUNT
FROM AUTHOR
JOIN WRITES ON AUTHOR.AU_ID = WRITES.AU_ID
JOIN BOOK ON WRITES.BOOK_NUM = BOOK.BOOK_NUM
JOIN CHECKOUT ON BOOK.BOOK_NUM = CHECKOUT.BOOK_NUM
GROUP BY AUTHOR.AU_ID, BOOK.BOOK_TITLE
ORDER BY CHECKOUT_COUNT DESC;
