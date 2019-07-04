class Person < ActiveRecord::Base
  has_many :person_historys, :foreign_key => 'person_reference', :primary_key => 'reference'
  validates_presence_of :reference
  after_save :create_person_history
  require 'csv'

  def self.import(file)
    quote_chars = %w(" | ~ ^ & *)
    CSV.foreach(file.path, headers: :first_row, quote_char: quote_chars.shift) do |row|
      csv_person=row.to_hash
      person=Person.find_by_reference(csv_person["reference"])
      if person.blank?
        Person.create(csv_person)
      else
        better_csv_person = person.update_hash(csv_person)
        person.update(better_csv_person)
      end
    end
  end

  def update_hash(csv_person)
    better_csv_person=csv_person
    collection=["email", "home_phone_number", "mobile_phone_number", "address"] #Liste des attributs pour lesquels appliquer la regle
    histories=self.person_historys
    histories.each do |historique|
      attribute_collection=collection.clone #Permet de ne pas reverifier un element deja trouve dans l'historique
      attribute_collection.each do |attribute_name|
        if historique[attribute_name]==csv_person[attribute_name]
          better_csv_person.delete(attribute_name)
          collection.delete(attribute_name)
        end
      end
    end
    return better_csv_person
  end

  def create_person_history
    hash=self.attributes
    hash["person_reference"]=hash.delete("reference")
    self.person_historys.create(hash)
  end

end
