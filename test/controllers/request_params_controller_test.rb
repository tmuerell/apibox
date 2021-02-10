require "test_helper"

class RequestParamsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @request_param = request_params(:one)
  end

  test "should get index" do
    get request_params_url
    assert_response :success
  end

  test "should get new" do
    get new_request_param_url
    assert_response :success
  end

  test "should create request_param" do
    assert_difference('RequestParam.count') do
      post request_params_url, params: { request_param: { name: @request_param.name, request_id: @request_param.request_id, value: @request_param.value } }
    end

    assert_redirected_to request_param_url(RequestParam.last)
  end

  test "should show request_param" do
    get request_param_url(@request_param)
    assert_response :success
  end

  test "should get edit" do
    get edit_request_param_url(@request_param)
    assert_response :success
  end

  test "should update request_param" do
    patch request_param_url(@request_param), params: { request_param: { name: @request_param.name, request_id: @request_param.request_id, value: @request_param.value } }
    assert_redirected_to request_param_url(@request_param)
  end

  test "should destroy request_param" do
    assert_difference('RequestParam.count', -1) do
      delete request_param_url(@request_param)
    end

    assert_redirected_to request_params_url
  end
end
