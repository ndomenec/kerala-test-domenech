class CreatePersonHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :person_histories do |t|
      t.integer :person_reference, :references => [:persons, :reference]
      t.string :email
      t.string :home_phone_number
      t.string :mobile_phone_number
      t.string :firstname
      t.string :lastname
      t.string :address

      t.timestamps
    end
  end
end
