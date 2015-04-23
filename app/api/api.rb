
module Mongoid
  module Document
    def as_json(*args)
      attrs = super
      # change attribute name from _id to id and convert BSON::ObjectId to string
      attrs["id"] = attrs.delete("_id").to_s
      attrs
    end
  end
end

  
class API < Grape::API
  prefix 'api'
  version 'v1'
  format :json
  
  helpers do
    def logger
      API.logger
    end
  end
  
  
  desc "Add a new company"
  params do
    requires :name, type: String
    requires :address, type: String
    requires :city, type: String
    requires :country, type: String
    optional :email, type: String
    optional :phone, type: String
  end
  post '/companies' do
    company = Company.new
    company.name = params[:name]
    company.address = params[:address]
    company.city = params[:city]
    company.country = params[:country]
    company.email = params[:email] unless params[:email].nil?
    company.phone = params[:phone] unless params[:phone].nil?
    company.save!
    present company
  end
  
  
  desc "Get a list of all companies"
  get '/companies' do
    companies = Company.all
    present companies
  end
  
  
  desc "Get details about a company"
  params do
    requires :id, type: String
  end
  get '/companies/:id' do
    begin
      company = Company.find(params[:id])
    rescue Mongoid::Errors::DocumentNotFound => e
      error! "Company #{params[:id]} does not exist"
    end
    present company
  end


  desc "Update a company"
  params do
    requires :id, type: String
    requires :name, type: String
    requires :address, type: String
    requires :city, type: String
    requires :country, type: String
    optional :email, type: String
    optional :phone, type: String
  end
  put '/companies/:id' do
    begin
      company = Company.find(params[:id])
    rescue Mongoid::Errors::DocumentNotFound => e
      error! "Company #{params[:id]} does not exist"
    end    
    attrs = {}
    attrs[:name] = params[:name] unless params[:name].nil?
    attrs[:address] = params[:address] unless params[:address].nil?
    attrs[:city] = params[:city] unless params[:city].nil?
    attrs[:country] = params[:country] unless params[:country].nil?
    attrs[:email] = params[:email] unless params[:email].nil?
    attrs[:phone] = params[:phone] unless params[:phone].nil?
    company.update_attributes(attrs)
    present company
  end


  desc "Delete a company"
  params do
    requires :id, type: String
  end
  delete '/companies/:id' do
    begin
      company = Company.find(params[:id])
    rescue Mongoid::Errors::DocumentNotFound => e
      error! "Company #{params[:id]} does not exist"
    end
    company.destroy
  end
  
  
  desc "Add a person to a company"
  params do
    requires :id
    requires :name
    optional :role
    optional :file
  end
  post '/companies/:id/persons' do
    begin
      company = Company.find(params[:id])
    rescue Mongoid::Errors::DocumentNotFound => e
      error! "Company #{params[:id]} does not exist"
    end
    
    logger.info params
    
    # save person info
    person = Person.new
    person.name = params[:name]
    person.role = params[:role] unless params[:role].nil?

    company.persons << person
    company.save

    unless params[:file].nil?
      
      # save file to disk using the person id as it's name to make it unique
      filename = "#{person.id}.pdf"
      target = "./data/#{filename}"
      tempfile = params[:file][:tempfile]
      File.open(target, 'wb') do |f|
        f.write(tempfile.read)
      end
      logger.info "File saved in #{target}"
      
      # save the reference to the file on disk
      person.file = target
      
      company.save # another save to store the filename
    end
    
    present company
  end
  
  
  desc "Get a file"
  params do
    requires :id, type: String
  end
  get '/get_file/:id' do
    
    company = Company.where('persons._id' => BSON::ObjectId.from_string(params[:id])).first
    #logger.info company
    person = company.persons.find(params[:id])
    #logger.info person
    
    source = "./data/#{params[:id]}.pdf"    
    if File.readable?(source)
      
      # make a nice human readable filename
      target = "#{company.name}-#{person.name}"
        .downcase
        .gsub(/\s+/, '-')
        .gsub(/[^a-z0-9_-]/, '')
        .squeeze('-') + ".pdf"
      
      # content_type 'application/pdf'
      content_type "application/octet-stream"
      header['Content-Disposition'] = "attachment; filename=#{target}"
      env['api.format'] = :binary
      File.open(source).read
    else
      error! "File not found"
    end
        
  end
  
  add_swagger_documentation api_version: 'v1'
end

