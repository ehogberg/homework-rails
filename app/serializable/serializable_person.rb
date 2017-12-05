class SerializablePerson < JSONAPI::Serializable::Resource
  type 'person'
  attribute :lname
  attribute :fname
  attribute :gender
  attribute :color
  
  attribute :birthdate do
    @object.birthdate.strftime("%m/%d/%Y")
  end

end
