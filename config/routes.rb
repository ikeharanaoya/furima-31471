Rails.application.routes.draw do
  devise_for :users
  # ルートパスの設定
  root to: "items#index"
  # itemsのパス（index以外を設定）
  resources :items, except: [:index] do
    # ordersのパス
    resources :orders, only: [:index,:create] do
      collection do
        # 住所検索処理のパス
        get 'addresses_search'
      end
    end
    collection do
      # 検索処理のパス
      get 'search'
    end
  end
  # userのパス設定
  resources :users, only: [:edit, :update] do
    # ユーザー住所の編集画面のパス
    resources :addresses, only: [:edit], to: 'users#edit_address'
    # ユーザー住所の更新処理のパス
    resources :addresses, only: [:update], to: 'users#update_address'
  end
end
