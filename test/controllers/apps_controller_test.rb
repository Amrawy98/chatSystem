require 'test_helper'

class AppsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get apps_index_url
    assert_response :success
  end

end
