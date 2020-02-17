class SaleEvent < ApplicationRecord
  belongs_to :admin
  has_many :location_types

  mount_uploader :image, ImageUploader
  accepts_nested_attributes_for :location_types, allow_destroy: true
end
