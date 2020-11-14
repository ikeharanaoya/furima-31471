class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      # 商品名
      t.string :name, null: false
      # 説明
      t.text :info, null: false
      # カテゴリー
      t.integer :category_id, null: false
      # 商品の状態
      t.integer :sales_status_id, null: false
      # 配送料の負担
      t.integer :shipping_fee_status_id, null: false
      # 発送元の地域
      t.integer :prefecture_id, null: false
      # 発送までの日数
      t.integer :scheduled_delivery_id, null: false
      # 価格
      t.integer :price, null: false
      # users テーブル
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
