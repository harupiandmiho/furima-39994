class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_item, only: [:show, :edit, :update]
  before_action :move_to_index, only: [:edit, :update] 

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

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
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
    # 売却済み商品の判断は商品購入機能実装後に追加すること
    # 自身が出品していない商品、または売却済みの商品の編集ページにアクセスしようとした場合、トップページにリダイレクト
    if current_user.id != @item.user_id # || 売却済み判断条件
      redirect_to root_path
    end
  end
end