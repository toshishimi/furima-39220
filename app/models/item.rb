class Item < ApplicationRecord

  validates :item_name,             presence: true
  validates :item_info,             presence: true
  validates :category_id,           numericality: { other_than: 1 , message: "can't be blank"}
  validates :item_status_id,        numericality: { other_than: 1 , message: "can't be blank"}
  validates :shipping_status_id,    numericality: { other_than: 1 , message: "can't be blank"}
  validates :prefecture_id,         numericality: { other_than: 1 , message: "can't be blank"}
  validates :scheduled_delivery_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :price,                 presence: true



  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :item_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery
  belongs_to :shipping_status

end
