class Building < ActiveRecord::Base
  has_many :building_historys, :foreign_key => 'building_reference', :primary_key => 'reference'
  validates_presence_of :reference
  after_save :create_building_history
  require 'csv'

  def self.import(file)
    quote_chars = %w(" | ~ ^ & *)
    CSV.foreach(file.path, headers: :first_row, quote_char: quote_chars.shift) do |row|
      csv_building=row.to_hash
      building=Building.find_by_reference(csv_building["reference"])
      if building.blank?
        Building.create(csv_building)
      else
        better_csv_building = building.update_hash(csv_building)
        building.update(better_csv_building)
      end
    end
  end

  def update_hash(csv_building)
    better_csv_building=csv_building
    collection=["manager_name"] #Liste des attributs pour lesquels appliquer la regle
    histories=self.building_historys
    histories.each do |historique|
      attribute_collection=collection.clone #Permet de ne pas reverifier un element deja trouve dans l'historique
      attribute_collection.each do |attribute_name|
        if historique[attribute_name]==csv_building[attribute_name]
          better_csv_building.delete(attribute_name)
          collection.delete(attribute_name)
        end
      end
    end
    return better_csv_building
  end

  def create_building_history
    hash=self.attributes
    hash["building_reference"]=hash.delete("reference")
    self.building_historys.create(hash)
  end
end
