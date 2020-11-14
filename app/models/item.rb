class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  # 必須項目の設定
  with_options presence: true do
    # 出品画像
    validates :image
    # 商品名
    validates :name
    # 説明
    validates :info
    # 価格（半角数字確認）
    validates :price,numericality: { only_integer: true , message: "Half-width number"}
  end

  # 価格（300〜9,999,999の範囲確認）
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "Out of setting range"}

  # カテゴリー(プルダウン範囲確認)
  validates :category_id, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 10, message: "Select"}
  # 商品の状態(プルダウン範囲確認)
  validates :sales_status_id, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 6, message: "Select"}
  # 配送料の負担(プルダウン範囲確認)
  validates :shipping_fee_status_id, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 2, message: "Select"}
  # 発送元の地域(プルダウン範囲確認)
  validates :prefecture_id, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 47, message: "Select"}
  # 発送までの日数(プルダウン範囲確認)
  validates :scheduled_delivery_id, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 3, message: "Select"}

  # user テーブル
  belongs_to :user
  # カテゴリーの一覧
  belongs_to :category
  # 商品の状態の一覧
  belongs_to :sales_status
  # 配送料の負担の一覧
  belongs_to :shipping_fee_status
  # 発送元の地域の一覧（都道府県）
  belongs_to :prefecture
  # 発送までの日数の一覧
  belongs_to :scheduled_delivery
  # 出品画像
  has_one_attached :image
end
