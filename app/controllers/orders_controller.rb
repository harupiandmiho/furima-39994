class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]
  def index
    # Formオブジェクトのインスタンスを作成
    @purchase_form = PurchaseForm.new
    # その他必要なデータの取得（商品情報など）
  end

  def create
    @purchase_form = PurchaseForm.new(purchase_params)
    if @purchase_form.valid?
      @purchase_form.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_form).permit(:postal_code, :prefecture_id, :city, :address, :building_name, :phone_number, :token)
          .merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end