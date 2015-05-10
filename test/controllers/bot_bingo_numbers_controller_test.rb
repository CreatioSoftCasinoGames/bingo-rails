require 'test_helper'

class BotBingoNumbersControllerTest < ActionController::TestCase
  setup do
    @bot_bingo_number = bot_bingo_numbers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bot_bingo_numbers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bot_bingo_number" do
    assert_difference('BotBingoNumber.count') do
      post :create, bot_bingo_number: { number_of_bots: @bot_bingo_number.number_of_bots, starting_number: @bot_bingo_number.starting_number }
    end

    assert_redirected_to bot_bingo_number_path(assigns(:bot_bingo_number))
  end

  test "should show bot_bingo_number" do
    get :show, id: @bot_bingo_number
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bot_bingo_number
    assert_response :success
  end

  test "should update bot_bingo_number" do
    patch :update, id: @bot_bingo_number, bot_bingo_number: { number_of_bots: @bot_bingo_number.number_of_bots, starting_number: @bot_bingo_number.starting_number }
    assert_redirected_to bot_bingo_number_path(assigns(:bot_bingo_number))
  end

  test "should destroy bot_bingo_number" do
    assert_difference('BotBingoNumber.count', -1) do
      delete :destroy, id: @bot_bingo_number
    end

    assert_redirected_to bot_bingo_numbers_path
  end
end
