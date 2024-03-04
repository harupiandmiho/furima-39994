class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_charge
  belongs_to_active_hash :shipping_area
  belongs_to_active_hash :days_to_ship

  has_one_attached :image

  validates :name, presence: true
  validates :description, presence: true
  validates :category_id, presence: true, numericality: { other_than: 0 }
  validates :condition_id, presence: true, numericality: { other_than: 0 }
  validates :shipping_charge_id, presence: true, numericality: { other_than: 0 }
  validates :shipping_area_id, presence: true, numericality: { other_than: 0 }
  validates :days_to_ship_id, presence: true, numericality: { other_than: 0 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
end
