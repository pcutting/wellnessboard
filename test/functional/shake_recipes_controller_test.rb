require 'test_helper'

class ShakeRecipesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shake_recipes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shake_recipe" do
    assert_difference('ShakeRecipe.count') do
      post :create, :shake_recipe => { }
    end

    assert_redirected_to shake_recipe_path(assigns(:shake_recipe))
  end

  test "should show shake_recipe" do
    get :show, :id => shake_recipes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => shake_recipes(:one).to_param
    assert_response :success
  end

  test "should update shake_recipe" do
    put :update, :id => shake_recipes(:one).to_param, :shake_recipe => { }
    assert_redirected_to shake_recipe_path(assigns(:shake_recipe))
  end

  test "should destroy shake_recipe" do
    assert_difference('ShakeRecipe.count', -1) do
      delete :destroy, :id => shake_recipes(:one).to_param
    end

    assert_redirected_to shake_recipes_path
  end
end
