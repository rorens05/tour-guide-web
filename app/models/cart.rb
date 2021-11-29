class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :quantity, presence: true
  validate :quantity_range

  def quantity_range
    return if quantity.positive?
    errors.add(:quantity, "must be greater than 0")
  end
end
