# spec/factories/items.rb
FactoryBot.define do
  factory :item do
    association :user
    name { 'Test Item' }
    description { 'This is a test item.' }
    category_id { 2 } # '---'以外の適切な値に変更
    condition_id { 2 } # '---'以外の適切な値に変更
    shipping_charge_id { 2 } # '---'以外の適切な値に変更
    shipping_area_id { 2 } # '---'以外の適切な値に変更
    days_to_ship_id { 2 } # '---'以外の適切な値に変更
    price { 500 } # 300円以上の適切な値に変更

    after(:build) do |item|
      item.image.attach(io: File.open(Rails.root.join('spec/fixtures/sample.png')), filename: 'sample.png',
                        content_type: 'image/png')
    end
  end
end
