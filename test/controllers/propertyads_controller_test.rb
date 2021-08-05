require "test_helper"

class PropertyadsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get propertyads_index_url
    assert_response :success
  end

  test "should get show" do
    get propertyads_show_url
    assert_response :success
  end

  test "should get update" do
    get propertyads_update_url
    assert_response :success
  end

  test "should get destroy" do
    get propertyads_destroy_url
    assert_response :success
  end

  test "should get new" do
    get propertyads_new_url
    assert_response :success
  end

  test "should get create" do
    get propertyads_create_url
    assert_response :success
  end
end
