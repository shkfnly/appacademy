require 'rails_helper'


feature "creating a comment" do
  before :each do
    sign_up('test_user1')
    make_public_goal
    click_on 'Log Out'
    sign_up('test_user2')
  end

  feature "on user" do

    it "should show Add comment" do
      expect(page).to have_selector(:link_or_button, 'Add Comment')
    end

    it "should add a valid comment" do
      fill_in "Comment:", :with => 'I want to wear your skin'
      click_on 'Add Comment'
      expect(page).to have_content('I want to wear your skin')
      expect(page).to have_selector(:link_or_button, 'test_user2')
    end

    it "should not add an invalid comment" do
      fill_in "Comment:", :with => ''
      click_on 'Add Comment'
      expect(page).to have_content("Body can't be blank")
      expect(page).not_to have_selector(:link_or_button, 'test_user2')
    end
  end

  feature "on goal" do
    before :each do
      visit 'users/goals/1'
    end
    it "should show Add comment" do
      expect(page).to have_selector(:link_or_button, 'Add Comment')
    end

    it "should add a valid comment" do
      fill_in "Comment:", :with => 'I want to wear your skin'
      click_on 'Add Comment'
      expect(page).to have_content('I want to wear your skin')
      expect(page).to have_selector(:link_or_button, 'test_user2')
    end

    it "should not add an invalid comment" do
      fill_in "Comment:", :with => ''
      click_on 'Add Comment'
      expect(page).to have_content("Body can't be blank")
      expect(page).not_to have_selector(:link_or_button, 'test_user2')
    end
  end
end
