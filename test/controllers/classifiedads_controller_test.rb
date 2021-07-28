require "test_helper"

class ClassifiedadsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get classifiedads_index_url
    assert_response :success
  end

  test "should get show" do
    get classifiedads_show_url
    assert_response :success
  end

  test "should get update" do
    get classifiedads_update_url
    assert_response :success
  end

  test "should get destroy" do
    get classifiedads_destroy_url
    assert_response :success
  end

  test "should get new" do
    get classifiedads_new_url
    assert_response :success
  end

  test "should get create" do
    get classifiedads_create_url
    assert_response :success
  end
end
