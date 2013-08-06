require 'test_helper'

class SeamStitchBranchesControllerTest < ActionController::TestCase
  setup do
    @seam_stitch_branch = seam_stitch_branches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:seam_stitch_branches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create seam_stitch_branch" do
    assert_difference('SeamStitchBranch.count') do
      post :create, seam_stitch_branch: { branch_seam_stitch_id: @seam_stitch_branch.branch_seam_stitch_id, seam_stitch_id: @seam_stitch_branch.seam_stitch_id }
    end

    assert_redirected_to seam_stitch_branch_path(assigns(:seam_stitch_branch))
  end

  test "should show seam_stitch_branch" do
    get :show, id: @seam_stitch_branch
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @seam_stitch_branch
    assert_response :success
  end

  test "should update seam_stitch_branch" do
    patch :update, id: @seam_stitch_branch, seam_stitch_branch: { branch_seam_stitch_id: @seam_stitch_branch.branch_seam_stitch_id, seam_stitch_id: @seam_stitch_branch.seam_stitch_id }
    assert_redirected_to seam_stitch_branch_path(assigns(:seam_stitch_branch))
  end

  test "should destroy seam_stitch_branch" do
    assert_difference('SeamStitchBranch.count', -1) do
      delete :destroy, id: @seam_stitch_branch
    end

    assert_redirected_to seam_stitch_branches_path
  end
end
