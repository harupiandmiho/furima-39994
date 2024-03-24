FactoryBot.define do
  factory :purchase_form do
    postal_code { '123-4567' }
    shipping_area_id { 2 } # 「1」以外であればよい
    city { '横浜市緑区' }
    address { '青山1-1-1' }
    phone_number { '09012345678' }
    token { 'tok_abcdefghijk00000000000000000' }
    # user_idとitem_idはテスト実行時に動的に割り当てる
  end
end
