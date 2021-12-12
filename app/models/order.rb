class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  enum status: [:processing, :verified, :shipping, :delivered, :cancelled, :failed]
  enum payment_method: [:cash_on_delivery]

  validates :status, presence: true
  validates :payment_method, presence: true
  validates :land_mark, presence: true
  validates :delivery_address, presence: true
  validates :contact_number, presence: true

  def reference_number
    id.to_s.rjust(7, '0')
  end
end
