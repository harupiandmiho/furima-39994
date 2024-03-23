require 'rails_helper'

RSpec.describe PurchaseForm, type: :model do
  before do
    # テスト用のユーザーと商品を作成
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @purchase_form = PurchaseForm.new(
      user_id: user.id,
      item_id: item.id,
      postal_code: '123-4567',
      prefecture_id: 2, # ここでは、適切な値（1以外）を設定してください
      city: '横浜市緑区',
      address: '青山1-1-1',
      phone_number: '09012345678',
      token: 'tok_abcdefghijk00000000000000000'
    )
  end

  describe '購入情報の保存' do
    context '内容に問題がない場合' do
      it '全ての値が正しく入力されていれば保存できること' do
        expect(@purchase_form).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postal_codeが空では保存できない' do
        @purchase_form.postal_code = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeがハイフン無しでは保存できない' do
        @purchase_form.postal_code = '1234567'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Postal code Input correctly")
      end

      it 'prefecture_idが1では保存できない' do
        @purchase_form.prefecture_id = 1
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Prefecture Select")
      end

      it 'cityが空では保存できない' do
        @purchase_form.city = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("City can't be blank")
      end

      it 'addressが空では保存できない' do
        @purchase_form.address = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Address can't be blank")
      end

      it 'phone_numberが空では保存できない' do
        @purchase_form.phone_number = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberが10桁未満では保存できない' do
        @purchase_form.phone_number = '123456789'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Phone number is invalid. Input only number")
      end

      it 'phone_numberが12桁以上では保存できない' do
        @purchase_form.phone_number = '090123456789'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Phone number is invalid. Input only number")
      end

      it 'tokenが空では保存できない' do
        @purchase_form.token = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
