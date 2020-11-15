class ItemsController < ApplicationController
  # ログイン確認。トップ画面、詳細画面以外は、ログイン画面へ遷移する
  before_action :authenticate_user!, except: [:index, :show]

  # トップ画面
  def index
    # 商品情報が新規投稿順に並ぶように取得
    @items = Item.order('created_at DESC')
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
      # 異常の場合、商品出品画面を再表示
      render :new
    end
  end

  # 商品詳細画面
  def show
  end

  # ストロングパラメーター取得
  private def item_params
    params.require(:item).permit(:name, :info,
                                 :category_id, :sales_status_id, :shipping_fee_status_id,
                                 :prefecture_id, :scheduled_delivery_id, :price, :image).merge(user_id: current_user.id)
  end
end
