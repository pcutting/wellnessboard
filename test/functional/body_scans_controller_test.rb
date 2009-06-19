require 'test_helper'

class BodyScansControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:body_scans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create body_scan" do
    assert_difference('BodyScan.count') do
      post :create, :body_scan => { }
    end

    assert_redirected_to body_scan_path(assigns(:body_scan))
  end

  test "should show body_scan" do
    get :show, :id => body_scans(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => body_scans(:one).to_param
    assert_response :success
  end

  test "should update body_scan" do
    put :update, :id => body_scans(:one).to_param, :body_scan => { }
    assert_redirected_to body_scan_path(assigns(:body_scan))
  end

  test "should destroy body_scan" do
    assert_difference('BodyScan.count', -1) do
      delete :destroy, :id => body_scans(:one).to_param
    end

    assert_redirected_to body_scans_path
  end
end
