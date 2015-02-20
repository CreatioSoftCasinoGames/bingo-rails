require 'test_helper'

class TournamentRewardsControllerTest < ActionController::TestCase
  setup do
    @tournament_reward = tournament_rewards(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tournament_rewards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tournament_reward" do
    assert_difference('TournamentReward.count') do
      post :create, tournament_reward: { reward_type: @tournament_reward.reward_type }
    end

    assert_redirected_to tournament_reward_path(assigns(:tournament_reward))
  end

  test "should show tournament_reward" do
    get :show, id: @tournament_reward
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tournament_reward
    assert_response :success
  end

  test "should update tournament_reward" do
    patch :update, id: @tournament_reward, tournament_reward: { reward_type: @tournament_reward.reward_type }
    assert_redirected_to tournament_reward_path(assigns(:tournament_reward))
  end

  test "should destroy tournament_reward" do
    assert_difference('TournamentReward.count', -1) do
      delete :destroy, id: @tournament_reward
    end

    assert_redirected_to tournament_rewards_path
  end
end
