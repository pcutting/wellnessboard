require 'test_helper'

class OfferRestrictionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:offer_restrictions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create offer_restriction" do
    assert_difference('OfferRestriction.count') do
      post :create, :offer_restriction => { }
    end

    assert_redirected_to offer_restriction_path(assigns(:offer_restriction))
  end

  test "should show offer_restriction" do
    get :show, :id => offer_restrictions(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => offer_restrictions(:one).to_param
    assert_response :success
  end

  test "should update offer_restriction" do
    put :update, :id => offer_restrictions(:one).to_param, :offer_restriction => { }
    assert_redirected_to offer_restriction_path(assigns(:offer_restriction))
  end

  test "should destroy offer_restriction" do
    assert_difference('OfferRestriction.count', -1) do
      delete :destroy, :id => offer_restrictions(:one).to_param
    end

    assert_redirected_to offer_restrictions_path
  end
end
