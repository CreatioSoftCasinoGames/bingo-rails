class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :total_daubs, :tokens, :coins,	:powerups_remaining, :keys, :bingo_win, :tickets_purchased, :current_level, :xp_earned, :achievements_won, :jigsaw_pieces_collected, :powerups_used, :bingo_played, :tournaments_participated, :tournaments_won, :best_tournament_position, 
			:best_bingo_position, :daily_free_tickets_available, :is_invited_facebook_friend, :is_gifted_to_friend, :is_bingo_on_all_card, :fastest_bingo, :ticket_bought, :bounus_coins_and_tickets, :mystery_chests_opened, :free_daubs_collected, :free_daubs_collected, :keys_collected_in_game, :bingo_by_vertical_pattern, :bingo_by_horizontal_pattern,
			:bingo_by_diagonal_pattern, :coins_collected_in_game, :player_since

			has_one :powerup
			has_one :in_app_purchase
end
