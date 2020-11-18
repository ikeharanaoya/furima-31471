class ShippingAddress < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  # order テーブル
  belongs_to :order
  # 都道府県の一覧
  belongs_to :prefecture
end
