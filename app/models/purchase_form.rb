class PurchaseForm
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :shipping_area_id, :city, :address, :building_name, :phone_number, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'Input correctly' }
    validates :shipping_area_id, numericality: { other_than: 1, message: 'Select' } # 「---」が選択されていた場合にエラーになるように設定
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid. Input only number' }
    validates :token
  end

  validate :prefecture_must_be_selected

  def save
    ActiveRecord::Base.transaction do
      order = Order.create(user_id:, item_id:)
      ShippingAddress.create(order_id: order.id, postal_code:, shipping_area_id:, city:,
                             address:, building_name:, phone_number:)
    end
  end

  private

  def prefecture_must_be_selected
    errors.add(:shipping_area_id, 'Select') if shipping_area_id == '---' # ここで '---' が選択されていた場合のカスタムバリデーションを行う
  end
end
