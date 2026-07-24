-- ==========================================
-- Placement Intelligence Platform
-- SQL Queries
-- ==========================================

USE placement_platform;

-- ==========================================
-- BASIC QUERIES
-- ==========================================

-- 1. Display all students
SELECT * FROM Students;

-- 2. Display all companies
SELECT * FROM Companies;

-- 3. Display all skills
SELECT * FROM Skills;

-- 4. Count total students
SELECT COUNT(*) AS TotalStudents
FROM Students;

-- 5. Count total companies
SELECT COUNT(*) AS TotalCompanies
FROM Companies;

-- 6. Count total skills
SELECT COUNT(*) AS TotalSkills
FROM Skills;

-- 7. Count total assessments
SELECT COUNT(*) AS TotalAssessments
FROM Assessments;

-- 8. Count total interviews
SELECT COUNT(*) AS TotalInterviews
FROM Interviews;

-- 9. Count total offers
SELECT COUNT(*) AS TotalOffers
FROM Offers;

-- 10. Students ordered by CGPA
SELECT FullName, CGPA
FROM Students
ORDER BY CGPA DESC;

-- ==========================================
-- FILTERING
-- ==========================================

-- 11. Students with CGPA greater than 8
SELECT FullName, Branch, CGPA
FROM Students
WHERE CGPA > 8;

-- 12. Companies offering package above 10 LPA
SELECT CompanyName, Package
FROM Companies
WHERE Package > 10;

-- 13. Students from CSE branch
SELECT *
FROM Students
WHERE Branch='CSE';

-- ==========================================
-- AGGREGATE FUNCTIONS
-- ==========================================

-- 14. Average CGPA
SELECT ROUND(AVG(CGPA),2) AS AverageCGPA
FROM Students;

-- 15. Highest package offered
SELECT MAX(OfferedPackage) AS HighestPackage
FROM Offers;

-- 16. Lowest package offered
SELECT MIN(OfferedPackage) AS LowestPackage
FROM Offers;

-- 17. Average Coding Score
SELECT ROUND(AVG(CodingScore),2) AS AverageCodingScore
FROM Assessments;

-- 18. Highest Coding Score
SELECT MAX(CodingScore) AS HighestCodingScore
FROM Assessments;

-- ==========================================
-- GROUP BY
-- ==========================================

-- 19. Students branch-wise
SELECT Branch,
COUNT(*) AS TotalStudents
FROM Students
GROUP BY Branch;

-- 20. Average package branch-wise
SELECT
s.Branch,
ROUND(AVG(o.OfferedPackage),2) AS AveragePackage
FROM Students s
JOIN Offers o
ON s.StudentID=o.StudentID
GROUP BY s.Branch;

-- 21. Company-wise hiring count
SELECT
c.CompanyName,
COUNT(o.StudentID) AS StudentsHired
FROM Companies c
JOIN Offers o
ON c.CompanyID=o.CompanyID
GROUP BY c.CompanyName;

-- ==========================================
-- HAVING
-- ==========================================

-- 22. Companies giving more than 5 offers
SELECT
c.CompanyName,
COUNT(*) AS OffersGiven
FROM Offers o
JOIN Companies c
ON o.CompanyID=c.CompanyID
GROUP BY c.CompanyName
HAVING COUNT(*)>5;

-- ==========================================
-- JOINS
-- ==========================================

-- 23. Students with their skills
SELECT
s.FullName,
sk.SkillName,
ss.SkillLevel
FROM Students s
JOIN StudentSkills ss
ON s.StudentID=ss.StudentID
JOIN Skills sk
ON ss.SkillID=sk.SkillID;

-- 24. Students with placement offers
SELECT
s.FullName,
c.CompanyName,
o.OfferedPackage,
o.OfferStatus
FROM Offers o
JOIN Students s
ON o.StudentID=s.StudentID
JOIN Companies c
ON o.CompanyID=c.CompanyID;

-- 25. Assessment details
SELECT
s.FullName,
c.CompanyName,
a.CodingScore,
a.SQLScore,
a.AptitudeScore,
a.Status
FROM Assessments a
JOIN Students s
ON a.StudentID=s.StudentID
JOIN Companies c
ON a.CompanyID=c.CompanyID;

-- 26. Interview details
SELECT
s.FullName,
c.CompanyName,
i.TechnicalRound,
i.HRRound,
i.Result
FROM Interviews i
JOIN Students s
ON i.StudentID=s.StudentID
JOIN Companies c
ON i.CompanyID=c.CompanyID;

-- ==========================================
-- ORDER BY & LIMIT
-- ==========================================

-- 27. Top 10 Coding Scores
SELECT
s.FullName,
a.CodingScore
FROM Assessments a
JOIN Students s
ON a.StudentID=s.StudentID
ORDER BY a.CodingScore DESC
LIMIT 10;

-- 28. Top 10 Students by Average Score
SELECT
s.FullName,
a.CodingScore,
a.SQLScore,
a.AptitudeScore,
ROUND((a.CodingScore+a.SQLScore+a.AptitudeScore)/3,2) AS AverageScore
FROM Assessments a
JOIN Students s
ON a.StudentID=s.StudentID
ORDER BY AverageScore DESC
LIMIT 10;

-- ==========================================
-- SUBQUERY
-- ==========================================

-- 29. Students who received package above 15 LPA
SELECT FullName
FROM Students
WHERE StudentID IN
(
SELECT StudentID
FROM Offers
WHERE OfferedPackage>15
);

-- ==========================================
-- PLACEMENT SUMMARY
-- ==========================================

-- 30. Overall placement statistics
SELECT
COUNT(DISTINCT StudentID) AS TotalPlacedStudents,
ROUND(AVG(OfferedPackage),2) AS AveragePackage,
MAX(OfferedPackage) AS HighestPackage
FROM Offers;