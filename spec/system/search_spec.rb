require 'rails_helper'

RSpec.describe "検索機能", type: :system do

  # Basic認証
  def basic_pass(path) 
    username = ENV["BASIC_AUTH_USER"]
    password = ENV["BASIC_AUTH_PASSWORD"]
    visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
  end

  before do
    # 商品を生成
    @item = FactoryBot.create(:item)
  end

  context '検索処理'do
    it '検索フォームで正しく、検索できる' do
      # トップページに遷移する
      basic_pass root_path
      # 検索フォームに検索情報を入力する
      fill_in 'q_name_cont', with: @item.name
      # 検索ボタンを押下する
      find('button[class="search-button"]').click
      # 検索結果に商品情報が存在することを確認する（商品名）
      expect(page).to have_content @item.name
    end
    it 'カテゴリーで正しく、検索できる' do
      # トップページに遷移する
      basic_pass root_path
      # カテゴリーの項目名を取得
      name = Category.find(@item.category_id).name
      # カテゴリーに検索情報を入力する
      select name , from: 'q[category_id_eq]'
      # 検索ボタンを押下する
      find('button[class="search-button"]').click
      # 検索結果に商品情報が存在することを確認する（商品名）
      expect(page).to have_content @item.name
    end
    it '商品の状態で正しく、検索できる' do
      # トップページに遷移する
      basic_pass root_path
      # 商品の状態の検索項目を表示する
      find('label[id="sales_status_la"]').click
      # 商品の状態の項目名を取得
      name = SalesStatus.find(@item.sales_status_id).name
      # 商品の状態に検索情報を入力する
      check name
      # 検索ボタンを押下する
      find('button[class="search-button"]').click
      # 検索結果に商品情報が存在することを確認する（商品名）
      expect(page).to have_content @item.name
    end
    it '価格で正しく、検索できる' do
      # トップページに遷移する
      basic_pass root_path
      # 価格の検索項目を表示する
      find('label[id="price_la"]').click
      # 価格の選択項目を取得
      price = select_price(@item.price)
      # 価格に検索情報を入力する
      choose price
      # 検索ボタンを押下する
      find('button[class="search-button"]').click
      # 検索結果に商品情報が存在することを確認する（商品名）
      expect(page).to have_content @item.name
    end
  end

  # 価格判定処理
  def select_price(price)
    # 判定結果_文字列
    select_radio = "指定なし"

    # 1000円以下の場合 
    if price <= 1000
      # １０００円以下を設定
      select_radio = "１０００円以下"
    elsif price <= 10000
      # １万円以下を設定
      select_radio = "１万円以下"
    elsif price <= 100000
      # １０万円以下を設定
      select_radio = "１０万円以下"
    end

    # 価格で選択する文字を連携
    return select_radio
  end
end
