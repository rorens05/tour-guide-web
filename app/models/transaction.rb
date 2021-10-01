class Transaction < ApplicationRecord
  has_one_attached :image
  belongs_to :account
  belongs_to :category
  enum status: ["completed", "pending"]
  validates :status, presence: true
  validates :amount, presence: true
end
