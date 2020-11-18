class OrdersController < ApplicationController

  # 商品購入画面
  def index
    # 送信されたIDから、商品情報を設定する
    @item = Item.find(params[:item_id])
    # ItemBuyモデルの新規オブジェクトを生成
    @item_buy = ItemBuy.new
  end

  # 商品購入処理
  def create
  end
end
