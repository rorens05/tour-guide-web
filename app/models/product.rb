class Product < ApplicationRecord
  has_one_attached :image
  has_many :carts, dependent: :destroy
  has_many :order_items, dependent: :destroy
  belongs_to :place

  
  validates :image, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true

  enum category: ["Popular", "New Arrivals", "Best Sellers"]

  def image_path
    return Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true) if image.attached?
  end
end
