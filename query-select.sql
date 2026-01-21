-- Selezionare tutti gli studenti nati nel 1990
SELECT *
FROM students
WHERE YEAR(date_of_birth) = 1990

SELECT *
FROM students
WHERE date_of_birth LIKE "1990-%"

SELECT *
FROM students
WHERE date_of_birth BETWEEN '1990-01-01' AND '1990-12-31'

-- Selezionare tutti i corsi che valgono più di 10 crediti
SELECT *
FROM courses
WHERE cfu > 10

-- Selezionare tutti gli studenti che hanno più di 30 anni
SELECT *
FROM students
WHERE TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) > 30
ORDER BY date_of_birth DESC

-- Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di laurea
SELECT *
FROM courses
WHERE year = 1
AND period = "I semestre"

-- Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del 20/06/2020
SELECT *
FROM exams
WHERE date = "2020-06-20"
AND HOUR(hour) >= 14

SELECT *
FROM exams
WHERE date = "2020-06-20"
AND hour BETWEEN '14:00' AND '23:59'

-- Selezionare tutti i corsi di laurea magistrale
SELECT *
FROM degrees
WHERE level = "magistrale"

-- Da quanti dipartimenti è composta l'Università?
SELECT COUNT(id) AS n_departments
FROM departments

-- Quanti sono gli insegnanti che non hanno un numero di telefono?
SELECT *
FROM teachers
WHERE phone IS NULL