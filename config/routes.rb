Rails.application.routes.draw do
  devise_for :users
  # ルートパスの設定
  root to: "items#index"
end
