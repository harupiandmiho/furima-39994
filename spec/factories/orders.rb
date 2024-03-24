FactoryBot.define do
  factory :order do
    token { 'tok_abcdefghijk00000000000000000' }
    # userとitemの関連付けが必要な場合、以下のようにassociationを追加します
    association :user
    association :item
  end
end
