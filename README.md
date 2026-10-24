# KEC R2024 Student Academic & Continuous Evaluation System

A menu-driven Java 17 application using JDBC and MySQL. It supports student/course registration, semester enrollment, attendance and medical condonation, incremental CIA/ESE entry, and semester/class reports.

## Rules implemented

- THEORY: internal/ESE maxima 40/60; ESE minimum 45/100; aggregate pass minimum 50.
- PRACTICAL: internal/ESE maxima 60/40; ESE minimum 50/100; aggregate pass minimum 50.
- EMBEDDED: internal/ESE maxima 50/50; ESE minimum 45/100; aggregate pass minimum 50.
- Internal score is the equally weighted average of all CIA component marks currently entered (CIA tests, assignment, quiz, lab evaluation), scaled to the course's CIA maximum. Blank components are not included.
- The mark sheet's CIA average column shows that raw average; the total column uses its weighted contribution plus the weighted ESE contribution.
- Attendance below 65% results in SA. At 65%–74.99%, ESE entry requires recorded medical-condonation approval; without it, the student is barred and the result remains incomplete. At 75% or higher, ESE entry is allowed.
- ESE absence is recorded as AB, with zero grade points. An ESE mark or AB cannot be recorded for a barred student.
- Pass grades: O 91–100 (10), A+ 81–90 (9), A 71–80 (8), B+ 61–70 (7), B 50–60 (6). Failed ESE threshold or aggregate below 50 results in RA (0).
- SGPA is credit-weighted. Reports show SGPA and its `SGPA × 10` percentage equivalent only when all enrollments have finalized results. Pending/barred courses are excluded from class-average SGPA and counted as incomplete.

## Database setup

Install MySQL 8.0.16 or later and execute `kec_schema.sql`:

```powershell
cmd /c "mysql -u root -p < kec_schema.sql"
```

The script creates the `kec_academic` database and all four required tables with foreign keys and checks.

Configure connection values using environment variables as needed:

```powershell
$env:KEC_DB_URL = "jdbc:mysql://localhost:3306/kec_academic"
$env:KEC_DB_USER = "root"
$env:KEC_DB_PASSWORD = "your-local-password"
```

The default URL is `jdbc:mysql://localhost:3306/kec_academic`, user `root`, and an empty password. Prefer environment variables to editing credentials into source code.

## Build and run

Install JDK 17+ and Maven 3.9+, then run from the project directory:

```powershell
mvn clean compile
mvn exec:java
```

Maven downloads MySQL Connector/J from the dependency declared in `pom.xml`.

## Menu walkthrough and screenshot checklist

1. Choose **1** to register a student (for example, `24ITR001`, a student name, `IT`, semester `3`).
2. Choose **2** to create a course (for example, `24ITR31`, course title, credits `3`, type `THEORY`).
3. Choose **3** to enroll the student in the course for semester 3.
4. Choose **4** to enter classes held/attended and whether approved medical condonation applies.
5. Choose **5** to enter CIA1 and CIA2 during the semester; repeat later for assignment/quiz/lab marks. Blank component values keep existing marks unchanged. After the ESE, enter its 0–100 mark or `AB`.
6. Choose **6** and enter the roll number and semester to display the grade sheet, SGPA, and equivalent percentage.
7. Choose **7** for the below-65% attendance defaulters (SA) or **8** for department pass/fail and class-average SGPA.

For submission evidence, capture terminal screenshots showing (a) successful student and course creation, (b) CIA entry followed by ESE entry, and (c) the completed semester mark sheet. This project does not include screenshots from a live database because screenshots must reflect the actual local MySQL data and credentials used for the run.
