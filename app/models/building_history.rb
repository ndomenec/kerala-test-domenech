class BuildingHistory < ApplicationRecord
  belongs_to :building, :foreign_key => 'building_reference'
end
