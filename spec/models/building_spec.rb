require 'rails_helper'

RSpec.describe Building, type: :model do
  it "should have associations and validations" do
    should validate_presence_of :reference
    should have_many :building_historys
  end

  describe 'import_csv' do
    #let(:building) { create(:building)}
    it 'should import a csv file and create 2 new buildings' do
      Building.import(File.open("tmp/buildings.csv","r"))
      expect(Building.find(1).zip_code).to eq "75009"
      expect(Building.count).to eq 2
      expect(Building.find(2).building_historys).to exist
    end

    it 'should not allow a change on the manager name' do
      Building.import(File.open("tmp/buildings.csv","r"))
      test_building = Building.find(1)
      test_building.update({"address" => "1 rue de la Paix"})
      test_building.update({"manager_name" => "Nono"})
      Building.import(File.open("tmp/buildings.csv","r")) #On essaye de remettre Martin Faure via le meme csv

      expect(Building.find(1).building_historys.first.manager_name).to eq "Martin Faure" #L'historique est bien cree
      expect(Building.find(1).manager_name).to eq "Nono" #Le nom n'est pas change par le csv
      expect(Building.find(1).address).to eq "20 Rue La bruyère" #L'adresse est reinitialisee car pas dans la liste d'attributs
    end
  end

end
