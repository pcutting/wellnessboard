require 'test_helper'

class QuickFactsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quick_facts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create quick_fact" do
    assert_difference('QuickFact.count') do
      post :create, :quick_fact => { }
    end

    assert_redirected_to quick_fact_path(assigns(:quick_fact))
  end

  test "should show quick_fact" do
    get :show, :id => quick_facts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => quick_facts(:one).to_param
    assert_response :success
  end

  test "should update quick_fact" do
    put :update, :id => quick_facts(:one).to_param, :quick_fact => { }
    assert_redirected_to quick_fact_path(assigns(:quick_fact))
  end

  test "should destroy quick_fact" do
    assert_difference('QuickFact.count', -1) do
      delete :destroy, :id => quick_facts(:one).to_param
    end

    assert_redirected_to quick_facts_path
  end
end
