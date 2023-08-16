require "listings_repository"
require "spec_helper"

RSpec.describe ListingsRepository do

    def reset_listing_table
      seed_sql = File.read('spec/seed_data.sql')
      connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
      connection.exec(seed_sql)
    end
      
    before(:each) do 
      reset_listing_table
    end

    it "returns a listing with the specified id" do
      repo = ListingsRepository.new

      listing = repo.find(1)

      expect(listing).to_not be_nil
      expect(listing.name).to eq("Lovely cottage")
      expect(listing.user_id).to eq(1)
    end

    it "returns nil if no listing is found with the specified id" do
      repo = ListingsRepository.new

      listing = repo.find(999)

      expect(listing).to be_nil
    end

    it "returns all listings" do
        repo = ListingsRepository.new

        listings = repo.all
        expect(listings.length).to eq(2)
        expect(listings.first.name).to eq("Lovely cottage")
        expect(listings.first.user_id).to eq(1)
    end

    it "creates a new listing" do
        repo = ListingsRepository.new

        new_listing = Listings.new
        new_listing.name = "Luxury Villa"
        new_listing.description = "A luxurious villa with a pool and a view"
        new_listing.price_per_night = 500.0
        new_listing.user_id = 2
        new_listing.date_from = "2023-06-01"
        new_listing.date_to = "2023-06-01"

        repo.create(new_listing)

        listings = repo.all

        expect(listings.length).to eq(3)
        expect(listings.last.name).to eq("Luxury Villa")
        expect(listings.last.user_id).to eq(2)
    end
end
