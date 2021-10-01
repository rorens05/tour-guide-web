class Category < ApplicationRecord
  has_one_attached :image
  enum transaction_type: ["income", "expense"]
  validates :name, presence: true
end
