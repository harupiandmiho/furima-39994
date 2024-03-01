class User < ApplicationRecord
  # Deviseのデフォルトのモジュール追加
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # READMEに基づいたバリデーションの設定
  validates :nickname, presence: true
  validates :family_name, presence: true
  validates :first_name, presence: true
  validates :family_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :birth_date, presence: true
end
