class ItemsController < ApplicationController
  # ログイン確認。トップ画面、詳細画面以外は、ログイン画面へ遷移する
  before_action :authenticate_user!, except: [:index, :show]
  # 送信されたIDから、商品情報を設定する（詳細画面、編集画面、更新処理、削除処理）
  before_action :set_item, only: [:show, :edit, :update, :destroy]

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
    # データ保存確認
    if @item.valid?
      # データ保存
      @item.save
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

  # 商品情報編集画面
  def edit
    # 商品出品者とログインしているユーザーが違う場合
    unless user_signed_in? && current_user.id == @item.user_id
      # トップページに遷移する
      redirect_to action: :index
    end
  end

  # 商品情報更新処理
  def update
    # データ更新
    @item.update(item_params)
    # データ更新確認
    if @item.valid?
      # 正常の場合、商品詳細画面に戻る
      redirect_to item_path(@item.id)
    else
      # 異常の場合、商品情報編集画面を再表示
      render :edit
    end
  end

  # 商品削除処理
  def destroy
    # データ削除
    @item.destroy
    # トップページに遷移する
    redirect_to root_path
  end

  # ストロングパラメーター取得
  private def item_params
    params.require(:item).permit(:name, :info,
                                 :category_id, :sales_status_id, :shipping_fee_status_id,
                                 :prefecture_id, :scheduled_delivery_id, :price, :image).merge(user_id: current_user.id)
  end

  # 商品情報設定
  def set_item
    # 送信されたIDから、商品情報を設定する
    @item = Item.find(params[:id])
  end
end
