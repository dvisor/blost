require 'test_helper'

class PageCommitsControllerTest < ActionController::TestCase
  setup do
    @page_commit = page_commits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:page_commits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create page_commit" do
    assert_difference('PageCommit.count') do
      post :create, page_commit: { git_object_id: @page_commit.git_object_id, page_id: @page_commit.page_id }
    end

    assert_redirected_to page_commit_path(assigns(:page_commit))
  end

  test "should show page_commit" do
    get :show, id: @page_commit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @page_commit
    assert_response :success
  end

  test "should update page_commit" do
    patch :update, id: @page_commit, page_commit: { git_object_id: @page_commit.git_object_id, page_id: @page_commit.page_id }
    assert_redirected_to page_commit_path(assigns(:page_commit))
  end

  test "should destroy page_commit" do
    assert_difference('PageCommit.count', -1) do
      delete :destroy, id: @page_commit
    end

    assert_redirected_to page_commits_path
  end
end
