require 'test_helper'

class OfferedPagesControllerTest < ActionController::TestCase
  setup do
    @offered_page = offered_pages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:offered_pages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create offered_page" do
    assert_difference('OfferedPage.count') do
      post :create, offered_page: { page_commit_id: @offered_page.page_commit_id, seam_stitch_id: @offered_page.seam_stitch_id }
    end

    assert_redirected_to offered_page_path(assigns(:offered_page))
  end

  test "should show offered_page" do
    get :show, id: @offered_page
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @offered_page
    assert_response :success
  end

  test "should update offered_page" do
    patch :update, id: @offered_page, offered_page: { page_commit_id: @offered_page.page_commit_id, seam_stitch_id: @offered_page.seam_stitch_id }
    assert_redirected_to offered_page_path(assigns(:offered_page))
  end

  test "should destroy offered_page" do
    assert_difference('OfferedPage.count', -1) do
      delete :destroy, id: @offered_page
    end

    assert_redirected_to offered_pages_path
  end
end
