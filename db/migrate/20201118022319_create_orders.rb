class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      # users テーブル
      t.references  :user, null: false, foreign_key: true
      # items テーブル
      t.references  :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
