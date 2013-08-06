require 'test_helper'

class SeamsControllerTest < ActionController::TestCase
  setup do
    @seam = seams(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:seams)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create seam" do
    assert_difference('Seam.count') do
      post :create, seam: { author_id: @seam.author_id, end_seam_stitch_id: @seam.end_seam_stitch_id, start_seam_stitch_id: @seam.start_seam_stitch_id, title: @seam.title }
    end

    assert_redirected_to seam_path(assigns(:seam))
  end

  test "should show seam" do
    get :show, id: @seam
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @seam
    assert_response :success
  end

  test "should update seam" do
    patch :update, id: @seam, seam: { author_id: @seam.author_id, end_seam_stitch_id: @seam.end_seam_stitch_id, start_seam_stitch_id: @seam.start_seam_stitch_id, title: @seam.title }
    assert_redirected_to seam_path(assigns(:seam))
  end

  test "should destroy seam" do
    assert_difference('Seam.count', -1) do
      delete :destroy, id: @seam
    end

    assert_redirected_to seams_path
  end
end
