class Order < ApplicationRecord
  # user テーブル
  belongs_to :user
  # item テーブル
  belongs_to :item
  # shipping_address テーブル
  has_one :shipping_address

  # 検索処理(商品IDで検索)
  def self.search(item_id)
    Order.where('item_id = ?', item_id)
  end
end
