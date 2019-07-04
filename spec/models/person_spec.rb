require 'rails_helper'

RSpec.describe Person, type: :model do
  it "should have associations and validations" do
    should validate_presence_of :reference
    should have_many :person_historys
  end

  describe 'import_csv' do
    it 'should import a csv file and create 2 new people' do
      Person.import(File.open("tmp/people.csv","r"))
      expect(Person.find(1).firstname).to eq "Henri"
      expect(Person.count).to eq 2
      expect(Person.find(2).person_historys).to exist
    end

    it 'should not allow a change on certain attributes' do
      Person.import(File.open("tmp/people.csv","r"))
      test_person = Person.find(1)
      test_person.update({"address" => "1 rue de la Paix"})
      test_person.update({"home_phone_number" => "0102030405"})
      test_person.update({"mobile_phone_number" => "0602030405"})
      test_person.update({"email" => "bla@free.fr"})
      test_person.update({"firstname" => "Robert"})
      byebug

      Person.import(File.open("tmp/people.csv","r")) #On essaye de remettre Martin Faure via le meme csv
      byebug
      expect(Person.find(1).person_historys.first.address).to eq "10 Rue La bruyère" #L'historique est bien cree
      expect(Person.find(1).person_historys.count).to eq 7 #Il y a 7 entrees dans l'historique de cette personne
      expect(Person.find(1).address).to eq "1 rue de la Paix" #adresse inchangee par le csv
      expect(Person.find(1).home_phone_number).to eq "0102030405" #Numero inchange par le csv
      expect(Person.find(1).mobile_phone_number).to eq "0602030405" #Numero inchange par le csv
      expect(Person.find(1).email).to eq "bla@free.fr" #adresse inchangee par le csv
      expect(Person.find(1).firstname).to eq "Henri" #prenom change par le csv

    end

  end

end
