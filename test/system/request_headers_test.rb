require "application_system_test_case"

class RequestHeadersTest < ApplicationSystemTestCase
  setup do
    @request_header = request_headers(:one)
  end

  test "visiting the index" do
    visit request_headers_url
    assert_selector "h1", text: "Request Headers"
  end

  test "creating a Request header" do
    visit request_headers_url
    click_on "New Request Header"

    fill_in "Name", with: @request_header.name
    fill_in "Request", with: @request_header.request_id
    fill_in "Value", with: @request_header.value
    click_on "Create Request header"

    assert_text "Request header was successfully created"
    click_on "Back"
  end

  test "updating a Request header" do
    visit request_headers_url
    click_on "Edit", match: :first

    fill_in "Name", with: @request_header.name
    fill_in "Request", with: @request_header.request_id
    fill_in "Value", with: @request_header.value
    click_on "Update Request header"

    assert_text "Request header was successfully updated"
    click_on "Back"
  end

  test "destroying a Request header" do
    visit request_headers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Request header was successfully destroyed"
  end
end
