#file: spec/request_repo_spec.rb

require 'date'
require 'spec_helper'
require './lib/request_repo'

RSpec.describe RequestRepository do

  def reset_requests_table
    seed_sql = File.read('spec/seed_data.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_requests_table
  end

  it 'creates a new request' do
    repo = RequestRepository.new

    created_request = Request.new
    created_request.from_user_id = 1
    created_request.to_user_id = 2
    created_request.listing_id = 1
    created_request.date = Date.new(2023, 6, 1)

    repo.create(created_request)
    requests = repo.all

    last_request = requests.last

    expect(requests.length).to eq(2)
    expect(last_request.from_user_id).to eq(1)
    expect(last_request.to_user_id).to eq(2)
    expect(last_request.listing_id).to eq(1)
    expect(last_request.date).to eq Date.new(2023, 6, 1)
  end
  
  it 'finds request by from_user_id' do
    repo = RequestRepository.new
    request = repo.find_by_from_user_id(1)

    expect(request.first.from_user_id).to eq (1)
  end

  it 'finds request by to_user_id' do
    repo = RequestRepository.new
    request = repo.find_by_to_user_id(2)
    expect(request.first.to_user_id).to eq (2)
  end

  it 'approves a request' do
    repo = RequestRepository.new
    request = repo.find_by_from_user_id(1).first

    repo.approve(request.id)

    updated_request = repo.find(request.id)
    expect(updated_request.confirmed_status).to eq(true)
  end

  it 'declines a request' do
    repo = RequestRepository.new
    request = repo.find_by_from_user_id(1).first

    repo.decline(request.id)
    updated_request = repo.find(request.id)
    expect(updated_request.confirmed_status).to eq(false)
  end
end