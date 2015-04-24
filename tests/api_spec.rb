ENV['RACK_ENV'] ||= 'test'

require 'airborne'

Airborne.configure do |config|
  config.base_url = 'http://localhost:9393/api/v1'
end

describe 'API' do

  describe "POST /api/v1/companies" do
    
    it "should create a new company without contact details" do
      company = {
        name: "Google",
        address: "1600 Amphitheatre Pkwy",
        city: "Mountain View, CA",
        country: "US"
      }
      post "/companies", company
      expect_status(201)
      expect_json({
        name: company[:name], 
        address: company[:address], 
        city: company[:city],
        country: company[:country]
      })
      expect_json_types({
        created_at: :date, 
        updated_at: :date
      })
    end
    
    it "should create a new company with contact details" do
      company = {
        name: "Google",
        address: "1600 Amphitheatre Pkwy",
        city: "Mountain View, CA",
        country: "US",
        email: "example@example.com",
        phone: "12345678",
      }
      post "/companies", company
      expect_status(201)
      expect_json({
        name: company[:name], 
        address: company[:address], 
        city: company[:city],
        country: company[:country],
        email: company[:email],
        phone: company[:phone]
      })
      expect_json_types({
        created_at: :date, 
        updated_at: :date
      })
    end
    
  end
  
  describe "PUT /api/v1/companies/:id" do
  
    it "should be able to update company" do
      get "/companies"
      id = json_body[0][:id]
      company = {
        name: "Company Name",
        address: "Company Address",
        city: "City Name",
        country: "Country Name",
        email: "example1@example.com",
        phone: "87654321",
      }
      put "/companies/#{id}", company
      expect_status(200)
      expect_json({
        name: company[:name], 
        address: company[:address], 
        city: company[:city],
        country: company[:country],
        email: company[:email],
        phone: company[:phone]
      })
      expect_json_types({
        created_at: :date, 
        updated_at: :date
      })
    end
  
  end
  
  describe "GET /api/v1/companies" do
  
    it "should get a list of all companies" do
      get "/companies"
      expect_status(200)
    end
  
  end
  
  describe "GET /api/v1/companies/:id" do
  
    it "should get details about a company" do
      get "/companies"
      id = json_body[0][:id]
      get "/companies/#{id}"
      expect_status(200)
    end
  
  end
  
  describe "POST /api/v1/companies/:id/persons" do
    
    it "should add a new person to a company" do
      
      get "/companies"
      id = json_body[0][:id]
      person = {
        name: "John Doe",
        role: "Dude"
      }
      post "/companies/#{id}/persons", person
      expect_status(201)
      
    end
    
    it "should be able to attach PDF-files to a person" do
      
      # get "/companies"
      #       id = json_body[0][:id]
      #       
      #       file = Rack::Test::UploadedFile.new('./spec/fixtures/files/blank.pdf', 'application/pdf')
      #       person = {
      #         name: "John Doe",
      #         role: "Dude",
      #         file: file
      #       }
      #       post "/companies/#{id}/persons", person
      #       expect_status(201)
      
    end

  end
    
end
