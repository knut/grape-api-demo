# API Documentation

Here's a short description of the API.

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

