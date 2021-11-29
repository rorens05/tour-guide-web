class Api::V1::CartsController < Api::V1::ApiController
  require 'open-uri'
  include ImagesHelper

  before_action :require_user_login

  def index
    render json: @user.carts.as_json(include: [{product: {methods: :image_path}}])
  end

  def create 
    cart = Cart.all.find_or_create_by(product_id: cart_params[:product_id], user_id: @user.id)
    cart.save(validate: false)
    cart.quantity = cart_params[:quantity]
    if cart.save
      render json: @user.carts.as_json(include: [{product: {methods: :image_path}}])
    else
      render json: cart.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy 
    Cart.find(params[:id]).destroy
    render json: {message: "Cart destroyed successfully"}, status: :ok
  end

  private
  def cart_params
    params.require(:cart).permit(:product_id, :quantity)
  end
  
end
