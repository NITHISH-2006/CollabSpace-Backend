USE CollabSpaceDB;

-- T1 UNIQUE(Email): expected to FAIL (duplicate email)
INSERT INTO `User` (FirstName, LastName, Email)
VALUES ('Duplicate', 'User', 'aarav.sharma@example.com');

-- T2 NOT NULL: expected to FAIL (LastName is NULL)
INSERT INTO `User` (FirstName, LastName, Email)
VALUES ('NoLast', NULL, 'nolast@example.com');

-- T3 FOREIGN KEY(Document.OwnerID): expected to FAIL (owner 9999 does not exist)
INSERT INTO `Document` (Title, OwnerID, CreatedAt)
VALUES ('Bad FK', 9999, NOW());

-- T4 DEFAULT(Status): expected to SUCCEED with Status = 'Active'
INSERT INTO `Session` (DocumentID, UserID)
VALUES (1, 1);
SET @new_session = LAST_INSERT_ID();
SELECT SessionID, Status FROM `Session` WHERE SessionID = @new_session;
DELETE FROM `Session` WHERE SessionID = @new_session;

-- T5 FOREIGN KEY(EditOperation.SessionID): expected to FAIL (session 9999 does not exist)
INSERT INTO `EditOperation` (DocumentID, SessionID, OpType, PositionIndex, Content)
VALUES (1, 9999, 'INSERT', 0, 'x');
