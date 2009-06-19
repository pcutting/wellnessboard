require 'test_helper'

class OfferSkusControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:offer_skus)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create offer_sku" do
    assert_difference('OfferSku.count') do
      post :create, :offer_sku => { }
    end

    assert_redirected_to offer_sku_path(assigns(:offer_sku))
  end

  test "should show offer_sku" do
    get :show, :id => offer_skus(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => offer_skus(:one).to_param
    assert_response :success
  end

  test "should update offer_sku" do
    put :update, :id => offer_skus(:one).to_param, :offer_sku => { }
    assert_redirected_to offer_sku_path(assigns(:offer_sku))
  end

  test "should destroy offer_sku" do
    assert_difference('OfferSku.count', -1) do
      delete :destroy, :id => offer_skus(:one).to_param
    end

    assert_redirected_to offer_skus_path
  end
end
