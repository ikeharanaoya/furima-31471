FactoryBot.define do
  factory :item_buy do
    # 日本語の設定
    Faker::Config.locale = :ja

    # 郵便番号
    postal_code       { Faker::Address.postcode }
    # 都道府県
    prefecture_id     { Faker::Number.between(from: 1, to: 47) }
    # 市区町村
    city              { Faker::Address.city }
    # 番地
    addresses         { Faker::Address.street_address }
    # 建物名
    building          { Faker::Address.building_number }
    # 電話番号
    phone_number      { Faker::Number.between(from: 0, to: 99_999_999_999) }

    # トークン
    token             { 'tok_abcdefghijk00000000000000000' }
  end
end
