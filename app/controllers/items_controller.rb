class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
  end
  
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  

  def item_params
    params.require(:item).permit(:item_name, :item_info, :category_id, :item_status_id, :shipping_status_id, :prefecture_id, :scheduled_delivery_id, :price, :image).merge(user_id: current_user.id)
  end

 

end
# def move_to_index
   # @prototype = Prototype.find(params[:id])
    #@user = @prototype.user
    #unless user_signed_in? && current_user == @user
     # redirect_to root_path
    #end
  #end