require 'chitter'

class ChittersRepository
    def initialize
    end

    def all
        sql = 'SELECT * FROM chitters;' # Keep in mind the semi colon
        result_set = DatabaseConnection.exec_params(sql, [])
        
        chit = []
        result_set.each do |chitter|
            chitt = Chitters.new()
            chitt.id = chitter['id']
            chitt.content = chitter['content']
            chitt.date = chitter['date']
            chitt.time = chitter['time']
            chit << chitt
        end
        return chit
    end

    def find(id)
      sql = 'SELECT * FROM chitters WHERE id = $1;' # Keep in mind the semi colon
      result_set = DatabaseConnection.exec_params(sql, [id])
      chitter = result_set[0]
      chitt = Chitters.new()
      chitt.id = chitter['id']
      chitt.content = chitter['content']
      chitt.date = chitter['date']
      chitt.time = chitter['time']
      return chitt
    end

    def create(content)
        time = Time.new
        current_date = time.strftime("%Y-%m-%d")
        current_time = time.strftime("%H:%M:%S")        
        sql = "INSERT INTO chitters(content, date, time) VALUES ($1, '#{current_date}', '#{current_time}');" # Keep in mind the semi colon
        result_set = DatabaseConnection.exec_params(sql, [content])
        nil
    end

    def delete(content)
        sql = "DELETE FROM chitters WHERE content = '#{content}';" 
        result_set = DatabaseConnection.exec_params(sql, [])
    end



    


end