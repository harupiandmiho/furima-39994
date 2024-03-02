FactoryBot.define do
  factory :user do
    nickname              { "TestUser" }
    email                 { Faker::Internet.email}
    password              { "password" }
    password_confirmation { password }
    family_name           { "山田" }
    first_name            { "太郎" }
    family_name_kana      { "ヤマダ" }
    first_name_kana       { "タロウ" }
    birth_date            { "1990-01-01" }
  end
end