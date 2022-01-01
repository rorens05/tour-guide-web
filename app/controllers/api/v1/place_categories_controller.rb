class Api::V1::PlaceCategoriesController < Api::V1::ApiController
  require 'open-uri'
  include ImagesHelper

  before_action :require_user_login

  def index
    render json: PlaceCategory.active.as_json(include: [{places: {methods: :image_path}}])
  end

  def place
    render json: Place.find(params[:id]).as_json(
      methods: [:image_path, :ratings, :review_count], 
      include: [
        :place_category, {
          products: {
            methods: :image_path,
            
          }
        },
        reviews: {
          include: [
            {
              user: {
                methods: :image_path
              }
            }
          ]
        }
      ]
    )
  end
end
