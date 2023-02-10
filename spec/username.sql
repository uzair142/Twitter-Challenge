TRUNCATE TABLE logins, chitters RESTART IDENTITY; 

-- Below this line, there should only be `INSERT` statements.
--Remember to use quotation marks and not speech marks
--The statements should have ‘;’ at the end of them

INSERT INTO logins (username, password) VALUES ('Tom123', '12345');
INSERT INTO logins (username, password) VALUES ('John456','23456');
INSERT INTO logins (username, password) VALUES ('Greg789','34567');