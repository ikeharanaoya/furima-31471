class CreateUserAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :user_addresses do |t|
      # 郵便番号
      t.string      :postal_code,     null: false
      # 都道府県
      t.integer     :prefecture_id,   null: false
      # 市区町村
      t.string      :city,            null: false
      # 番地
      t.string      :addresses,       null: false
      # 建物名
      t.string      :building
      # 電話番号
      t.string     :phone_number,    null: false, limit: 11
      # users テーブル
      t.references  :user,           null: false, foreign_key: true

      t.timestamps
    end
  end
end
