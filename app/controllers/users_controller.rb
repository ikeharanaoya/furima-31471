class UsersController < ApplicationController
  # ログイン確認。ログアウトのユーザーは、ログイン画面へ遷移する
  before_action :authenticate_user!
  # 編集者の整合性チェック
  before_action ->{ user_check(:id) }, only: [:edit, :update]
  before_action ->{ user_check(:user_id) }, only: [:edit_address, :update_address]

  # ユーザ情報編集画面
  def edit
    # 送信されたIDから、ユーザー情報を設定する
    @user = User.find(params[:id])
  end

  # ユーザー情報更新処理
  def update
    # 送信されたIDから、ユーザー情報を設定する
    @user = User.find(params[:id])
    # ニックネームの情報を上書き
    @user[:nickname] = user_params[:nickname]
      # バリデーション確認
      unless @user.valid?
        # エラーの場合は、再表示を行い、処理を終了する
        render :edit and return
      end
    # セッションの中に、user情報を登録
    session["devise.regist_data"] = {user: @user.attributes}
    # 次の住所編集画面を読み込み
    redirect_to edit_user_address_path(@user.id)
  end

  # ユーザー住所情報編集画面
  def edit_address
    # 送信されたIDから、ユーザー情報を設定する
    @user = User.find(params[:user_id])
    # ユーザーに紐づく住所情報を生成
    @user_address = @user.build_user_address
  end

    # ユーザー住所情報更新処理
  def update_address
      # バリデーション確認
      unless @user_address.valid?
        # エラーの場合は、再表示を行い、処理を終了する
        render :edit and return
      end
  end
  
  private

  # ユーザー整合性確認
  def user_check(user_id)
    # ログインユーザーと違うかの確認
    unless current_user.id == params[user_id].to_i
    # トップページに遷移する
    redirect_to root_path
    end
  end

  # ストリングパラメータの設定
  def user_params
    params.require(:user).permit(:nickname)
  end

end
