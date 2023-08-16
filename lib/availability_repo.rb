require_relative 'availability'

class AvailabilityRepo

  def create(availability_obj)
    sql = 'INSERT INTO availability(listing_id, date) VALUES ($1, $2);'
    params = [availability_obj.listing_id, availability_obj.date]
    result = DatabaseConnection.exec_params(sql, params)
  end

  def find_dates(listing_id)
    sql = 'SELECT * FROM availability WHERE listing_id = $1;'
    params = [listing_id]
    result = DatabaseConnection.exec_params(sql, params)
    dates = []
    
    result.each do |date|
      if date['available'] == 't'
        available = Availability.new
        available.id = date['id'].to_i
        available.listing_id = date['listing_id'].to_i
        available.date = date['date']
        available.available = date['available']
        dates << available
      end
    end 
    return dates
  end
  
  def unavailable(id)
    sql = 'UPDATE availability SET available = false WHERE id = $1;'
    params = [id]
    DatabaseConnection.exec_params(sql, params)
  end
end