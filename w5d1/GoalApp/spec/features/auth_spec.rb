require 'rails_helper'

feature "the signup process" do
  before :each do
    visit "/users/new"
  end

  it "has a new user page" do
    expect(page).to have_content "Create a New User"
  end

  feature "signing up a user" do
    before(:each) do
      visit new_user_url
      fill_in 'Username:', :with => "testing_username"
      fill_in 'Password:', :with => "biscuits"
      click_on "Create User"
    end
    it "shows username on the homepage after signup" do
      expect(page).to have_content "testing_username"
      save_and_open_page
    end
  end

end

feature "logging in" do
  before :each do
    sign_up('testing_username')
  end

  it "shows username on the homepage after login" do
    expect(page).to have_content "testing_username"
  end
end

feature "logging out" do
  before :each do
    visit "/session/new"
  end

  it "begins with logged out state" do
    expect(page).to have_content 'Log In'
  end

  it "doesn't show username on the homepage after logout" do
    sign_up('testing_username')
    click_button 'Log Out'
    expect(page).not_to have_content 'testing_username'
  end

end
