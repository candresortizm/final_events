class LocationType < ApplicationRecord
  has_many :reservations
  belongs_to :sale_event
end
