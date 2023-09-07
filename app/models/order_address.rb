class OrderAddress

  include ActiveModel::Model

  attr_accessor :postcode, :prefecture_id, :city, :address, :building, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :postcode,       format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :city
    validates :address
    validates :phone_number,   format: {with: /\A[0-9]{10,11}+\z/i, message: 'is invalid'}
    validates :user_id
    validates :item_id
    validates :token
  end

  validates :prefecture_id, numericality: { other_than: 1 , message: "can't be blank"}


  def save
    order = Order.create(user_id: user_id, item_id: item_id)

    Address.create(
      postcode: postcode, prefecture_id: prefecture_id, city: city, address: address, building: building, phone_number: phone_number, order_id: order.id)
  end





end