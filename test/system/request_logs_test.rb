require "application_system_test_case"

class RequestLogsTest < ApplicationSystemTestCase
  setup do
    @request_log = request_logs(:one)
  end

  test "visiting the index" do
    visit request_logs_url
    assert_selector "h1", text: "Request Logs"
  end

  test "creating a Request log" do
    visit request_logs_url
    click_on "New Request Log"

    click_on "Create Request log"

    assert_text "Request log was successfully created"
    click_on "Back"
  end

  test "updating a Request log" do
    visit request_logs_url
    click_on "Edit", match: :first

    click_on "Update Request log"

    assert_text "Request log was successfully updated"
    click_on "Back"
  end

  test "destroying a Request log" do
    visit request_logs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Request log was successfully destroyed"
  end
end
