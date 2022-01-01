class Place < ApplicationRecord
  belongs_to :place_category
  has_many :products, dependent: :destroy
  has_one_attached :image
  enum status: ["active", "inactive"]
  
  has_many :reviews, as: :entity

  def image_path
    return Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true) if image.attached?
  end

  def ratings
    reviews.average(:rating)
  end

  def review_count
    reviews.count
  end
end
