class Company
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, type: String
  field :address, type: String
  field :city, type: String
  field :country, type: String
  field :email, type: String
  field :phone, type: String
  
  embeds_many :persons, cascade_callbacks: true
  accepts_nested_attributes_for :persons
  
end
