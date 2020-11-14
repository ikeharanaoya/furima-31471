FactoryBot.define do
  # 商品情報を自動生成
  factory :item do
    # 日本語の設定
    Faker::Config.locale = :ja

    # 商品名
    name                    { Faker::Games::Pokemon.name }
    # 説明
    info                    { Faker::Games::Pokemon.move }
    # カテゴリー
    category_id             { Faker::Number.between(from: 1, to: 10) }
    # 商品の状態
    sales_status_id         { Faker::Number.between(from: 1, to: 6) }
    # 配送料の負担
    shipping_fee_status_id  { Faker::Number.between(from: 1, to: 2) }
    # 発送元の地域
    prefecture_id           { Faker::Number.between(from: 1, to: 47) }
    # 発送までの日数
    scheduled_delivery_id   { Faker::Number.between(from: 1, to: 3) }
    # 価格
    price                   { Faker::Number.between(from: 300, to: 9999999) }

    # usersテーブル
    association :user

    after(:build) do |image|
      # 出品画像
      image.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
