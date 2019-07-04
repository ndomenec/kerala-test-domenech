namespace :import do
  desc "TODO"
  task buildings: :environment do
    Building.import(File.open("tmp/buildings.csv","r"))
  end

  desc "TODO"
  task people: :environment do
    Person.import(File.open("tmp/people.csv","r"))
  end

end
