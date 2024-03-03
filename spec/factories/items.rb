FactoryBot.define do
  factory :item do
    name { "MyString" }
    description { "MyText" }
    category_id { 1 }
    condition_id { 1 }
    shipping_charge_id { 1 }
    shipping_area_id { 1 }
    days_to_ship_id { 1 }
    price { 1 }
  end
end
