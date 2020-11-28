class UserAddress < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  # 郵便番号フォーマット
  FORMAT_POSTAL_CODE = /\A[0-9]{3}-[0-9]{4}\z/.freeze

  # 必須項目の確認
  with_options presence: true do
    # 郵便番号
    validates :postal_code, format: { with: FORMAT_POSTAL_CODE }
    # 市区町村
    validates :city
    # 番地
    validates :addresses
    # 電話番号（半角数字確認）
    validates :phone_number, numericality: { only_integer: true }
    # トークン
    validates :token
  end

  # 電話番号（11桁以内）
  validates :phone_number, length: { maximum: 11 }
  # 都道府県(プルダウン範囲確認)
  validates :prefecture_id, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 47, message: 'を選択してください' }

  # user テーブル
  belongs_to :user, optional: true
  # 都道府県の一覧
  belongs_to :prefecture
end
