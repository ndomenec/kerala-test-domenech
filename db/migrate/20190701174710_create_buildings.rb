class CreateBuildings < ActiveRecord::Migration[5.2]
  def change
    create_table :buildings, id:false do |t|
      t.primary_key :reference
      t.string :address
      t.string :zip_code
      t.string :city
      t.string :country
      t.string :manager_name

      t.timestamps
    end
  end
end
