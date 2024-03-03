class ItemsController < ApplicationController
  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :shipping_charge_id, :shipping_area_id, :days_to_ship_id, :price, :image)
  end
end
