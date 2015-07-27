require 'test_helper'

class LevelProgrationsControllerTest < ActionController::TestCase
  setup do
    @level_progration = level_progrations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:level_progrations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create level_progration" do
    assert_difference('LevelProgration.count') do
      post :create, level_progration: { card_cost: @level_progration.card_cost, coins_per_bingo: @level_progration.coins_per_bingo, level: @level_progration.level, tickets_per_bingo: @level_progration.tickets_per_bingo, xp: @level_progration.xp, xp_difference: @level_progration.xp_difference, xp_per_daub: @level_progration.xp_per_daub }
    end

    assert_redirected_to level_progration_path(assigns(:level_progration))
  end

  test "should show level_progration" do
    get :show, id: @level_progration
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @level_progration
    assert_response :success
  end

  test "should update level_progration" do
    patch :update, id: @level_progration, level_progration: { card_cost: @level_progration.card_cost, coins_per_bingo: @level_progration.coins_per_bingo, level: @level_progration.level, tickets_per_bingo: @level_progration.tickets_per_bingo, xp: @level_progration.xp, xp_difference: @level_progration.xp_difference, xp_per_daub: @level_progration.xp_per_daub }
    assert_redirected_to level_progration_path(assigns(:level_progration))
  end

  test "should destroy level_progration" do
    assert_difference('LevelProgration.count', -1) do
      delete :destroy, id: @level_progration
    end

    assert_redirected_to level_progrations_path
  end
end
