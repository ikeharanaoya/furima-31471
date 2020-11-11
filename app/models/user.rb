class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 全角ひらがな、全角カタカナ、漢字
  FORMAT_ZENKAKU = /\A[ぁ-んァ-ン一-龥]/
  # 全角カタカナ
  FORMAT_KANA = /\A[ァ-ヶー－]+\z/
  
  # ニックネーム
  validates :nickname, presence: true
  # 苗字
  validates :last_name, presence: true,
    format: { with: FORMAT_ZENKAKU, message: "全角のみで入力して下さい"}
  # 名前
  validates :first_name, presence: true,
    format: { with: FORMAT_ZENKAKU, message: "全角のみで入力して下さい"}
  # 苗字_カナ
  validates :last_name_kana, presence: true,
    format: { with: FORMAT_KANA, message: "全角カタカナのみで入力して下さい"}
  # 名前_カナ
  validates :first_name_kana, presence: true,
    format: { with: FORMAT_KANA, message: "全角カタカナのみで入力して下さい"}
  # 生年月日
  validates :birth_date, presence: true, date: true
end
