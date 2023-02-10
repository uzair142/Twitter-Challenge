TRUNCATE TABLE chitters, logins RESTART IDENTITY; 

-- Below this line, there should only be `INSERT` statements.
--Remember to use quotation marks and not speech marks
--The statements should have ‘;’ at the end of them

INSERT INTO chitters (content, date, time) VALUES ('I hate Elon Musk', '2023-02-09', '17:30:00' );
INSERT INTO chitters (content, date, time) VALUES ('I like cheese', '2023-02-10', '17:34:00' );
INSERT INTO chitters (content, date, time) VALUES ('I want to sleep', '2023-02-11', '17:31:00');