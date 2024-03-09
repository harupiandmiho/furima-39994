class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path # 保存に成功した場合はトップページへリダイレクト
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :shipping_charge_id, :shipping_area_id, :days_to_ship_id, :price, :image)
    # 上記のpermit内のシンボルは、フォームで扱う各入力項目のname属性に対応しています
  end
end
