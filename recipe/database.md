How to design a schema table:
# Two Tables Design Recipe Template
________________________________________________________________________________________________
USER STORY:

As a Maker
So that I can let people know what I am doing  
I want to post a message (peep) to chitter

As a maker
So that I can see what others are saying  
I want to see all peeps in reverse chronological order

As a Maker
So that I can better appreciate the context of a peep
I want to see the time at which it was made

As a Maker
So that I can post messages on Chitter as me
I want to sign up for Chitter

________________________________________________________________________________________________
Nouns: User, Message, Time and date, Username, Password
Table one: Message, Time, Date
Table two: Username, Password
________________________________________________________________________________________________________________________________________________________________________________________________
## 2. Infer the Table Name and Columns
Record 1: Chitters
Properties: Contents, Time, Date

Record 2: Logins
Properties: Username, Password
________________________________________________________________________________________________________________________________________________________________________________________________
## 4. Decide on The Tables Relationship 
Most of the time, you'll be using a **one-to-many** relationship, and will need a **foreign key** on one of the two tables.

To decide on which one, answer these two questions:

1. Can one [Chitters] have many [Login]? No
2. Can one [Logins] have many [Chitters]? Yes

Consequently:
1. **[Logins] has many [Chitters]**
2. And on the other side, **[Chitters] belongs to [Logins]**
3. In that case, the foreign key is in the table [Chitters]

*If you can answer YES to the two questions, you'll probably have to implement a Many-to-Many relationship, and 
________________________________________________________________________________________________________________________________________________________________________________________________
## 4. Decide the column types and Write the SQL
Standard types: ‘text’, ‘int’, ‘bigint’, ‘numeric’, ‘boolean’, ‘date’
Further types: https://www.postgresql.org/docs/current/datatype.html
Note: id: SERIAL should always be first

# Write it in a separate .sql file

#For one-to-many:

Table without the foreign key first:
CREATE TABLE artists (
  id SERIAL PRIMARY KEY,
  content TEXT
  time TIME
  date DATE
);

Table with the foreign key:
CREATE TABLE albums (
  id SERIAL PRIMARY KEY,
  username TEXT
  password TEXT
-- The foreign key name is always {other_table_singular}_id

  chitter_id int,
  constraint fk_chitter foreign key(chitter_id)
    references chitters(id)
    on delete cascade
);



*Artist_id: id column in the artists table. 
*Constraint fk_artist:  Ensures that the value stored in the artist_id column must be present in the id column of the artists table. 
*On delete cascade: If a record in the artists table is deleted, all the records in this table with a corresponding artist_id will also be deleted.
________________________________________________________________________________________________________________________________________________________________________________________________
## 5. Create the tables.
psql -h 127.0.0.1 database_name < albums_table.sql
________________________________________________________________________________________________________________________________________________________________________________________________
## 6. Set up the project
Steps:
…Set up a rspec project  
…bundle add pg
…Create:
---project/
--------app.rb
--------lib/
-------------student.rb
-------------student_repository.rb
-------------database_connection.rb
--------spec/
-------------student_repository_spec.rb
-------------seeds_tablename.sql
________________________________________________________________________________________________
#lib/database_connection.rb:

require 'pg'


class DatabaseConnection
  def self.connect(database_name)
    @connection = PG.connect({ host: '127.0.0.1', dbname: database_name, user: ‘postgres’, password: ‘Snowflake’ })
  end

  def self.exec_params(query, params)
    if @connection.nil?
      raise 'DatabaseConnection.exec_params: Cannot run a SQL query as the connection to'\
      'the database was never opened. Did you make sure to call first the method '\
      '`DatabaseConnection.connect` in your app.rb file (or in your tests spec_helper.rb)?'
    end
    @connection.exec_params(query, params)
  end
end
___________________________________________________________________________
#spec/spec_helper.rb

require 'database_connection'

# Make sure this connects to your test database
# (its name should end with '_test')
DatabaseConnection.connect('your_database_name_test')

________________________________________________________________________________________________
#app.rb

require_relative 'lib/database_connection'

DatabaseConnection.connect('music_library')

# Perform a SQL query on the database and get the result set.
sql = Fill in SQL Query
result = DatabaseConnection.exec_params(sql, [])

________________________________________________________________________________________________________________________________________________________________________________________________
## 7. Create SQL seeds
#spec/seeds_tablename.sql
TRUNCATE TABLE tablename RESTART IDENTITY; 

-- Below this line, there should only be `INSERT` statements.
--Remember to use quotation marks and not speech marks
--The statements should have ‘;’ at the end of them


psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql

________________________________________________________________________________________________
## 8. Design the classes
Model class:
class chitters
  attr_accessor :id, :content, :date, :time
end

Repository Class:

def intitialize
end

def all    
end

def find(id)
end

def create(chit)
end

def update(chit)
end

def delete(chit)
end


Model class:
class login
  attr_accessor :id, :username, :password
end

Repository Class:

def intitialize
end

def all    
end

def find(id)
end

def create(username, password)
end

def update(username)
end

def delete(username)
end

# require_relative './accounts'
________________________________________________________________________________________________________________________________________________________________________________________________
## 8. Write Test Examples

Chitters:
## .all should show all the three entries
## .find(2) should show the second entry
## .create should add an entry and store a time and date with it
## .create and then .all should show the additional entry
## .update should update a chit
## .delete should delete a chit
________________________________________________________________________________________________________________________________________________________________________________________________
## 9. Test Drive
________________________________________________________________________________________________
#spec/_repository_spec.rb
def reset_students_table
  seed_sql = File.read('spec/seeds_table.sql') # Adjust the file name
  connection = PG.connect({ host: '127.0.0.1', dbname: database_name, user: ‘postgres’, password: ‘Snowflake’ }) # Database name should be the test one
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end


___________________________________________________________________________
sql = 'SELECT … email FROM …;' # Keep in mind the semi colon
        result_set = DatabaseConnection.exec_params(sql, [])

___________________________________________________________________________







