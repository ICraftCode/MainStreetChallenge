require "test_helper"
require "application_system_test_case"

class CompaniesControllerTest < ApplicationSystemTestCase

  def setup
    @company = companies(:hometown_painting)
  end

  test "Index" do
    visit companies_path

    assert_text "Companies"
    assert_text "Hometown Painting"
    assert_text "Wolf Painting"
  end

  test "Show" do
    visit company_path(@company)

    assert_text @company.name
    assert_text @company.phone
    assert_text @company.email
    assert_text @company.city
    assert_text @company.state
  end

  test "Update" do
    visit edit_company_path(@company)

    within("form#edit_company_#{@company.id}") do
      fill_in("company_name", with: "Updated Test Company")
      fill_in("company_zip_code", with: "93009")
      click_button "Update Company"
    end

    assert_text "Changes Saved"

    @company.reload
    assert_equal "Updated Test Company", @company.name
    assert_equal "93009", @company.zip_code
  end

  test "Create" do
    visit new_company_path

    within("form#new_company") do
      fill_in("company_name", with: "New Test Company")
      fill_in("company_zip_code", with: "12345")
      fill_in("company_email", with: "new_test_company@getmainstreet.com")
      click_button "Create Company"
    end

    assert_text "Saved"

    last_company = Company.last
    assert_equal "New Test Company", last_company.name
    assert_equal "12345", last_company.zip_code

    visit new_company_path

    within("form#new_company") do
      fill_in("company_name", with: "New Test Company wrong email")
      fill_in("company_zip_code", with: "12345")
      fill_in("company_email", with: "new_test_companyget.com")
      click_button "Create Company"
    end

    assert_text "Email should be a valid email_id that ends with @getmainstreet.com;"


  end

  test "Delete" do
    visit delete_company_path(@company)
    assert_text "Company deleted!"
    #setup()
  end

end
