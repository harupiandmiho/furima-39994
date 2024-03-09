require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it 'requires a name' do
      item = Item.new(name: nil)
      item.valid?
      expect(item.errors[:name]).to include("can't be blank")
    end

    it 'requires a description' do
      item = Item.new(description: nil)
      item.valid?
      expect(item.errors[:description]).to include("can't be blank")
    end

    # 他のバリデーションに対するテストも同様に記述します
  end
end
