
CREATE TABLE logins (
  id SERIAL PRIMARY KEY,
  username TEXT,
  password TEXT
);


CREATE TABLE chitters (
  id SERIAL PRIMARY KEY,
  content TEXT,
  time TIME,
  date DATE,
-- The foreign key name is always {other_table_singular}_id

  login_id int,
  constraint fk_login foreign key(login_id)
    references logins(id)
    on delete cascade
);