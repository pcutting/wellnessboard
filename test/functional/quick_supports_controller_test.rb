require 'test_helper'

class QuickSupportsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quick_supports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create quick_support" do
    assert_difference('QuickSupport.count') do
      post :create, :quick_support => { }
    end

    assert_redirected_to quick_support_path(assigns(:quick_support))
  end

  test "should show quick_support" do
    get :show, :id => quick_supports(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => quick_supports(:one).to_param
    assert_response :success
  end

  test "should update quick_support" do
    put :update, :id => quick_supports(:one).to_param, :quick_support => { }
    assert_redirected_to quick_support_path(assigns(:quick_support))
  end

  test "should destroy quick_support" do
    assert_difference('QuickSupport.count', -1) do
      delete :destroy, :id => quick_supports(:one).to_param
    end

    assert_redirected_to quick_supports_path
  end
end
