class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  before_action :set_item, only: [:show, :destroy]
  before_action :move_to_index, only: [:destroy]

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to root_path # 保存に成功した場合はトップページへリダイレクト
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @items = Item.all.order('created_at DESC')
  end

  def show
    # set_itemメソッドで@itemを設定
  end

  def destroy
    @item.destroy if @item.user_id == current_user.id
    redirect_to root_path
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :shipping_charge_id, :shipping_area_id,
                                 :days_to_ship_id, :price, :image)
    # 上記のpermit内のシンボルは、フォームで扱う各入力項目のname属性に対応しています
  end
  
  def move_to_index
    redirect_to root_path unless current_user.id == @item.user_id
  end
end
