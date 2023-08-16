# file ./lib/listings_repository.rb
require 'date'
require './lib/listings'


class ListingsRepository
  
  def create(listing)
    sql = 'INSERT INTO listings (user_id, name, description, price_per_night, date_from, date_to) VALUES ($1, $2, $3, $4, $5, $6);'
    params = [listing.user_id, listing.name, listing.description, listing.price_per_night, listing.date_from, listing.date_to]
    result = DatabaseConnection.exec_params(sql, params)
  end

  def all
    sql = 'SELECT * FROM listings;'
    result = DatabaseConnection.exec_params(sql, [])
    listings = []
    
    result.each do |record|
      listings << create_listing(record)
    end
    listings
  end

  def find(id)
    sql = 'SELECT * FROM listings WHERE id = $1;'
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)

    if result.any?
      create_listing(result.first)
    else
      nil
    end
  end

  private

  def create_listing(record)
    listing = Listings.new
    listing.id = record['id'].to_i
    listing.user_id = record['user_id'].to_i
    listing.name = record['name']
    listing.description = record['description']
    listing.price_per_night = record['price_per_night'].to_f
    listing.date_from = record['date_from']
    listing.date_to = record['date_to']
    return listing
  end

  def get_dates_in_between(start_date, end_date)
    start_date = Date.parse(start_date)
    end_date = Date.parse(end_date)
    dates_in_between = []
    
    while start_date <= end_date
      dates_in_between << start_date.strftime("%Y-%m-%d")
      start_date += 1
    end  
    return dates_in_between
  end

end
