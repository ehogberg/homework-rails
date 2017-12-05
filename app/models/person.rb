class Person < ApplicationRecord
    validates :lname,:fname,:gender,:color,:birthdate, presence: true
    
    def attributes_from_line(l)
        a = l.split(determine_field_delimiter(l))
        self.attributes = [:lname,:fname,:gender,:color,:birthdate].zip(a).to_h
    end
   
private
    def determine_field_delimiter(l)
        if l =~ /[\,\|]/ 
            /\s[\,\|]\s/
        else
            /\s/
        end
    end
end
