require 'test_helper'

class WatersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:waters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create water" do
    assert_difference('Water.count') do
      post :create, :water => { }
    end

    assert_redirected_to water_path(assigns(:water))
  end

  test "should show water" do
    get :show, :id => waters(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => waters(:one).to_param
    assert_response :success
  end

  test "should update water" do
    put :update, :id => waters(:one).to_param, :water => { }
    assert_redirected_to water_path(assigns(:water))
  end

  test "should destroy water" do
    assert_difference('Water.count', -1) do
      delete :destroy, :id => waters(:one).to_param
    end

    assert_redirected_to waters_path
  end
end
