CREATE DATABASE IF NOT EXISTS kec_r2024
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_0900_ai_ci;

USE kec_r2024;

CREATE TABLE IF NOT EXISTS students (
    roll_number VARCHAR(20) PRIMARY KEY,
    student_name VARCHAR(120) NOT NULL,
    department VARCHAR(30) NOT NULL,
    current_semester TINYINT UNSIGNED NOT NULL,
    CONSTRAINT chk_student_semester CHECK (current_semester BETWEEN 1 AND 8)
);

CREATE TABLE IF NOT EXISTS courses (
    course_code VARCHAR(20) PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    credits DECIMAL(4, 1) NOT NULL,
    course_type VARCHAR(12) NOT NULL,
    CONSTRAINT chk_course_credits CHECK (credits > 0),
    CONSTRAINT chk_course_type CHECK (course_type IN ('THEORY', 'PRACTICAL', 'EMBEDDED'))
);

CREATE TABLE IF NOT EXISTS enrollments (
    roll_number VARCHAR(20) NOT NULL,
    course_code VARCHAR(20) NOT NULL,
    semester TINYINT UNSIGNED NOT NULL,
    classes_held INT UNSIGNED NOT NULL DEFAULT 0,
    classes_attended INT UNSIGNED NOT NULL DEFAULT 0,
    medical_condonation_approved BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (roll_number, course_code, semester),
    CONSTRAINT fk_enrollment_student FOREIGN KEY (roll_number)
        REFERENCES students (roll_number),
    CONSTRAINT fk_enrollment_course FOREIGN KEY (course_code)
        REFERENCES courses (course_code),
    CONSTRAINT chk_enrollment_semester CHECK (semester BETWEEN 1 AND 8),
    CONSTRAINT chk_attendance_counts CHECK (classes_attended <= classes_held)
);

CREATE TABLE IF NOT EXISTS assessment_marks (
    roll_number VARCHAR(20) NOT NULL,
    course_code VARCHAR(20) NOT NULL,
    semester TINYINT UNSIGNED NOT NULL,
    cia_test_1 DECIMAL(5, 2) NULL,
    cia_test_2 DECIMAL(5, 2) NULL,
    assignment_mark DECIMAL(5, 2) NULL,
    quiz_mark DECIMAL(5, 2) NULL,
    lab_evaluation_mark DECIMAL(5, 2) NULL,
    ese_mark DECIMAL(5, 2) NULL,
    ese_absent BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (roll_number, course_code, semester),
    CONSTRAINT fk_marks_enrollment FOREIGN KEY (roll_number, course_code, semester)
        REFERENCES enrollments (roll_number, course_code, semester),
    CONSTRAINT chk_marks_semester CHECK (semester BETWEEN 1 AND 8),
    CONSTRAINT chk_ese_absent_mark CHECK (NOT ese_absent OR ese_mark IS NULL),
    CONSTRAINT chk_cia_test_1 CHECK (cia_test_1 IS NULL OR cia_test_1 BETWEEN 0 AND 100),
    CONSTRAINT chk_cia_test_2 CHECK (cia_test_2 IS NULL OR cia_test_2 BETWEEN 0 AND 100),
    CONSTRAINT chk_assignment_mark CHECK (assignment_mark IS NULL OR assignment_mark BETWEEN 0 AND 100),
    CONSTRAINT chk_quiz_mark CHECK (quiz_mark IS NULL OR quiz_mark BETWEEN 0 AND 100),
    CONSTRAINT chk_lab_mark CHECK (lab_evaluation_mark IS NULL OR lab_evaluation_mark BETWEEN 0 AND 100),
    CONSTRAINT chk_ese_mark CHECK (ese_mark IS NULL OR ese_mark BETWEEN 0 AND 100)
);

