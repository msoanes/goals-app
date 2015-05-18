require 'rails_helper'

describe "Goals" do
    before(:each) do
      create_user
      FactoryGirl.create(:goal)
    end

  describe "goal creation" do
    it "validates presence of content" do
      click_on "New Goal"
      click_on "Add Goal"
      expect(page).to have_content('Content can\'t be blank')
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
    it "links to editing on show page" do
      visit goal_url(Goal.last)
      click_on "Edit Goal"
      find_field('Goal').value.should eq Goal.last.content
    end

    it "it only links to editing for the goal's user" do
      FactoryGirl.create(:user)
      FactoryGirl.create(:goal, user: User.last)

      visit goal_url(Goal.last)
      expect(page).to_not have_content("Edit Goal")
    end

    it "validates the presence of content" do
      visit goal_url(Goal.last)
      click_on "Edit Goal"

      fill_in "Goal", with: ''
      click_on "Update Goal"
      expect(page).to have_content("Content can't be blank")
    end

    it "successfully changes the values" do
      visit goal_url(Goal.last)
      click_on "Edit Goal"

      fill_in "Goal", with: 'I want to kill all humans'
      click_on "Update Goal"
      expect(page).to have_content("I want to kill all humans")

    end

  end

  describe "deleting" do
    it "should show a destroy button on the show page" do
      visit goal_url(Goal.last)
      expect(page).to have_button("Delete")
    end

    it "should only show the destroy button for the goal's user" do
      FactoryGirl.create(:user)
      FactoryGirl.create(:goal, user: User.last)

      visit goal_url(Goal.last)
      expect(page).to_not have_button("Delete")
    end

    it "no longer shows the goal on the index" do
      goal = Goal.last
      visit goal_url(goal)
      click_on "Delete"
      expect(page).to_not have_content(goal.content)
    end

  end

end
