Rails.application.routes.draw do
  devise_for :users
  # ルートパスの設定
  root to: "items#index"
  # itemsのパス（index以外を設定）
  resources :items, except: [:index] do
    # ordersのパス
    resources :orders, only: [:index,:create]
    collection do
      # 検索処理のパス
      get 'search'
    end
  end
end
