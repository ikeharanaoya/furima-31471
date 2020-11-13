class ShippingFeeStatus < ActiveHash::Base
  include ActiveHash::Associations
  # 配送料の負担の一覧
  self.data = [
    {id: 0, name: '---'},
    {id: 1, name: '着払い(購入者負担)'},
    {id: 2, name: '送料込み(出品者負担)'}
  ]
  # items テーブル
  has_many :items
end
