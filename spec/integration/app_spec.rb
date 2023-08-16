#file: spec/integration/app_spec.rb
require "spec_helper"
require "rack/test"
require_relative '../../app'
require 'json'


describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context 'GET /' do
    it 'should return a login page' do
      response = get('/')
      expect(response.status).to eq(200)
      expect(response.body).to include ('<h1>Welcome to ACMO</h1>')
      expect(response.body).to include ('<form method="POST" action="/">')
      expect(response.body).to include ('<label>Email Address:</label>')
      expect(response.body).to include ('<input type="text" name="email" autocomplete="off"/>')
      expect(response.body).to include ('<label>Password:</label>')
      expect(response.body).to include ('<input type="password" name="password"/>')
      expect(response.body).to include ('<input type="submit"/>')
      expect(response.body).to include ('<img src="/Acmo.jpg"></img>')
    end

    it 'Should not allow a user to log in if their password is incorrect' do
      response = post('/', email: 'user1@email.com', password: 'WrongPassword')
      expect(response.status).to eq (400)
    end

    it 'Should allow a user to log in if their password is correct' do
      response = post('/', email: 'user1@email.com', password: 'password1')
      expect(response.status).to eq (302)
    end
  end

  context '/listings' do
    it "returns a series of listings, a log out button, a request button" do
      response = get("/listings")
      expect(response.status).to eq (200)
      expect(response.body).to include ('log out')
    end 
  end 

  context '/listing/:id' do
    it "returns an individual listing" do 
      response = get("/listing/2")
      expect(response.status).to eq (200)
      expect(response.body).to include ('date')
    end 
  end 

  context 'GET /new_listing' do
    it 'should return a create a new listing page' do
      response = get('/new_listing')
      expect(response.status).to eq(200)
      expect(response.body).to include ('<h1>Welcome to ACMO: create your new listing</h1>')
      expect(response.body).to include ('<form action="/new_listing" method="post">')
    end
  end  
  
  context 'POST /new_listing' do
    it 'creates a new listing and redirects to listing page' do
      params = {
        listing: {
          name: 'New Listing',
          descriptioin: 'This is a new listing.',
          price_per_night: 100,
          date_from: '2023-01-01',
          date_to: '2023-01-02'
        }
      }
      post '/new_listing', params
      expect(last_response.status).to eq 302
    end
 
    it 'does not allow creating a listing when not logged in' do
      get '/logout'
      post '/new_listing', { name: 'Test Listing', description: 'This is a test listing.', price_per_night: 100, date_from: '2023-01-01', date_to: '2023-01-02'}
  
      expect(last_response.status).to eq 302
      follow_redirect!
      expect(last_request.path).to include('/')
    end
  end
end

