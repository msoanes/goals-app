require 'rails_helper'

describe "Goals" do
    before(:each) { create_user }

  describe "goal creation" do
    it "validates presence of content" do
      click_on "New Goal"
      click_on "Add Goal"
      expect(page).to have_content('Goal cannot be blank')
    end

    it "shows public goals to other users" do
      click_on "New Goal"
      fill_in "Goal", with: "I want to kill a unicorn"
      click_on "Add Goal"
      click_on "Log out"
      create_user
      expect(page).to have_content("I want to kill a unicorn")
    end

    it "doesn't show private goals to other users" do
      click_on "New Goal"
      fill_in "Goal", with: "I want to resurrect a unicorn"
      choose "Private"
      click_on "Add Goal"
      click_on "Log out"
      create_user
      expect(page).to_not have_content("I want to resurrect a unicorn")
    end
  end

  describe "updating" do


  end

  describe "deleting" do


  end

end
