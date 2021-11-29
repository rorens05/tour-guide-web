class Api::V1::ProductsController < Api::V1::ApiController
  require 'open-uri'
  include ImagesHelper

  before_action :require_user_login

  def index
    render json: Product.all.as_json(methods: :image_path)
  end

  def show
    render json: Product.find(params[:id]).as_json(methods: :image_path)
  end

  private

  
end
