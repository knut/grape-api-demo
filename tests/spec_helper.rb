ENV['RACK_ENV'] ||= 'test'

require 'airborne'

Airborne.configure do |config|
  config.base_url = 'http://localhost:9393/api/v1'
end

#before :each do
#  @file = fixture_file_upload('files/blank.pdf')
#end

# require 'rspec'
# require 'rack/test'
# require './main'
# 
# Dir[('./spec/support/**/*.rb')].each { |f| require f }
# 
# RSpec.configure do |c|
#   c.mock_with :rspec
#   c.include Rack::Test::Methods
# end