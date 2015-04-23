#require './app'
#run Sinatra::Application

require './main'

require 'rack/cors'

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: [:get, :post, :put, :delete]
  end
end

run Rack::Cascade.new [API, Main]
