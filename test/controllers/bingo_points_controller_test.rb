require 'test_helper'

class BingoPointsControllerTest < ActionController::TestCase
  setup do
    @bingo_point = bingo_points(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bingo_points)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bingo_point" do
    assert_difference('BingoPoint.count') do
      post :create, bingo_point: { cell_coin: @bingo_point.cell_coin, theme_level: @bingo_point.theme_level, ticket_cost: @bingo_point.ticket_cost, xp: @bingo_point.xp }
    end

    assert_redirected_to bingo_point_path(assigns(:bingo_point))
  end

  test "should show bingo_point" do
    get :show, id: @bingo_point
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bingo_point
    assert_response :success
  end

  test "should update bingo_point" do
    patch :update, id: @bingo_point, bingo_point: { cell_coin: @bingo_point.cell_coin, theme_level: @bingo_point.theme_level, ticket_cost: @bingo_point.ticket_cost, xp: @bingo_point.xp }
    assert_redirected_to bingo_point_path(assigns(:bingo_point))
  end

  test "should destroy bingo_point" do
    assert_difference('BingoPoint.count', -1) do
      delete :destroy, id: @bingo_point
    end

    assert_redirected_to bingo_points_path
  end
end
