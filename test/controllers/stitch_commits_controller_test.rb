require 'test_helper'

class StitchCommitsControllerTest < ActionController::TestCase
  setup do
    @stitch_commit = stitch_commits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stitch_commits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stitch_commit" do
    assert_difference('StitchCommit.count') do
      post :create, stitch_commit: { git_object_id: @stitch_commit.git_object_id, stitch_id: @stitch_commit.stitch_id }
    end

    assert_redirected_to stitch_commit_path(assigns(:stitch_commit))
  end

  test "should show stitch_commit" do
    get :show, id: @stitch_commit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stitch_commit
    assert_response :success
  end

  test "should update stitch_commit" do
    patch :update, id: @stitch_commit, stitch_commit: { git_object_id: @stitch_commit.git_object_id, stitch_id: @stitch_commit.stitch_id }
    assert_redirected_to stitch_commit_path(assigns(:stitch_commit))
  end

  test "should destroy stitch_commit" do
    assert_difference('StitchCommit.count', -1) do
      delete :destroy, id: @stitch_commit
    end

    assert_redirected_to stitch_commits_path
  end
end
