class Reservation < ApplicationRecord
  belongs_to :location_type
  belongs_to :client
end
