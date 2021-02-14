require "test_helper"

class RequestExamplesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @request_example = request_examples(:one)
  end

  test "should get index" do
    get request_examples_url
    assert_response :success
  end

  test "should get new" do
    get new_request_example_url
    assert_response :success
  end

  test "should create request_example" do
    assert_difference('RequestExample.count') do
      post request_examples_url, params: { request_example: { body: @request_example.body, content_type: @request_example.content_type, name: @request_example.name, request_id: @request_example.request_id } }
    end

    assert_redirected_to request_example_url(RequestExample.last)
  end

  test "should show request_example" do
    get request_example_url(@request_example)
    assert_response :success
  end

  test "should get edit" do
    get edit_request_example_url(@request_example)
    assert_response :success
  end

  test "should update request_example" do
    patch request_example_url(@request_example), params: { request_example: { body: @request_example.body, content_type: @request_example.content_type, name: @request_example.name, request_id: @request_example.request_id } }
    assert_redirected_to request_example_url(@request_example)
  end

  test "should destroy request_example" do
    assert_difference('RequestExample.count', -1) do
      delete request_example_url(@request_example)
    end

    assert_redirected_to request_examples_url
  end
end
