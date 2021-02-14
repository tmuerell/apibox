require "application_system_test_case"

class RequestExamplesTest < ApplicationSystemTestCase
  setup do
    @request_example = request_examples(:one)
  end

  test "visiting the index" do
    visit request_examples_url
    assert_selector "h1", text: "Request Examples"
  end

  test "creating a Request example" do
    visit request_examples_url
    click_on "New Request Example"

    fill_in "Body", with: @request_example.body
    fill_in "Content type", with: @request_example.content_type
    fill_in "Name", with: @request_example.name
    fill_in "Request", with: @request_example.request_id
    click_on "Create Request example"

    assert_text "Request example was successfully created"
    click_on "Back"
  end

  test "updating a Request example" do
    visit request_examples_url
    click_on "Edit", match: :first

    fill_in "Body", with: @request_example.body
    fill_in "Content type", with: @request_example.content_type
    fill_in "Name", with: @request_example.name
    fill_in "Request", with: @request_example.request_id
    click_on "Update Request example"

    assert_text "Request example was successfully updated"
    click_on "Back"
  end

  test "destroying a Request example" do
    visit request_examples_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Request example was successfully destroyed"
  end
end
