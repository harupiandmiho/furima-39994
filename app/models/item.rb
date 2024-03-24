class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_charge
  belongs_to_active_hash :shipping_area
  belongs_to_active_hash :days_to_ship
  belongs_to :user
  has_one :order 

  has_one_attached :image
  # バリデーションの設定
  # 画像のバリデーションを追加
  validates :image, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg'], size: { less_than: 5.megabytes }
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }

  # ActiveHash関連のバリデーション（ここでは '---' のidを1と仮定しています）
  validates :category_id, :condition_id, :shipping_charge_id, :shipping_area_id, :days_to_ship_id,
            numericality: { other_than: 1, message: "must be other than '---'" }
end
