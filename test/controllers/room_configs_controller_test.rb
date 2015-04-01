require 'test_helper'

class RoomConfigsControllerTest < ActionController::TestCase
  setup do
    @room_config = room_configs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:room_configs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create room_config" do
    assert_difference('RoomConfig.count') do
      post :create, room_config: { divider: @room_config.divider, max_players: @room_config.max_players, min_players: @room_config.min_players, name: @room_config.name, num_bingo_factor: @room_config.num_bingo_factor, timeout: @room_config.timeout, type: @room_config.type }
    end

    assert_redirected_to room_config_path(assigns(:room_config))
  end

  test "should show room_config" do
    get :show, id: @room_config
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @room_config
    assert_response :success
  end

  test "should update room_config" do
    patch :update, id: @room_config, room_config: { divider: @room_config.divider, max_players: @room_config.max_players, min_players: @room_config.min_players, name: @room_config.name, num_bingo_factor: @room_config.num_bingo_factor, timeout: @room_config.timeout, type: @room_config.type }
    assert_redirected_to room_config_path(assigns(:room_config))
  end

  test "should destroy room_config" do
    assert_difference('RoomConfig.count', -1) do
      delete :destroy, id: @room_config
    end

    assert_redirected_to room_configs_path
  end
end
