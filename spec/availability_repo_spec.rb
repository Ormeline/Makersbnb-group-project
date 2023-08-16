require 'availability_repo'

describe AvailabilityRepo do

  def reset_seed_table
    seed_sql = File.read('spec/seed_data.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do
    reset_seed_table
  end

  context 'Find dates method' do
    it 'Should return an array of all available dates which correspond with passed listing_id' do
      repo = AvailabilityRepo.new
      dates = repo.find_dates(2)
      expect(dates.length).to eq 4
    end
  end

  context 'Create method' do
    it 'Should add a new availability object to the database' do
      available = double :availability, listing_id: 2, date: '2023-07-07'
      repo = AvailabilityRepo.new
      repo.create(available)
      expect(repo.find_dates(2)[0].id).to eq 2
    end

    # The test below is effectively redundant as it mimics the behvaiour of the test above. We have included this test simply to view what is happening within our database. 

    it 'Should add an object to the database' do  
      available = Availability.new
      available.listing_id = 2
      available.date = '2023-09-09'
      repo = AvailabilityRepo.new
      repo.create(available)
      expect(repo.find_dates(2)[0].id).to eq 2
    end
  end

  context 'Unavailable method' do
    it 'Should change the available status of the selected date to false' do
      repo = AvailabilityRepo.new
      repo.unavailable(1)
      expect(repo.find_dates(1)[0].availability).to eq "false"
    end
  end
end