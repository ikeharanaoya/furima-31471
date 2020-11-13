class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  # 半角数字
  FORMAT_NUMBER = /\A[0-9]+\z/.freeze

  # 必須項目の設定
  with_options presence: true do
    # 出品画像
    validates :image
    # 商品名
    validates :name
    # 説明
    validates :info
    # 価格（半角数字確認）
    validates :price, format: {with: FORMAT_NUMBER, message: "Half-width number"}
  end

  # 価格（300〜9,999,999の範囲確認）
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "Out of setting range"}

  # 必須項目の設定（プルダウン）
  with_options numericality: { other_than: 0 , message: "Select"} do
    # カテゴリー
    validates :category_id
    # 商品の状態
    validates :sales_status_id
    # 配送料の負担
    validates :shipping_fee_status_id
    # 発送元の地域
    validates :prefecture_id
    # 発送までの日数
    validates :scheduled_delivery_id
  end

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
end