#file: lib/request_repo.rb

require 'date'
require './lib/request'

class RequestRepository
  
  def create(request)
    sql = 'INSERT INTO requests (from_user_id, to_user_id, listing_id, date, confirmed_status, availability_id) VALUES ($1, $2, $3, $4, $5, $6);'
    params = [request.from_user_id, request.to_user_id, request.listing_id, request.date.to_s, request.confirmed_status, request.availability_id]
    result = DatabaseConnection.exec_params(sql, params)
    record = result.first
    request
  end
  
  def all
    requests = []
    sql = 'SELECT * FROM requests;'
    result = DatabaseConnection.exec_params(sql,[])
    result.each do |record|
        requests << create_request(record)
    end
    requests
  end

  def find(id)
    sql = 'SELECT * FROM requests WHERE id = $1;'
    params = [id]
    result = DatabaseConnection.exec_params(sql,params)
    return create_request(result[0]) if result.any?
  end

  def find_by_email(email)
      sql = 'SELECT * FROM requests WHERE email = $1;'
      params = [email]
      result = DatabaseConnection.exec_params(sql,params)

      return create_request(result[0]) if result.any?
  end

  def find_by_from_user_id(user_id)
    sql = 'SELECT * FROM requests WHERE from_user_id = $1;'
    params =[user_id]
    result = DatabaseConnection.exec_params(sql, params)
    result.map { |record| create_request(record) } if result.any?
  end

  def find_by_to_user_id(user_id)
    sql = 'SELECT * FROM requests WHERE to_user_id = $1;'
    params =[user_id]
    result = DatabaseConnection.exec_params(sql, params)
    result.map { |record| create_request(record) } if result.any?
  end

  def approve(request_id)
    sql = 'UPDATE requests SET confirmed_status = true WHERE id = $1;'
    params = [request_id]
    result = DatabaseConnection.exec_params(sql, params)
  end

  def decline(request_id)
    sql = 'UPDATE requests SET confirmed_status = false WHERE id = $1;'
    params = [request_id]
    DatabaseConnection.exec_params(sql, params)
  end

  private

  def create_request(record)
    request = Request.new
    request.id = record['id'].to_i
    request.from_user_id = record['from_user_id'].to_i
    request.to_user_id = record['to_user_id'].to_i
    request.listing_id = record['listing_id'].to_i
    request.date = Date.parse(record['date']) 
    request.confirmed_status = record['confirmed_status'] == 't' ? true : false
    request
  end
end