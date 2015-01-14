require 'rails_helper'


feature "goal creation process" do
  before :each do
    sign_up('testing_username')
  end

  it "should have a new goal page" do
    expect(page).to have_content("Add Goal")
  end

  it "should redirect to a new goal page" do
    click_on "Add Goal"
    expect(page).to have_content("Add a New Goal")
  end

  it "should create a valid goal" do
    make_private_goal

    expect(page).to have_content("Test Goal")
    expect(page).to have_content("testing_username")
  end

  it "should raise error for a blank goal" do
    click_on "Add Goal"
    fill_in "Title", with: "Weight Loss"
    click_on "Submit Goal"

    expect(page).not_to have_content("Weight Loss")
    expect(page).to have_content("Body can't be blank")
  end
end

feature "goal deletion process" do
  before :each do
    sign_up("testing_username")
    make_private_goal
  end

  it "should have delete button on user show page" do
    expect(page).to have_selector(:link_or_button, "Delete Goal")
  end

  it "should remove goal from user page after click" do
    click_on "Delete Goal"
    expect(page).not_to have_content("Test Goal")
  end
end

feature "goal editing process" do
  before :each do
    sign_up("testing_username")
    make_private_goal
  end

  it "should have a edit button on user show page" do
    expect(page).to have_selector(:link_or_button, "Edit Goal")
  end

  it "should render an edit page on click" do
    click_on "Edit Goal"
    expect(page).to have_content("Edit Test Goal")
    expect(page).to have_selector(:link_or_button, "Update Goal")
  end

  it "should update a goal with valid paramaters" do
    click_on "Edit Goal"
    fill_in "Title", with: "New Title"
    click_on "Update Goal"

    expect(page).to have_content("New Title")
    expect(page).to have_content("testing_username")
  end

  it "should raise error for a goal update with invalid parameters" do
    click_on "Edit Goal"
    fill_in "Title", with: ""
    click_on "Update Goal"

    expect(page).to have_content("Title can't be blank")
  end
end

feature "goal reading process" do
  before :each do
    sign_up("testing_username")
    make_private_goal
    click_on "Test Goal"
  end

  it "should show a link on the users show page for goal title" do
    expect(page).to have_content("Test Goal Description")
  end

  it "should show the body of the goal on show page" do
    expect(page).to have_content("This is my goal")
  end

  it "should have a link back to the user page" do
    expect(page).to have_selector(:link_or_button, "Back to testing_username")
  end

  feature "private goals" do
    before :each do
      click_button "Log Out"
      sign_up("private_user")
      click_on "Add Goal"
      fill_in "Title", with: "Private Test Goal"
      fill_in "Body", with: "This is my goal"
      check("Private")
      click_button "Submit Goal"
      click_button 'Log Out'
      sign_in("testing_username")
    end

    it "should not show other private goals on" do
      expect(page).not_to have_content("Private Test Goal")
      expect(page).to have_content("Test Goal")

    end
  end

  feature "public goals" do
    before :each do
      click_button "Log Out"
      sign_up("other_user")
      make_public_goal
      click_button "Log Out"
      sign_in("testing_username")
    end

    it "should show other users' public goals" do
      visit '/users/2/goals/2'
      expect(page).to have_content("Public Goal")
    end
  end
end
