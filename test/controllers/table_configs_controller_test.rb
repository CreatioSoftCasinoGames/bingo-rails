require 'test_helper'

class TableConfigsControllerTest < ActionController::TestCase
  setup do
    @table_config = table_configs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:table_configs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create table_config" do
    assert_difference('TableConfig.count') do
      post :create, table_config: { big_blind: @table_config.big_blind, max_buy_in: @table_config.max_buy_in, max_player: @table_config.max_player, min_buy_in: @table_config.min_buy_in, min_player: @table_config.min_player, name: @table_config.name, small_blind: @table_config.small_blind }
    end

    assert_redirected_to table_config_path(assigns(:table_config))
  end

  test "should show table_config" do
    get :show, id: @table_config
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @table_config
    assert_response :success
  end

  test "should update table_config" do
    patch :update, id: @table_config, table_config: { big_blind: @table_config.big_blind, max_buy_in: @table_config.max_buy_in, max_player: @table_config.max_player, min_buy_in: @table_config.min_buy_in, min_player: @table_config.min_player, name: @table_config.name, small_blind: @table_config.small_blind }
    assert_redirected_to table_config_path(assigns(:table_config))
  end

  test "should destroy table_config" do
    assert_difference('TableConfig.count', -1) do
      delete :destroy, id: @table_config
    end

    assert_redirected_to table_configs_path
  end
end
