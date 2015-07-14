require 'sidekiq/web'
Rails.application.routes.draw do

  resources :game_versions
  mount Sidekiq::Web => '/sidekiq'
  resources :client_bugs

  resources :dynamic_iaps do
    collection do 
      get :set_time
      put :special_deal_end_time
    end
  end

  resources :scratch_card_rewards

  resources :bingo_points

  resources :bot_bingo_numbers

  resources :room_configs

  resources :ais do
    member do
      get :bots_probabilities
      get :ticket_probabilities
      delete :bot_probabilities
    end
  end

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
      get :flush_data
    end
  end

  namespace :api do
    namespace :v1 do
      resources :room_configs do
        member do
          get :leader_board
          get :find_room_id
        end
      end

      resources :schedule_maintenances do 
        collection do
          post :sm
        end
      end
      
      resources :client_bugs
      resources :dynamic_iaps
      resources :friend_requests
      resources :gift_requests
      resources :table_configs
      resources :scratch_card_rewards
      resources :bingo_points
      resources :users
      resources :rooms
      resources :tournaments
      resources :sessions, only: [:create, :destroy]
      resources :table_config_users, only: [:create]
      get "fetch_country" => "users#fetch_country"
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
          get :get_online_players
          get :player_rank
          get :game_data
          get :my_rank_and_rewards
          get :tournament_fee_paid
          get :tournaments_remaining_time
        end
      end

      resources :rooms do
        member do
          get :get_bingo_factor
          get :leader_board
          get :find_ticket_probability
        end
      end
      get "room_configs/:room_type/rooms" => "room_configs#get_room_type"
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


