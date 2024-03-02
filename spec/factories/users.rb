FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.name }
    email                 { Faker::Internet.email }
    password              { "password" }
    password_confirmation { password }
    family_name           { "山田" }
    first_name            { "太郎" }
    family_name_kana      { "ヤマダ" }
    first_name_kana       { "タロウ" }
    birth_date            { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end