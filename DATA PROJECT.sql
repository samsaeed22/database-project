create database laborATION;
CREATE TABLE Laboratorian ( 
Laboratorian_ID INT PRIMARY KEY, 
name VARCHAR (100) NOT NULL,
 Phone_number VARCHAR (20), 
address VARCHAR (255)
 );
 CREATE TABLE Patient ( 
Patient_ID INT PRIMARY KEY, 
name VARCHAR(100) NOT NULL,
 phone_number VARCHAR(20), 
address VARCHAR(255),
 birth_date DATE,
 job VARCHAR (100) 
);
CREATE TABLE Component ( 
Component_ID INT PRIMARY KEY, 
name VARCHAR(100) NOT NULL, 
available_quantity INT NOT NULL, 
minimum_quantity INT NOT NULL 
);
CREATE TABLE Medical_Test (
 Test_ID INT PRIMARY KEY, 
name VARCHAR(100) NOT NULL, 
price DECIMAL(10,2) NOT NULL 
);
CREATE TABLE Test_Component ( 
Test_ID INT, 
Component_ID INT,
 PRIMARY KEY (Test_ID, Component_ID), 
FOREIGN KEY (Test_ID) REFERENCES Medical_Test(Test_ID), 
FOREIGN KEY (Component_ID) REFERENCES Component(Component_ID) 
);


CREATE TABLE Test_Result (
 Result_ID INT PRIMARY KEY, 
Test_ID INT, 
date DATE NOT NULL,
 Patient_ID INT, 
Laboratorian_ID INT, 
result VARCHAR (255), FOREIGN KEY (Test_ID) REFERENCES Medical_Test(Test_ID), FOREIGN KEY (Patient_ID) REFERENCES Patient (Patient_ID),
 FOREIGN KEY (Laboratorian_ID) REFERENCES Laboratorian (Laboratorian_ID) 
);
INSERT INTO Laboratorian VALUES 
(1, 'Yousef Kamal', '0155555555', 'Cairo'), 
(2, 'Lina Farouk', '0123456789', 'Alexandria'),
(3, 'Samir Nabil', '0112345678', 'Giza'),
(4, 'Dina Youssef', '0109876543', 'Cairo'),
(5, 'Hassan Adel', '0133333333', 'Tanta'), 
(6, 'Mona Sherif', '0144444444', 'Mansoura'), 
(7, 'Omar Khaled', '0156666666', 'Cairo'),
(8, 'Rania Ibrahim', '0167777777', 'Alexandria'), 
(9, 'Tariq Sami', '0178888888', 'Cairo'),
(10, 'Nahla Samir', '0189999999', 'Giza');
INSERT INTO Patient VALUES 
(1001, 'Sara Ibrahim', '0191111111', 'Cairo', '1983-02-14', 'Architect'),
(1002, 'Ahmed Mostafa', '0112222222', 'Alexandria', '1989-07-21', 'Engineer'),
(1003, 'Mona Khalil', '0123333333', 'Giza', '1979-12-01', 'Teacher'),
(1004, 'Hany Nasser', '0134444444', 'Cairo', '1985-04-25', 'Pharmacist'), 
(1005, 'Laila Farid', '0145555555', 'Tanta', '1993-11-30', 'Nurse'), 
(1006, 'Khaled Salah', '0156666666', 'Mansoura', '1982-09-10', 'Lawyer'), 
(1007, 'Nada Samir', '0167777777', 'Cairo', '1986-03-05', 'Accountant'),
(1008, 'Tamer Maher', '0178888888', 'Alexandria', '1994-06-18', 'Designer'), 
(1009, 'Amira Adel', '0189999999', 'Giza', '1977-08-22', 'Doctor'),
(1010, 'Omar Khaled', '0190000000', 'Cairo', '1991-01-30', 'Student');
INSERT INTO Component VALUES 
(1, 'Serum Separator Tube', 60, 15),
(2, 'Blood Glucose Reagent', 25, 20), 
(3, 'Hemoglobin A1c Reagent', 50, 30), 
(4, 'Glass Microscope Slides', 55, 20),
(5, 'Sterile Urine Cups', 40, 20), 
(6, 'Chemical Reagent X', 18, 12),
(7, 'Chemical Reagent Y', 10, 15),
(8, 'Plastic Test Tubes', 45, 20),
(9, 'Sterile Alcohol Swabs', 75, 40), 
(10, 'Disposable Gloves', 110, 60);
INSERT INTO Medical_Test VALUES 
(101, 'Complete Blood Count', 180.00), 
(102, 'Fasting Blood Sugar', 130.00),
(103, 'Urine Routine Test', 110.00), 
(104, 'Liver Enzymes Test', 210.00),
(105, 'Kidney Profile', 195.00), 
(106, 'Cholesterol Test', 170.00),
(107, 'Thyroid Panel', 175.00), 
(108, 'Vitamin B12 Test', 165.00), 
(109, 'COVID-19 Antigen', 320.00),
(110, 'Electrolytes Test', 150.00);
INSERT INTO Test_Component VALUES
(101, 1), 
(101, 3),
(102, 2), 
(103, 5), 
(104, 6),
(105, 7),
(106, 8), 
(107, 9), 
(108, 10), 
(109, 4), 
(110, 3);
INSERT INTO Test_Result VALUES 
(1, 101, '2025-01-15', 1001, 2, 'CBC within normal range'), 
(2, 102, '2025-02-10', 1002, 3, 'Slightly elevated blood sugar'), 
(3, 103, '2025-03-05', 1003, 4, 'Urine test normal'), 
(4, 104, '2025-01-25', 1004, 5, 'Mildly elevated liver enzymes'), 
(5, 105, '2025-02-15', 1005, 6, 'Kidney function normal'), 
(6, 106, '2025-03-20', 1006, 7, 'Cholesterol high'), 
(7, 107, '2025-01-30', 1007, 8, 'Normal thyroid levels'), 
(8, 108, '2025-02-28', 1008, 9, 'Vitamin B12 deficiency'), 
(9, 109, '2025-03-15', 1009, 10, 'COVID-19 antigen negative'), 
(10, 110, '2025-01-10', 1010, 1, 'Electrolyte levels normal');
SELECT DISTINCT p.name 
FROM Patient p 
JOIN Test_Result tr ON p.Patient_ID = tr.Patient_ID 
JOIN Medical_Test mt ON tr.Test_ID = mt.Test_ID 
WHERE mt.name = 'Complete Blood Count' 
  AND tr.date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR);
SELECT name, available_quantity, minimum_quantity 
FROM Component 
WHERE available_quantity < minimum_quantity;
SELECT p.name, SUM(mt.price) AS total_paid 
FROM Patient p
JOIN Test_Result tr ON p.Patient_ID = tr.Patient_ID 
JOIN Medical_Test mt ON tr.Test_ID = mt.Test_ID 
WHERE p.Patient_ID = 1001 
  AND tr.date >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR) 
GROUP BY p.Patient_ID;
SELECT p.name, SUM(mt.price) AS total_paid 
FROM Patient p
JOIN Test_Result tr ON p.Patient_ID = tr.Patient_ID 
JOIN Medical_Test mt ON tr.Test_ID = mt.Test_ID 
WHERE p.Patient_ID = 12527 
  AND tr.date >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR) 
GROUP BY p.Patient_ID;
