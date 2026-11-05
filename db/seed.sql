USE CollabSpaceDB;

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE `EditOperation`;
TRUNCATE TABLE `DocumentSnapshot`;
TRUNCATE TABLE `Session`;
TRUNCATE TABLE `Document`;
TRUNCATE TABLE `User`;
SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO `User` (UserID, FirstName, LastName, Email) VALUES
(1,'Aarav','Sharma','aarav.sharma@example.com'),
(2,'Priya','Patel','priya.patel@example.com'),
(3,'Rohan','Mehta','rohan.mehta@example.com'),
(4,'Sneha','Reddy','sneha.reddy@example.com'),
(5,'Vikram','Singh','vikram.singh@example.com'),
(6,'Ananya','Iyer','ananya.iyer@example.com'),
(7,'Karthik','Nair','karthik.nair@example.com'),
(8,'Meera','Joshi','meera.joshi@example.com'),
(9,'Aditya','Gupta','aditya.gupta@example.com'),
(10,'Ishita','Desai','ishita.desai@example.com');

INSERT INTO `Document` (DocumentID, Title, OwnerID, CreatedAt) VALUES
(1,'Q3 Financial Report',1,'2026-10-01 09:00:00'),
(2,'Project Apollo Specifications',2,'2026-10-05 10:15:00'),
(3,'Marketing Campaign 2027',3,'2026-10-10 14:30:00'),
(4,'Team Onboarding Guide',4,'2026-10-15 11:00:00'),
(5,'Database Schema Design',5,'2026-10-20 16:45:00'),
(6,'Client Meeting Notes',6,'2026-10-25 09:30:00'),
(7,'Annual Leave Policy',7,'2026-10-28 13:20:00'),
(8,'API Documentation',8,'2026-11-01 10:00:00'),
(9,'Server Infrastructure Plan',9,'2026-11-02 15:10:00'),
(10,'User Research Findings',10,'2026-11-03 09:45:00');

INSERT INTO `Session` (SessionID, DocumentID, UserID, ConnectedAt, LastSeenAt, Status) VALUES
(1,1,1,'2026-11-05 09:00:00','2026-11-05 09:00:00','Active'),
(2,2,2,'2026-11-05 09:00:00','2026-11-05 09:00:00','Active'),
(3,3,3,'2026-11-05 09:00:00','2026-11-05 09:00:00','Active'),
(4,4,4,'2026-11-05 09:05:00','2026-11-05 09:05:00','Active'),
(5,5,5,'2026-11-05 09:05:00','2026-11-05 09:05:00','Active'),
(6,6,6,'2026-11-05 09:05:00','2026-11-05 09:05:00','Active'),
(7,7,7,'2026-11-05 09:05:00','2026-11-05 09:05:00','Active'),
(8,8,8,'2026-11-05 09:05:00','2026-11-05 09:05:00','Active'),
(9,9,9,'2026-11-04 18:00:00','2026-11-04 18:10:00','Closed'),
(10,10,10,'2026-11-04 18:00:00','2026-11-04 18:10:00','Closed');

INSERT INTO `DocumentSnapshot` (SnapshotID, DocumentID, SnapshotContent, TakenAt) VALUES
(1,1,'Snapshot of document 1','2026-11-05 09:10:00'),
(2,2,'Snapshot of document 2','2026-11-05 09:10:00'),
(3,3,'Snapshot of document 3','2026-11-05 09:10:00'),
(4,4,'Snapshot of document 4','2026-11-05 09:10:00'),
(5,5,'Snapshot of document 5','2026-11-05 09:10:00'),
(6,6,'Snapshot of document 6','2026-11-05 09:10:00'),
(7,7,'Snapshot of document 7','2026-11-05 09:10:00'),
(8,8,'Snapshot of document 8','2026-11-05 09:10:00'),
(9,9,'Snapshot of document 9','2026-11-05 09:10:00'),
(10,10,'Snapshot of document 10','2026-11-05 09:10:00');

INSERT INTO `EditOperation` (DocumentID, SessionID, OpType, PositionIndex, Content, AppliedAt)
SELECT
    1 + (n % 10),
    1 + (n % 10),
    CASE WHEN n % 2 = 0 THEN 'INSERT' ELSE 'DELETE' END,
    n % 100,
    CONCAT('op-', n),
    TIMESTAMPADD(SECOND, n, '2026-11-01 09:00:00')
FROM (
    SELECT ones.n + tens.n * 10 + hundreds.n * 100 AS n
    FROM (SELECT 0 AS n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
          UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) ones
    CROSS JOIN (SELECT 0 AS n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
          UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) tens
    CROSS JOIN (SELECT 0 AS n UNION ALL SELECT 1 UNION ALL SELECT 2) hundreds
) numbers
WHERE n BETWEEN 1 AND 200;
