require 'pg'
require 'username_repository'
require 'username'

def reset_login_table
 seed_sql = File.read('spec/username.sql') # Adjust the file name
  connection = PG.connect({ host: '127.0.0.1', dbname: 'chitters_test', user: 'postgres', password: 'Snowflake' }) # Database name should be the test one
  connection.exec(seed_sql)
end

describe LoginRepository do
 before(:each) do 
   reset_login_table
 end
  
 context 'Result' do
  it 'Should Return all the results' do
    login = LoginRepository.new()
    login = login.all()
    expect(login.last.id).to eq('3')
    expect(login.last.username).to eq('Greg789')
  end

  it 'should return the details or id 3' do
    login = LoginRepository.new()
    login = login.find(3)
    expect(login.id).to eq('3')
    expect(login.username).to eq('Greg789')
  end

  it 'Should add the username to the database and return nil' do
    login = Login.new()
    repo = LoginRepository.new()
    expect(repo.create('James098', '0797')).to eq(nil)
end

it 'Should add the account and return the database with it included' do
    login = Login.new()
    repo = LoginRepository.new()
    repo.create('James098', '0797')
    repo = repo.all()
    expect(repo.last.username).to eq("James098")
end

it 'Should delete the account and return the database with the value missing' do
    chits = Login.new()
    repo = LoginRepository.new()
    repo.create('James098', '0797')
    repo.delete('James098')
    repo = repo.all
    expect(repo.last.password).to eq('34567')
end
 end

    
end
  