class Api::V1::OrdersController < Api::V1::ApiController
  require 'open-uri'
  include ImagesHelper

  before_action :require_user_login

  def index
    render json: @user.orders.as_json(methods: [:reference_number])
  end

  def show 
    render json: Order.find(params[:id]).as_json(
        methods: [:reference_number], 
        include: [
          {
            order_items: {include: [{
                product: {methods: :image_path}
              }]
            }
          }
        ]
      )
  end

  def create 
    @order = Order.new(user_id: @user.id, status: :processing)
    @order.assign_attributes(order_params)
    if @order.save
      @user.carts.each do |cart|
        OrderItem.create(
          order_id: @order.id,
          product_id: cart.product_id,
          quantity: cart.quantity,
          price: cart.product.price,
        )
        cart.destroy
      end
      render json: {message: "Order was created successfully"}, status: :created
    else
      render json: @order.errors.full_messages, status: :unprocessable_entity
    end
  end


  private
  def order_params
    params.require(:order).permit(
      :delivery_address,
      :land_mark,
      :note,
      :contact_number,
      :payment_method
    )
  end
end
