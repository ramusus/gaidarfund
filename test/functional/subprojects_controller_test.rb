require 'test_helper'

class SubprojectsControllerTest < ActionController::TestCase
  setup do
    @subproject = subprojects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subprojects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create subproject" do
    assert_difference('Subproject.count') do
      post :create, subproject: @subproject.attributes
    end

    assert_redirected_to subproject_path(assigns(:subproject))
  end

  test "should show subproject" do
    get :show, id: @subproject
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @subproject
    assert_response :success
  end

  test "should update subproject" do
    put :update, id: @subproject, subproject: @subproject.attributes
    assert_redirected_to subproject_path(assigns(:subproject))
  end

  test "should destroy subproject" do
    assert_difference('Subproject.count', -1) do
      delete :destroy, id: @subproject
    end

    assert_redirected_to subprojects_path
  end
end
