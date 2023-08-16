require_relative 'spec_helper'
require './lib/user_repo'

RSpec.describe UserRepository do
    def reset_user_table
        seed_sql = File.read('spec/seed_data.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
        connection.exec(seed_sql)
    end
    
    before(:each) do
        reset_user_table
    end

    it 'creates a new user' do
        repo = UserRepository.new
        created_user = User.new
        created_user.username = 'test1'
        created_user.email = 'test1@email.com'
        created_user.password = 'testpassword1'

        repo.create(created_user)
        users = repo.all

        last_users = users.last
        
        expect(users.length).to eq(4)
        expect(created_user.username).to eq('test1')
        expect(created_user.email).to eq('test1@email.com')
        expect(created_user.password).to eq('testpassword1')
    end

    it 'returns the user with the given email' do
        repo = UserRepository.new
        user = repo.find_by_email('user1@email.com')

        expect(user.username).to eq('user1')
        expect(user.password).to eq('password1')
    end

    it 'returns the user with the given id' do
        repo = UserRepository.new
        user = repo.find(1)

        expect(user.username).to eq('user1')
        expect(user.email).to eq('user1@email.com')
    end
end