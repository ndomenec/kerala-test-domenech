class CreateBuildingHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :building_histories do |t|
      t.integer :building_reference, :references => [:buildings, :reference]
      t.string :address
      t.string :zip_code
      t.string :city
      t.string :country
      t.string :manager_name

      t.timestamps
    end
  end
end
