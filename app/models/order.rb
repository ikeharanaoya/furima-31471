class Order < ApplicationRecord
  # user テーブル
  belongs_to :user
  # item テーブル
  belongs_to :item
  # shipping_address テーブル
  has_one :shipping_address
end
