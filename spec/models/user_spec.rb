require 'rails_helper'

RSpec.describe User, type: :model do
  # ユーザーが有効であることを確認するテスト
  it 'is valid with valid attributes' do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  # ニックネームが必須であることを確認するテスト
  it 'is invalid without a nickname' do
    user = FactoryBot.build(:user, nickname: nil)
    user.valid?
    expect(user.errors[:nickname]).to include("can't be blank")
  end

  # メールアドレスが必須であることを確認するテスト
  it 'is invalid without an email' do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  # パスワードが6文字以上であることを確認するテスト
  it 'is invalid with a password less than 6 characters' do
    user = FactoryBot.build(:user, password: '12345', password_confirmation: '12345')
    user.valid?
    expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
  end

  # 姓（family_name）が必須であることを確認するテスト
  it 'is invalid without a family name' do
    user = FactoryBot.build(:user, family_name: nil)
    user.valid?
    expect(user.errors[:family_name]).to include("can't be blank")
  end

  # 名（first_name）が必須であることを確認するテスト
  it 'is invalid without a first name' do
    user = FactoryBot.build(:user, first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to include("can't be blank")
  end

  # 姓カナ（family_name_kana）が必須であることを確認するテスト
  it 'is invalid without a family name kana' do
    user = FactoryBot.build(:user, family_name_kana: nil)
    user.valid?
    expect(user.errors[:family_name_kana]).to include("can't be blank")
  end

  # 名カナ（first_name_kana）が必須であることを確認するテスト
  it 'is invalid without a first name kana' do
    user = FactoryBot.build(:user, first_name_kana: nil)
    user.valid?
    expect(user.errors[:first_name_kana]).to include("can't be blank")
  end

  # 生年月日（birth_date）が必須であることを確認するテスト
  it 'is invalid without a birth date' do
    user = FactoryBot.build(:user, birth_date: nil)
    user.valid?
    expect(user.errors[:birth_date]).to include("can't be blank")
  end
end