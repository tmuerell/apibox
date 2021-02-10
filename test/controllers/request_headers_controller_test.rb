require "test_helper"

class RequestHeadersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @request_header = request_headers(:one)
  end

  test "should get index" do
    get request_headers_url
    assert_response :success
  end

  test "should get new" do
    get new_request_header_url
    assert_response :success
  end

  test "should create request_header" do
    assert_difference('RequestHeader.count') do
      post request_headers_url, params: { request_header: { name: @request_header.name, request_id: @request_header.request_id, value: @request_header.value } }
    end

    assert_redirected_to request_header_url(RequestHeader.last)
  end

  test "should show request_header" do
    get request_header_url(@request_header)
    assert_response :success
  end

  test "should get edit" do
    get edit_request_header_url(@request_header)
    assert_response :success
  end

  test "should update request_header" do
    patch request_header_url(@request_header), params: { request_header: { name: @request_header.name, request_id: @request_header.request_id, value: @request_header.value } }
    assert_redirected_to request_header_url(@request_header)
  end

  test "should destroy request_header" do
    assert_difference('RequestHeader.count', -1) do
      delete request_header_url(@request_header)
    end

    assert_redirected_to request_headers_url
  end
end
