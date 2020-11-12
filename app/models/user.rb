class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 全角ひらがな、全角カタカナ、漢字
  FORMAT_ZENKAKU = /\A[ぁ-んァ-ン一-龥]/
  # 全角カタカナ
  FORMAT_KANA = /\A[ァ-ヶー－]+\z/
  # 英数字混合
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  
  # パスワード
  validates_format_of :password, with: PASSWORD_REGEX, message: 'Include both letters and numbers'
  # ニックネーム
  validates :nickname, presence: true
  # 苗字
  validates :last_name, presence: true,
    format: { with: FORMAT_ZENKAKU, message: "Full-width characters"}
  # 名前
  validates :first_name, presence: true,
    format: { with: FORMAT_ZENKAKU, message: "Full-width characters"}
  # 苗字_カナ
  validates :last_name_kana, presence: true,
    format: { with: FORMAT_KANA, message: "Full-width katakana characters"}
  # 名前_カナ
  validates :first_name_kana, presence: true,
    format: { with: FORMAT_KANA, message: "Full-width katakana characters"}
  # 生年月日
  validates :birth_date, presence: true
end