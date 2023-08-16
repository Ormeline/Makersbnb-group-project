#file: lib/user_repo.rb

require './lib/user'

class UserRepository 
                
    def create(user)
        sql = 'INSERT INTO users (username, email, password) VALUES($1, $2, $3);'
        params = [user.username, user.email, user.password]
        result = DatabaseConnection.exec_params(sql,params)
    end

    def all
        users = []

        sql = 'SELECT * FROM users;'
        result = DatabaseConnection.exec_params(sql,[])

        result.each do |record|
            users << create_user(record)
        end

        users
    end

    def find(id)
        sql = 'SELECT * FROM users WHERE id = $1;'
        params = [id]
        result = DatabaseConnection.exec_params(sql,params)
        #check if the result array isn't empty, start from the first index, User object created
        #return a new User object created from the first element in the result array, only if it isn't empty
        #if empty will return nill
        return create_user(result[0]) if result.any?
    end

    def find_by_email(email)
        sql = 'SELECT * FROM users WHERE email = $1;'
        params = [email]
        result = DatabaseConnection.exec_params(sql,params)

        return create_user(result[0]) if result.any?
    end
=begin
    def delete(id)
        sql = 'DELETE FROM users WHERE id = $1;'
        params = [id]
        DatabaseConnection.exec_params(sql, params)
    end
=end
    private

    def create_user(record)
        user = User.new
        user.id = record['id'].to_i
        user.username = record['username']
        user.email = record['email']
        user.password = record['password']

        user
    end
end
