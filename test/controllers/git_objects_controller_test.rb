require 'test_helper'

class GitObjectsControllerTest < ActionController::TestCase
  setup do
    @git_object = git_objects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:git_objects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create git_object" do
    assert_difference('GitObject.count') do
      post :create, git_object: { content: @git_object.content, sha1: @git_object.sha1 }
    end

    assert_redirected_to git_object_path(assigns(:git_object))
  end

  test "should show git_object" do
    get :show, id: @git_object
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @git_object
    assert_response :success
  end

  test "should update git_object" do
    patch :update, id: @git_object, git_object: { content: @git_object.content, sha1: @git_object.sha1 }
    assert_redirected_to git_object_path(assigns(:git_object))
  end

  test "should destroy git_object" do
    assert_difference('GitObject.count', -1) do
      delete :destroy, id: @git_object
    end

    assert_redirected_to git_objects_path
  end
end
