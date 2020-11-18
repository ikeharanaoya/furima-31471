class OrdersController < ApplicationController
  # 送信されたIDから、商品情報を設定する（商品購入画面、商品購入処理）
  before_action :set_item, only: [:index, :create]

  # 商品購入画面
  def index
    # ItemBuyモデルの新規オブジェクトを生成
    @item_buy = ItemBuy.new
  end

  # 商品購入処理
  def create
     # データ保存の準備
    @item_buy = ItemBuy.new(item_buy_params)
    # データ保存確認
    if @item_buy.valid?
      # データ保存
      @item_buy.save
      # 正常の場合、ルートパスに戻る
      redirect_to root_path
    else
      # 異常の場合、商品購入画面を再表示
      render :index
    end
  end

  # ストロングパラメーター取得
  private def item_buy_params
    params.require(:item_buy).permit(:postal_code, :prefecture_id, :city,
       :addresses, :building, :phone_number).merge(item_id: params[:item_id], user_id: current_user.id)
  end

  # 商品情報設定
  def set_item
    # 送信されたIDから、商品情報を設定する
    @item = Item.find(params[:item_id])
  end
end
