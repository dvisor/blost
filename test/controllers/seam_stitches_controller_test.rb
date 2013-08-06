require 'test_helper'

class SeamStitchesControllerTest < ActionController::TestCase
  setup do
    @seam_stitch = seam_stitches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:seam_stitches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create seam_stitch" do
    assert_difference('SeamStitch.count') do
      post :create, seam_stitch: { next_seam_stitch_id: @seam_stitch.next_seam_stitch_id, prev_seam_stitch_id: @seam_stitch.prev_seam_stitch_id, seam_id: @seam_stitch.seam_id, stitch_id: @seam_stitch.stitch_id }
    end

    assert_redirected_to seam_stitch_path(assigns(:seam_stitch))
  end

  test "should show seam_stitch" do
    get :show, id: @seam_stitch
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @seam_stitch
    assert_response :success
  end

  test "should update seam_stitch" do
    patch :update, id: @seam_stitch, seam_stitch: { next_seam_stitch_id: @seam_stitch.next_seam_stitch_id, prev_seam_stitch_id: @seam_stitch.prev_seam_stitch_id, seam_id: @seam_stitch.seam_id, stitch_id: @seam_stitch.stitch_id }
    assert_redirected_to seam_stitch_path(assigns(:seam_stitch))
  end

  test "should destroy seam_stitch" do
    assert_difference('SeamStitch.count', -1) do
      delete :destroy, id: @seam_stitch
    end

    assert_redirected_to seam_stitches_path
  end
end
