require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dashboard_index_url
    assert_response :success
  end

  test "should get flujo" do
    get dashboard_flujo_url
    assert_response :success
  end

  test "should get volumen" do
    get dashboard_volumen_url
    assert_response :success
  end

  test "should get distribucion" do
    get dashboard_distribucion_url
    assert_response :success
  end

  test "should get datos" do
    get dashboard_datos_url
    assert_response :success
  end
end
