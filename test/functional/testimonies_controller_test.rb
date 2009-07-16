require 'test_helper'

class TestimoniesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:testimonies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create testimony" do
    assert_difference('Testimony.count') do
      post :create, :testimony => { }
    end

    assert_redirected_to testimony_path(assigns(:testimony))
  end

  test "should show testimony" do
    get :show, :id => testimonies(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => testimonies(:one).to_param
    assert_response :success
  end

  test "should update testimony" do
    put :update, :id => testimonies(:one).to_param, :testimony => { }
    assert_redirected_to testimony_path(assigns(:testimony))
  end

  test "should destroy testimony" do
    assert_difference('Testimony.count', -1) do
      delete :destroy, :id => testimonies(:one).to_param
    end

    assert_redirected_to testimonies_path
  end
end
