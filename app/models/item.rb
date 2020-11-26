class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  # 必須項目の確認
  with_options presence: true do
    # 出品画像
    validates :image
    # 商品名
    validates :name
    # 説明
    validates :info
    # 価格（半角数字確認、300〜9,999,999の範囲確認）
    validates :price, numericality: { only_integer: true ,greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999}
  end
  
  # 必須項目の確認
  with_options numericality: { greater_than_or_equal_to: 1, message: 'を選択してください' } do
    # カテゴリー(プルダウン範囲確認)
    validates :category_id, numericality: { less_than_or_equal_to: 10, message: 'を選択してください' }
    # 商品の状態(プルダウン範囲確認)
    validates :sales_status_id, numericality: { less_than_or_equal_to: 6, message: 'を選択してください' }
    # 配送料の負担(プルダウン範囲確認)
    validates :shipping_fee_status_id, numericality: { less_than_or_equal_to: 2, message: 'を選択してください' }
    # 発送元の地域(プルダウン範囲確認)
    validates :prefecture_id, numericality: { less_than_or_equal_to: 47, message: 'を選択してください' }
    # 発送までの日数(プルダウン範囲確認)
    validates :scheduled_delivery_id, numericality: { less_than_or_equal_to: 3, message: 'を選択してください' }
  end

  # user テーブル
  belongs_to :user
  # order テーブル
  has_one :order
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
