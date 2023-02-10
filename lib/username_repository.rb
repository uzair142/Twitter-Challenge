require 'username'

class LoginRepository
    def initialize
    end

    def all
        sql = 'SELECT * FROM logins;' # Keep in mind the semi colon
        result_set = DatabaseConnection.exec_params(sql, [])
        
        accounts = []
        result_set.each do |account|
            login = Login.new()
            login.id = account['id']
            login.username = account['username']
            login.password = account['password']
            accounts << login
        end
        return accounts
    end

    def find(id)
        sql = 'SELECT * FROM logins WHERE id = $1;' # Keep in mind the semi colon
        result_set = DatabaseConnection.exec_params(sql, [id])
        accounts = result_set[0]
        account = Login.new()
        account.id = accounts['id']
        account.username = accounts['username']
        account.password = accounts['password']
        return account
    end

    def create(username, password)       
        sql = "INSERT INTO logins(username, password) VALUES ($1, $2);" # Keep in mind the semi colon
        result_set = DatabaseConnection.exec_params(sql, [username, password])
        nil
    end

    def delete(username)
        sql = "DELETE FROM logins WHERE username = '#{username}';" 
        result_set = DatabaseConnection.exec_params(sql, [])
    end

end
      