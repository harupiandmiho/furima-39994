require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it '必要なデータが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'emailが一意性でないと登録できない' do
        duplicate_user = @user.dup
        @user.save
        duplicate_user.email = @user.email
        duplicate_user.valid?
        expect(duplicate_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailに@が含まれないと登録できない' do
        @user.email = 'testemail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'passwordが空では登録できない' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordが6文字未満では登録できない' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordが半角英数字混合でないと登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end

      it 'family_nameが空では登録できない' do
        @user.family_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end

      it 'first_nameが空では登録できない' do
        @user.first_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'family_name_kanaが空では登録できない' do
        @user.family_name_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be blank")
      end

      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it 'birth_dateが空では登録できない' do
        @user.birth_date = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end
