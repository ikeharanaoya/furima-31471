class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 全角ひらがな、全角カタカナ、漢字
  FORMAT_ZENKAKU = /\A[ぁ-んァ-ン一-龥]/.freeze
  # 全角カタカナ
  FORMAT_KANA = /\A[ァ-ヶー－]+\z/.freeze
  # 英数字混合
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze

  # パスワード
  validates_format_of :password, with: PASSWORD_REGEX, message: 'は文字と数字の両方を含めてください', on: :create

  # 必須項目の設定
  with_options presence: true do
    # ニックネーム
    validates :nickname
    # 苗字
    validates :last_name, format: { with: FORMAT_ZENKAKU, message: 'は全角文字で入力してください' }
    # 名前
    validates :first_name, format: { with: FORMAT_ZENKAKU, message: 'は全角文字で入力してください' }
    # 苗字_カナ
    validates :last_name_kana, format: { with: FORMAT_KANA, message: 'は全角カタカナで入力してください' }
    # 名前_カナ
    validates :first_name_kana, format: { with: FORMAT_KANA, message: 'は全角カタカナで入力してください' }
    # 生年月日
    validates :birth_date
  end

  # items テーブル
  has_many :items, dependent: :destroy
  # orders テーブル
  has_many :orders, dependent: :destroy
  # user_address テーブル
  has_one :user_address, dependent: :destroy
end
