class BirthdateValidator < ActiveModel::EachValidator
    def validate_each(record,attr,val)
        if val.nil?
            record.errors.add(attr,"must be a valid date")
        else
            record.errors.add(attr, "can't be in the future") if val > Date.today
        end
    end
end