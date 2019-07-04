class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people, id: false do |t|
      t.primary_key :reference
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
