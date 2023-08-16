
require 'sinatra/base'
require 'sinatra/reloader'
require 'pg'
require_relative 'lib/database_connection'
require './lib/user'
require './lib/listings'
require_relative 'lib/request'
require_relative 'lib/user_repo'
require_relative 'lib/listings_repository'
require_relative 'lib/request_repo'
require_relative 'lib/availability'
require_relative 'lib/availability_repo'


DatabaseConnection.connect('makersbnb_test')

class Application < Sinatra::Base

  enable :sessions

  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/listings_repository'
    also_reload 'lib/availability_repo'
    also_reload 'lib/request_repo'
    also_reload 'lib/user_repo'
  end

  get '/' do
    return erb(:loginpage)
  end

  post '/' do
    email = params[:email]
    password = params[:password]
    user_repo = UserRepository.new
    user = user_repo.find_by_email(email)

    if user.password == password 
      session[:id] = user.id
      redirect('/listings')

    else
      status 400
    end
  end

  get '/listing/:id' do
    listing_repo = ListingsRepository.new
    availability_repo = AvailabilityRepo.new
    @listing = listing_repo.find(params[:id])
    @dates = availability_repo.find_dates(params[:id])
    return erb(:listing)
  end

  get '/listings' do
    if session[:id].nil? 
      status 400
    else
      repo = ListingsRepository.new
      @listings = repo.all
      return erb(:listings)
    end
  end

  get '/requests' do
    request_repo = RequestRepository.new
    @listings = ListingsRepository.new 
    @users = UserRepository.new 
    # @listings = listing_repo.find(id)
    @requests = request_repo.find_by_from_user_id(session[:id])
    p @requests 
    p @listings
    return erb(:requests)
  end 
  
  get '/new_listing' do
    #redirect '/'unless session[:id] #ensure the user is logged in
    return erb(:new_listing)
  end

  post '/new_listing' do
    redirect '/' unless session[:id]

    listing = Listings.new
    listing.user_id = session[:id]
    listing.name = params[:name]
    listing.description = params[:description]
    listing.price_per_night = params[:price_per_night]
    listing.date_from = params[:date_from]
    listing.date_to = params[:date_to]

    repo = ListingsRepository.new
    repo.create(listing)
    redirect '/listings' 
  end

  post '/requests' do
    request = Request.new
    request.listing_id = params[:listing_id]
    request.from_date = params[:from_date]
    request.to_date = params[:to_date]
    #if you want to add user_id and others
    repo = RequestRepository.new
    repo.create(request)
    redirect '/requests/confirm'
  end

  post '/logout' do
    session[:id] = nil
    redirect('/')
  end
end
