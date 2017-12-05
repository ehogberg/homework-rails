require 'test_helper'

class PersonTest < ActiveSupport::TestCase

  test "can't create an empty person" do
    person = Person.new
    
    assert person.invalid?
    assert person.errors[:lname].any?
    assert person.errors[:fname].any?
    assert person.errors[:gender].any?
    assert person.errors[:color].any?
    assert person.errors[:birthdate].any?
  end
  
  test "space-delimited line should parse into a record" do
    person = Person.new
    person.attributes_from_line("hogberg eric male green 2007-01-01")
    
    assert person.valid?
    assert person.fname == "eric"
    assert person.lname == "hogberg"
    assert person.gender == "male"
    assert person.color == "green"
    assert person.birthdate == Date.parse("2007-01-01"), "Date didn't parse properly"
  end
  
  test "comma-delimited line should parse into a record" do
    person = Person.new
    person.attributes_from_line("hogberg , eric , male , green , 2007-01-01")
    
    assert person.valid?
    assert person.fname == "eric"
    assert person.lname == "hogberg"
    assert person.gender == "male"
    assert person.color == "green"
    assert person.birthdate == Date.parse("2007-01-01"), "Date didn't parse properly"
  end
  
  test "pipe-delimited line should parse into a record" do
    person = Person.new
    person.attributes_from_line("hogberg | eric | male | green | 2007-01-01")
    
    assert person.valid?
    assert person.fname == "eric"
    assert person.lname == "hogberg"
    assert person.gender == "male"
    assert person.color == "green"
    assert person.birthdate == Date.parse("2007-01-01"), "Date didn't parse properly"
  end
  
  test "incomplete line should fail validation" do
    person = Person.new
    person.attributes_from_line("hogberg , eric , male")
  
    assert person.valid? == false

    assert person.fname == "eric"
    assert person.lname == "hogberg"
    assert person.gender == "male"
    
    assert person.color == nil, "Missing color should fail validation"
    assert person.birthdate == nil, "Missing birthdate should fail validation"
  
  end
end
