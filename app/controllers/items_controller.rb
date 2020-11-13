class ItemsController < ApplicationController
  # ログイン確認。トップ画面、詳細画面以外は、ログイン画面へ遷移する
  before_action :authenticate_user!, except: [:index, :show]

  # トップ画面
  def index
  end
  
  # 商品出品画面
  def new
    #  Itemモデルの新規オブジェクトを生成
    @item = Item.new
  end

  # 商品出品処理
  def create
    # データ保存の準備
    @item = Item.new(item_params)
    # データ保存＆確認
    if @item.save
      # 正常の場合、ルートパスに戻る
      redirect_to root_path
    else
      # 異常の場合、投稿ページを再表示
      render :new
    end
  end

  # ストロングパラメーター取得
  private def item_params
    params.require(:item).permit(:name, :info,
      :category_id, :sales_status_id, :shipping_fee_status_id,
      :prefecture_id, :scheduled_delivery_id, :price, :image).merge(user_id: current_user.id)
  end
end
