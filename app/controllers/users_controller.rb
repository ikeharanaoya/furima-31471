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
