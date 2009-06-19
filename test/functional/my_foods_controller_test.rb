require 'test_helper'

class MyFoodsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:my_foods)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create my_food" do
    assert_difference('MyFood.count') do
      post :create, :my_food => { }
    end

    assert_redirected_to my_food_path(assigns(:my_food))
  end

  test "should show my_food" do
    get :show, :id => my_foods(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => my_foods(:one).to_param
    assert_response :success
  end

  test "should update my_food" do
    put :update, :id => my_foods(:one).to_param, :my_food => { }
    assert_redirected_to my_food_path(assigns(:my_food))
  end

  test "should destroy my_food" do
    assert_difference('MyFood.count', -1) do
      delete :destroy, :id => my_foods(:one).to_param
    end

    assert_redirected_to my_foods_path
  end
end
