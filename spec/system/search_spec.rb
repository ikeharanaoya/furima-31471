require 'rails_helper'

RSpec.describe "検索機能", type: :system do
  before do
    # 商品を生成
    @item = FactoryBot.build(:item)
  end

  context '検索処理'do
    it '検索フォームで正しく、検索できる' do
      # トップページに遷移する
      # 検索フォームに検索情報を入力する
      # 検索ボタンを押下する
      # 検索結果に商品情報が存在することを確認する（商品名）
    end
    it 'カテゴリーで正しく、検索できる' do
      # トップページに遷移する
      # カテゴリーに検索情報を入力する
      # 検索ボタンを押下する
      # 検索結果に商品情報が存在することを確認する（商品名）
    end
    it '商品の状態で正しく、検索できる' do
      # トップページに遷移する
      # 商品の状態に検索情報を入力する
      # 検索ボタンを押下する
      # 検索結果に商品情報が存在することを確認する（商品名）
    end
    it '価格で正しく、検索できる' do
      # トップページに遷移する
      # 価格に検索情報を入力する
      # 検索ボタンを押下する
      # 検索結果に商品情報が存在することを確認する（商品名）
    end
  end
end
