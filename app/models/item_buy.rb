class ItemBuy
  include ActiveModel::Model
  # ゲッターとセッターを定義
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :token

  # 郵便番号フォーマット
  FORMAT_POSTAL_CODE = /\A[0-9]{3}-[0-9]{4}\z/.freeze

  # 必須項目の確認
  with_options presence: true do
    # 郵便番号
    validates :postal_code, format: {with: FORMAT_POSTAL_CODE, message: "Postal code Input correctly"}
    # 市区町村
    validates :city
    # 番地
    validates :addresses
    # 電話番号（半角数字確認）
    validates :phone_number, numericality: { only_integer: true, message: 'Input only number' }
    # トークン
    validates :token
  end

  # 電話番号（11桁以内）
  validates :phone_number, length: { maximum: 11 ,message: 'Too long'} 
  # 都道府県(プルダウン範囲確認)
  validates :prefecture_id, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 47, message: 'Select' }
  
  # 保存処理
  def save
    # 注文の情報を保存
    order = Order.create(user_id: user_id, item_id: item_id)
    # 配達先の情報を保存
    ShippingAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, addresses: addresses, building: building, phone_number: phone_number, order_id: order.id)
  end
end