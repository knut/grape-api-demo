# Grape API Demo

Here's a simple demo of building an API using [Grape](http://intridea.github.io/grape/) (an opinionated micro-framework for creating REST-like APIs in Ruby). This demo is also using [Mongoid](http://mongoid.org/), a Object-Document-Mapper (ODM) for [MongoDB](https://www.mongodb.org/) written in Ruby.

The demo includes simple frontend using [AngularJS](https://angularjs.org/) to easily interact with the API.

## Getting this Working on Your Computer

	$ git clone git@github.com:knut/grape-api-demo.git
	$ cd grape-api-demo
	$ gem install bundler
	$ bundle install --without production
	$ bundle exec rackup

If you want to change files without reloading the server, try [shotgun](https://github.com/rtomayko/shotgun):
	
	$ bundle exec shotgun config.ru

## Implementation

The main implementation is done in [app/api/api.rb](app/api/api.rb) including the Mongoid-models [Company](api/models/company.rb) and [Person](api/models/person.rb) in [app/api/models](app/api/models).

The AngularJS client is all inside [public](public/).

## Configuration

In order to make this demo work you need to install [MongoDB](https://www.mongodb.org/). When you've got MongoDB running, please check [config/mongoid.yml](config/mongoid.yml) and that it's pointing to the correct host/port. Default values should be fine for testing.

## Testing

I've added a few API tests using [Airborne](https://github.com/brooklynDev/airborne) (an RSpec driven API testing framework) in [tests/api_spec.rb](tests/api_spec.rb):
	
	$ rspec tests/api_spec.rb

# API Documentation

Here's a short description of the API in this demo. All references assume you are running the API on localhost:9393.

## Company

### Add a company

	$ curl -X POST 'http://localhost:9393/api/v1/companies' -H "Content-Type: application/json" -d '{
		"name": "Company Name",
		"address": "Company Address",
		"city": "City Name",
		"country": "Country Name",
		"email": "example@example.com",
		"phone": "12345678"
	}'
	
### Get a list of all companies

	$ curl -X GET 'http://localhost:9393/api/v1/companies'

### Get a company
	
	$ curl -X GET 'http://localhost:9393/api/v1/companies/:id'

### Update company details

	$ curl -X PUT 'http://localhost:9393/api/v1/companies/:id' -H "Content-Type: application/json" -d'{
		"name": "Company Name Inc",
		"address": "Some other address",
		"city": "City Name",
		"country": "Country Name",
		"email": "another@example.com",
		"phone": "87654321"	
	}'

### Delete a company

	$ curl -X DELETE 'http://localhost:9393/api/v1/companies/:id'

## Person

### Add Person

	$ curl -X POST 'http://localhost:9393/api/v1/companies/5537446d4b6e751366000000/persons' -H "Content-Type: application/json" -d'{
  		"name": "John Doe",
  		"role": "Dude"
	}'


### Attach a file to a person

	$ curl -X POST 'http://localhost:9393/api/v1/companies/55376c724b6e751602000000/persons' -F "name=John Doe" -F "role=Dude" -F "file=@tests/fixtures/files/blank.pdf"



