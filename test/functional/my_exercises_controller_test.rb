require 'test_helper'

class MyExercisesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:my_exercises)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create my_exercise" do
    assert_difference('MyExercise.count') do
      post :create, :my_exercise => { }
    end

    assert_redirected_to my_exercise_path(assigns(:my_exercise))
  end

  test "should show my_exercise" do
    get :show, :id => my_exercises(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => my_exercises(:one).to_param
    assert_response :success
  end

  test "should update my_exercise" do
    put :update, :id => my_exercises(:one).to_param, :my_exercise => { }
    assert_redirected_to my_exercise_path(assigns(:my_exercise))
  end

  test "should destroy my_exercise" do
    assert_difference('MyExercise.count', -1) do
      delete :destroy, :id => my_exercises(:one).to_param
    end

    assert_redirected_to my_exercises_path
  end
end
