require 'test_helper'

class ScratchCardRewardsControllerTest < ActionController::TestCase
  setup do
    @scratch_card_reward = scratch_card_rewards(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:scratch_card_rewards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create scratch_card_reward" do
    assert_difference('ScratchCardReward.count') do
      post :create, scratch_card_reward: { chest: @scratch_card_reward.chest, coins: @scratch_card_reward.coins, key: @scratch_card_reward.key, powerups: @scratch_card_reward.powerups, tickets: @scratch_card_reward.tickets }
    end

    assert_redirected_to scratch_card_reward_path(assigns(:scratch_card_reward))
  end

  test "should show scratch_card_reward" do
    get :show, id: @scratch_card_reward
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @scratch_card_reward
    assert_response :success
  end

  test "should update scratch_card_reward" do
    patch :update, id: @scratch_card_reward, scratch_card_reward: { chest: @scratch_card_reward.chest, coins: @scratch_card_reward.coins, key: @scratch_card_reward.key, powerups: @scratch_card_reward.powerups, tickets: @scratch_card_reward.tickets }
    assert_redirected_to scratch_card_reward_path(assigns(:scratch_card_reward))
  end

  test "should destroy scratch_card_reward" do
    assert_difference('ScratchCardReward.count', -1) do
      delete :destroy, id: @scratch_card_reward
    end

    assert_redirected_to scratch_card_rewards_path
  end
end
