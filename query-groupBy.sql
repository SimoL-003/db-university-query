-- Contare quanti iscritti ci sono stati ogni anno
SELECT YEAR(enrolment_date) AS enrolment_year, COUNT(id) AS n_students
FROM students
GROUP BY enrolment_year

-- Contare gli insegnanti che hanno l'ufficio nello stesso edificio
SELECT office_address, COUNT(id) AS n_teachers
FROM teachers
GROUP BY office_address

-- Calcolare la media dei voti di ogni appello d'esames
SELECT exam_id, AVG(vote) AS average_grade
FROM exam_student
GROUP BY exam_id

-- Contare quanti corsi di laurea ci sono per ogni dipartimento
SELECT department_id, COUNT(id) AS n_degrees
FROM degrees
GROUP BY department_id