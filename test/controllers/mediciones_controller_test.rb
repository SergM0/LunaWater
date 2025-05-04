require "test_helper"

class MedicionesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get mediciones_index_url
    assert_response :success
  end
end
