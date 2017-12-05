class CreatePeople < ActiveRecord::Migration[5.1]
  def change
    create_table :people do |t|
      t.string :lname
      t.string :fname
      t.string :gender
      t.string :color
      t.date :birthdate

      t.timestamps
    end
  end
end
