class OrdersController < ApplicationController
 before_action :set_item, only: [:index, :create]
 before_action :redirect_if_seller_or_sold, only: [:index]

  def index
    # Formオブジェクトのインスタンスを作成
    @purchase_form = PurchaseForm.new
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    # その他必要なデータの取得（商品情報など）
  end

  def create
    @purchase_form = PurchaseForm.new(purchase_params)
    if @purchase_form.valid?
      pay_item
      @purchase_form.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private

  def purchase_params
    params.require(:purchase_form).permit(:postal_code, :shipping_area_id, :city, :address, :building_name, :phone_number)
          .merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
  Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # 自身のPAY.JPテスト秘密鍵を記述しましょう
  Payjp::Charge.create(
    amount: @item.price ,# 商品の値段
    card: purchase_params[:token],    # カードトークン
    currency: 'jpy'                 # 通貨の種類（日本円）
  )
  end

  def redirect_if_seller_or_sold
    # 商品が売却済み、または現在のユーザーが出品者の場合、トップページにリダイレクト
    redirect_to root_path, alert: "アクセスできません。" if @item.user_id == current_user.id || @item.order.present?
  end

end