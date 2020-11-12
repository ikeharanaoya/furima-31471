FactoryBot.define do
  # ユーザーに自動生成
  factory :user do
    # 日本語の設定
    Faker::Config.locale = :ja

    # メールアドレス
    email                 {Faker::Internet.free_email}
    # パスワード
    password              {"test123"}
    # パスワード（確認用）
    password_confirmation {password}
    # ニックネーム
    nickname              {Faker::Games::Pokemon.name }
    # 苗字
    last_name             {Faker::Name.last_name}
    # 名前
    first_name            {Faker::Name.first_name}
    # 苗字_カナ
    last_name_kana        {"タナカ"}
    # 名前_カナ
    first_name_kana       {"タロウ"}
    # 生年月日
    birth_date            {Faker::Date::birthday}
  end
end


