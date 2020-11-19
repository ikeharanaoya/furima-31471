FactoryBot.define do
  factory :order do
    # usersテーブル
    association :user
    # itemsテーブル
    association :item
  end
end
