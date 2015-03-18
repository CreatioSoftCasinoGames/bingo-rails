Rails.application.routes.draw do

  get 'ticket_probabilities/index'

  resources :ais do
    member do
      get :bots_probabilities
      get :ticket_probabilities
    end
  end

  get 'bots_probabilities/index'

  resources :tournament_rewards

  resources :in_game_gifts

  resources :tournament_users

  resources :tournaments

  resources :rounds

  resources :tables

  resources :table_configs

  resources :rooms
  
  resources :bots_probabilities

  resources :ticket_probabilities

  devise_for :users
  get "utility/show_api_key", to: "utility#show_api_key", as: "show_api_key"
  post "utility/generate_api_key", to: "utility#generate_api_key", as: "generate_api_key"

  resources :utility do
    collection do
      get :sync_data
    end
  end

  namespace :api do
    namespace :v1 do
      resources :friend_requests
      resources :gift_requests
      resources :table_configs
      resources :users
      resources :rooms
      resources :tournaments
      resources :sessions, only: [:create, :destroy]
      resources :table_config_users, only: [:create]
      resources :users do
        member do
          get :friend_request_sent
          get :my_friend_requests
          get :my_friends
          get :sent_gift
          get :received_gift
          get :ask_for_gift_to
          get :ask_for_gift_by
          put :incr_daubs
          put :incr_ticket_bought
          put :incr_bonus
          put :incr_mystery_chests
          put :incr_daubs_collected
          put :incr_keys_collected
          put :incr_bingo_vertical
          put :incr_bingo_horizontal
          put :incr_bingo_diagonal
          put :incr_bingo_corner
          put :incr_coins_collected
          get :get_round_and_attempt
          get :my_rank
          get :in_game_inapp
        end
      end

      resources :rooms do
        member do
          get :get_bingo_factor
          get :leader_board
        end
      end
      resources :rewards do
        member do
          put :mark_as_collected
        end
      end
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
