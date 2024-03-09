class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_charge
  belongs_to_active_hash :shipping_area
  belongs_to_active_hash :days_to_ship

  has_one_attached :image
# バリデーションの設定
validates :name, presence: true
validates :description, presence: true
validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }

# ActiveHash関連のバリデーション（ここでは '---' のidを1と仮定しています）
validates :category_id, :condition_id, :shipping_charge_id, :shipping_area_id, :days_to_ship_id,
          numericality: { other_than: 1, message: "must be other than '---'" }
end


