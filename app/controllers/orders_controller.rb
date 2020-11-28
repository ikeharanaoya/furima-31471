class OrdersController < ApplicationController
  # ログイン確認。ログアウトのユーザーは、ログイン画面へ遷移する
  before_action :authenticate_user!
  # 商品の購入済み確認
  before_action :get_oder
  # 送信されたIDから、商品情報を設定する（商品購入画面、商品購入処理）
  before_action :set_item, only: [:index, :create]

  # 商品購入画面
  def index
    # 商品出品者とログインしているユーザーが同一の場合
    if user_signed_in? && current_user.id == @item.user_id
      # トップページに遷移する
      redirect_to root_path
    end

    # ItemBuyモデルの新規オブジェクトを生成
    @item_buy = ItemBuy.new
  end

  # 商品購入処理
  def create
    # データ保存の準備
    item_oder = ItemBuy.new(item_buy_params)
    # データ保存確認
    if item_oder.valid?
      # クレジットカード決済処理
      pay_item
      # データ保存
      item_oder.save
      # 正常の場合、トップページに戻る
      redirect_to root_path
    else
      # ItemBuyモデルの新規オブジェクトを生成
      @item_buy = ItemBuy.new
      # エラーメッセージを上書き
      @item_buy.errors.merge!(item_oder.errors)
      # 異常の場合、商品購入画面を再表示
      render :index
    end
  end

  # ユーザーのアドレス情報取得
  def addresses_search
    # ユーザーのアドレス情報取得
    user_address = UserAddress.where(user_id: current_user.id)

    # 検索結果を返す
    render json: { post: user_address }
  end
  # ストロングパラメーター取得
  private def item_buy_params
    params.require(:item_buy).permit(:postal_code, :prefecture_id, :city,
                                     :addresses, :building, :phone_number).merge(item_id: params[:item_id], user_id: current_user.id,
                                                                                 token: params[:token])
  end

  # 商品情報設定
  def set_item
    # 送信されたIDから、商品情報を設定する
    @item = Item.find(params[:item_id])
  end

  # 購入済み確認
  def get_oder
    # 商品の購入履歴があるか検索
    order = Order.search(params[:item_id])
    # 履歴情報確認
    if order.any?
      # 購入済みの場合、トップページに戻る
      redirect_to root_path
    end
  end

  # クレジットカード決済処理
  def pay_item
    #  環境変数からキーを取得
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    # 決済処理実行
    Payjp::Charge.create(
      # 商品の値段
      amount: @item.price,
      # カードトークン
      card: item_buy_params[:token],
      # 通貨の種類（日本円）
      currency: 'jpy'
    )
  end
end
