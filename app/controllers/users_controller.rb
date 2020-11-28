class UsersController < ApplicationController
  # ログイン確認。ログアウトのユーザーは、ログイン画面へ遷移する
  before_action :authenticate_user!
  before_action :user_check

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
    render :edit_address
  end

  private

  # ユーザー整合性確認
  def user_check
    # ログインユーザーと違うかの確認
    unless current_user.id == params[:id].to_i
    # トップページに遷移する
    redirect_to root_path
    end
  end

  # ストリングパラメータの設定
  def user_params
    params.require(:user).permit(:nickname)
  end

end
