require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @user = FactoryBot.create(:user) # Userインスタンスを作成
    @item = FactoryBot.build(:item, user: @user) # Itemインスタンスを作成し、Userインスタンスと関連付ける
  end

  describe '商品出品機能のバリデーション' do
    context '全ての値が正しく入力されている場合' do
      it '商品は保存されるべき' do
        @item.image.attach(io: File.open(Rails.root.join('spec/fixtures/sample.png')), filename: 'sample.png', content_type: 'image/png')
        expect(@item).to be_valid
      end
    end

    context '必須項目が欠けている場合' do
      it '商品名がないと保存できない' do
        @item.name = nil
        @item.valid?
        expect(@item.errors[:name]).to include("can't be blank")
      end

      it '商品の説明がないと保存できない' do
        @item.description = nil
        @item.valid?
        expect(@item.errors[:description]).to include("can't be blank")
      end

      it 'カテゴリーIDが1では保存できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors[:category_id]).to include("must be other than '---'")
      end

      it '商品の状態IDが1では保存できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors[:condition_id]).to include("must be other than '---'")
      end

      it '配送料の負担IDが1では保存できない' do
        @item.shipping_charge_id = 1
        @item.valid?
        expect(@item.errors[:shipping_charge_id]).to include("must be other than '---'")
      end

      it '発送元の地域IDが1では保存できない' do
        @item.shipping_area_id = 1
        @item.valid?
        expect(@item.errors[:shipping_area_id]).to include("must be other than '---'")
      end

      it '発送までの日数IDが1では保存できない' do
        @item.days_to_ship_id = 1
        @item.valid?
        expect(@item.errors[:days_to_ship_id]).to include("must be other than '---'")
      end

      it '価格が入力されていないと保存できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors[:price]).to include("can't be blank")
      end

      it '価格が300円未満では保存できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors[:price]).to include("must be greater than or equal to 300")
      end

      it '価格が9,999,999円を超えると保存できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors[:price]).to include("must be less than or equal to 9999999")
      end

      it '価格が整数でないと保存できない' do
        @item.price = 'abc'
        @item.valid?
        expect(@item.errors[:price]).to include("is not a number")
      end

      it '商品画像がないと保存できない' do
        @item.image.detach
        @item.valid?
        expect(@item.errors[:image]).to include("can't be blank")
      end
    end
  end
end