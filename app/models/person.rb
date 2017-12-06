class Person < ApplicationRecord
    validates :lname,:fname,:gender,:color, presence: true
    validates :birthdate, birthdate: true
    
    def attributes_from_line(l)
        a = l.split(determine_field_delimiter(l))
        self.attributes = [:lname,:fname,:gender,:color,:birthdate].zip(a).to_h
        self
    end

private
    # A record line may be field delimited using a space, a comma or a pipe
    # The field schema guarantees that delimiters do *not* appear within field
    # values.  To determine the appropriate delimiter to use, we can check
    # the record for either a comma or pipe.  If one of these characters is
    # present, we can use a delimiter that checks for them.  If neither character
    # is present, we presume fields are space-delimited and use a split regexp
    # appropriate for that.
    def determine_field_delimiter(l)
        if l =~ /[\,\|]/ 
            /\s*[\,\|]\s*/
        else
            /\s/
        end
    end
end
