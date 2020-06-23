require 'test_helper'

class ReviewCoursesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get review_courses_index_url
    assert_response :success
  end

  test "should get new" do
    get review_courses_new_url
    assert_response :success
  end

  test "should get create" do
    get review_courses_create_url
    assert_response :success
  end

  test "should get edit" do
    get review_courses_edit_url
    assert_response :success
  end

  test "should get update" do
    get review_courses_update_url
    assert_response :success
  end

  test "should get destroy" do
    get review_courses_destroy_url
    assert_response :success
  end
end
