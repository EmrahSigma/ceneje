require "test_helper"

class ContactSupportControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get contact_support_new_url
    assert_response :success
  end

  test "should get create" do
    get contact_support_create_url
    assert_response :success
  end
end
