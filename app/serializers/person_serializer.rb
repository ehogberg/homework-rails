class PersonSerializer < ActiveModel::Serializer
  attributes :lname,:fname,:gender,:color,:birthdate
  
  def birthdate
      object.birthdate.strftime("%m/%d/%Y")
  end
end
