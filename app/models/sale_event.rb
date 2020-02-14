class SaleEvent < ApplicationRecord
  belongs_to :admin
  has_many :location_types
end
