require 'pg'
require 'chitter_repository'
require 'chitter'

def reset_chitters_table
    seed_sql = File.read('spec/chitters.sql') # Adjust the file name
    connection = PG.connect({ host: '127.0.0.1', dbname: 'chitters_test', user: 'postgres', password: 'Snowflake' }) # Database name should be the test one
    connection.exec(seed_sql)
  end
  
  describe ChittersRepository do
    before(:each) do 
      reset_chitters_table
    end
  
    context 'Result' do
        it 'Should return all three entries' do
            chits = Chitters.new()
            repo = ChittersRepository.new()
            repo = repo.all()
            expect(repo.first.id).to eq("1")
            expect(repo[1].date).to eq('2023-02-10')
            expect(repo.last.time).to include('17:31:00')
        end

        it 'Should return the correct entry' do
            repo = ChittersRepository.new()
            result = repo.find(2)
            expect(result.date).to eq('2023-02-10')
        end

        it 'Should add the username to the database and return nil' do
            chits = Chitters.new()
            repo = ChittersRepository.new()
            expect(repo.create('It is raining')).to eq(nil)
        end

        it 'Should add the account and return the database with it included' do
            chits = Chitters.new()
            repo = ChittersRepository.new()
            repo.create('It is raining')
            repo = repo.all()
            expect(repo.last.content).to eq("It is raining")
        end

        it 'Should delete the account and return the database with the value missing' do
            chits = Chitters.new()
            repo = ChittersRepository.new()
            repo.create('It is raining')
            repo.delete("It is raining")
            repo = repo.all
            expect(repo.last.content).to eq("I want to sleep")
        end

    end


  end
  