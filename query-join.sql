-- Selezionare tutti gi studenti iscritti al Corso di Laurea in Economia
SELECT students.*
FROM students
INNER JOIN degrees
ON students.degree_id = degrees.id
WHERE degrees.name = "Corso di Laurea in Economia"
ORDER BY students.surname, students.name

-- Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze
SELECT degrees.*
FROM degrees
INNER JOIN departments
ON degrees.department_id = departments.id
WHERE departments.name = "Dipartimento di Neuroscienze"
AND degrees.level = "magistrale"

-- Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
SELECT courses.*, teachers.name AS teacher_name, teachers.surname AS teacher_surname, teachers.id AS teacher_id
FROM teachers
INNER JOIN course_teacher
ON course_teacher.teacher_id = teachers.id
INNER JOIN courses
ON course_teacher.course_id = courses.id
WHERE teachers.id = 44

-- Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento in ordine alfabetico per cognome e nome
SELECT students.*, degrees.name AS degree, degrees.level AS degree_level,
	departments.name AS department, departments.id AS department_id
FROM students
INNER JOIN degrees
ON students.degree_id = degrees.id
INNER JOIN departments
ON degrees.department_id = departments.id
ORDER BY students.surname, students.name

-- Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
SELECT courses.id AS course_id, courses.name AS course,
    degrees.id AS degrees_id, degrees.name AS degree, degrees.level AS level,
    teachers.id AS teacher_id, teachers.surname AS teacher_surname, teachers.name AS teacher_name
FROM degrees
INNER JOIN courses
ON courses.degree_id = degrees.id
INNER JOIN course_teacher
ON course_teacher.course_id = courses.id
INNER JOIN teachers
ON teachers.id = course_teacher.teacher_id
ORDER BY degrees_id, course_id

-- Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica
SELECT DISTINCT teachers.*
FROM teachers
INNER JOIN course_teacher
ON course_teacher.teacher_id = teachers.id
INNER JOIN courses
ON courses.id = course_teacher.course_id
INNER JOIN degrees
ON degrees.id = courses.degree_id
INNER JOIN departments
ON departments.id = degrees.department_id
WHERE departments.name = "Dipartimento di Matematica"
ORDER BY teachers.surname, teachers.name

-- BONUS
-- Selezionare, per ogni stuende, quanti tentativi d'esame ha sostenuto per superare ciascuno dei suoi esami
SELECT students.id, students.surname, students.name, students.registration_number, MAX(exam_student.vote),
courses.id AS course_id, courses.name AS course, COUNT(exams.id)
FROM students
INNER JOIN exam_student
ON exam_student.student_id = students.id
INNER JOIN exams
ON exams.id = exam_student.exam_id
INNER JOIN courses
ON courses.id = exams.course_id
GROUP BY students.id, exams.course_id
HAVING MAX(exam_student.vote) >= 18
ORDER BY students.surname, students.name, course_id

-- Se trasformi le INNER JOIN in LEFT JOIN e togliendo la HAVING puoi aspettarti di vedere qualcosa di diverso? Se sì, cosa?
    --  Togliendo HAVING vengono mostrati anche gli studenti che non hanno superato nessun esame; sostituendo LEFT a INNER vengono inclusi anche gli studenti che non hanno sostenuto esami


-- Cosa cambia se invece di COUNT(exams.id) fai COUNT(*)?
    -- Teoricamente non dovrebbe cambiare nulla

-- Sapresti trovare il numero esatto di studenti che NON hanno ancora sostenuto esami? Come puoi sapere che è il numero corretto?

SELECT COUNT(students.id)
FROM students
LEFT JOIN exam_student
ON exam_student.student_id = students.id
WHERE exam_student.exam_id IS NULL

SELECT COUNT(students.id)
FROM students
LEFT JOIN exam_student
ON exam_student.student_id = students.id
GROUP BY exam_student.exam_id
HAVING COUNT(exam_student.exam_id) = 0

    -- Verifica:
    SELECT *
    FROM students
    -- 5000 (studenti totali)

    SELECT DISTINCT student_id
    FROM exam_student
    -- 4979 (studenti che hanno sostenuto almeno un esame)

    -- Studenti che non hanno sostenuto esami: 21

