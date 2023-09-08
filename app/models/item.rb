class Item < ApplicationRecord
  validates :image,                 presence: true
  validates :item_name,             presence: true
  validates :item_info,             presence: true
  validates :category_id,           numericality: { other_than: 1 , message: "can't be blank"}
  validates :item_status_id,        numericality: { other_than: 1 , message: "can't be blank"}
  validates :shipping_status_id,    numericality: { other_than: 1 , message: "can't be blank"}
  validates :prefecture_id,         numericality: { other_than: 1 , message: "can't be blank"}
  validates :scheduled_delivery_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :price,                 numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, only_integer: true }



  belongs_to :user
  has_one_attached :image
  has_one :order

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :item_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery
  belongs_to :shipping_status

end
