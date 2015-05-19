require 'rails_helper'

describe "Comments" do
  before(:each) do
    create_user
  end

  describe "comment on goal" do
    before(:each) do
      FactoryGirl.create(:goal)
    end

    it "shows a comment form" do
      visit goal_url(Goal.last)
      expect(page).to have_content("Comment")
      expect(page).to have_button("Submit Comment")
    end

    it "does not allow blank comment" do
      visit goal_url(Goal.last)
      click_on "Submit Comment"
      expect(page).to have_content("Content can't be blank")
    end

    it "shows comment on goal show page" do
      visit goal_url(Goal.last)
      fill_in "Comment", with: "You're gonna fail for sure!"
      click_on "Submit Comment"
      expect(page).to have_content("You're gonna fail for sure!")
    end

  end

  describe "comment on user" do
    before(:each) do
    end

    it "shows a comment form" do
      visit user_url(User.last)
      expect(page).to have_content("Comment")
      expect(page).to have_button("Submit Comment")
    end

    it "does not allow blank comment" do
      visit user_url(User.last)
      click_on "Submit Comment"
      expect(page).to have_content("Content can't be blank")
    end

    it "shows comment on user show page" do
      visit user_url(User.last)
      fill_in "Comment", with: "Nice goals!"
      click_on "Submit Comment"
      expect(page).to have_content("Nice goals!")
    end

  end

end
