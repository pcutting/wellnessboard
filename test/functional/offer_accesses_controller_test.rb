require 'test_helper'

class OfferAccessesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:offer_accesses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create offer_access" do
    assert_difference('OfferAccess.count') do
      post :create, :offer_access => { }
    end

    assert_redirected_to offer_access_path(assigns(:offer_access))
  end

  test "should show offer_access" do
    get :show, :id => offer_accesses(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => offer_accesses(:one).to_param
    assert_response :success
  end

  test "should update offer_access" do
    put :update, :id => offer_accesses(:one).to_param, :offer_access => { }
    assert_redirected_to offer_access_path(assigns(:offer_access))
  end

  test "should destroy offer_access" do
    assert_difference('OfferAccess.count', -1) do
      delete :destroy, :id => offer_accesses(:one).to_param
    end

    assert_redirected_to offer_accesses_path
  end
end
