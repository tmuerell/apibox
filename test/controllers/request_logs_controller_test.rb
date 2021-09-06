require "test_helper"

class RequestLogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @request_log = request_logs(:one)
  end

  test "should get index" do
    get request_logs_url
    assert_response :success
  end

  test "should get new" do
    get new_request_log_url
    assert_response :success
  end

  test "should create request_log" do
    assert_difference('RequestLog.count') do
      post request_logs_url, params: { request_log: {  } }
    end

    assert_redirected_to request_log_url(RequestLog.last)
  end

  test "should show request_log" do
    get request_log_url(@request_log)
    assert_response :success
  end

  test "should get edit" do
    get edit_request_log_url(@request_log)
    assert_response :success
  end

  test "should update request_log" do
    patch request_log_url(@request_log), params: { request_log: {  } }
    assert_redirected_to request_log_url(@request_log)
  end

  test "should destroy request_log" do
    assert_difference('RequestLog.count', -1) do
      delete request_log_url(@request_log)
    end

    assert_redirected_to request_logs_url
  end
end
