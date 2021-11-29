class Product < ApplicationRecord
  has_one_attached :image
  
  validates :image, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true

  def image_path
    return Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true) if image.attached?
  end
end
