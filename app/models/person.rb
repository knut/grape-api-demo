class Person
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :role, type: String
  field :file, type: String
  
  embedded_in :company
  
  # def as_json(options={})
  #     {
  #       :id => id,
  #       :name => name,
  #       :role => role,
  #       :created_at => created_at,
  #       :updated_at => updated_at
  #     }
  #   end
  
end
