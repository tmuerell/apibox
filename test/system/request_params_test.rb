require "application_system_test_case"

class RequestParamsTest < ApplicationSystemTestCase
  setup do
    @request_param = request_params(:one)
  end

  test "visiting the index" do
    visit request_params_url
    assert_selector "h1", text: "Request Params"
  end

  test "creating a Request param" do
    visit request_params_url
    click_on "New Request Param"

    fill_in "Name", with: @request_param.name
    fill_in "Request", with: @request_param.request_id
    fill_in "Value", with: @request_param.value
    click_on "Create Request param"

    assert_text "Request param was successfully created"
    click_on "Back"
  end

  test "updating a Request param" do
    visit request_params_url
    click_on "Edit", match: :first

    fill_in "Name", with: @request_param.name
    fill_in "Request", with: @request_param.request_id
    fill_in "Value", with: @request_param.value
    click_on "Update Request param"

    assert_text "Request param was successfully updated"
    click_on "Back"
  end

  test "destroying a Request param" do
    visit request_params_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Request param was successfully destroyed"
  end
end
