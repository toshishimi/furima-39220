class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :move_to_index, only: [:index, :create]

  def index
    if @item.order != nil
      redirect_to root_path
    else
      @order_address = OrderAddress.new
    end
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end
  

  private

  def order_params
    params.require(:order_address)
    .permit(:postcode, :prefecture_id, :city, :address, :building, :phone_number)
    .merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token], 
      currency: 'jpy'
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_index
    @user = @item.user
    if current_user == @user
      redirect_to root_path
    end
  end

end
