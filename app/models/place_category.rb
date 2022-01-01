class PlaceCategory < ApplicationRecord
  enum status: [:active, :inactive]
  scope :active, -> { where(:status => "active")}
  has_many :places, dependent: :destroy
end
