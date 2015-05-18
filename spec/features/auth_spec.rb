require 'rails_helper'

describe "the signup process" do

  it "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New user"
  end

  feature "signing up a user" do
    before(:each) do
      visit new_user_url
      fill_in 'Username', with: "user1234"
      fill_in 'Password', with: "password"
      click_on "Create User"
    end

    it "shows username on the homepage after signup" do
      expect(page).to have_content "user1234"
    end

  end

end

describe "logging in" do

  it "shows username on the homepage after login" do
    # Put this into a helper method!
    visit new_user_url
    fill_in 'Username', with: "user1234"
    fill_in 'Password', with: "password"
    click_on "Create User"
    click_on "Log out"

    visit new_session_url
    fill_in 'Username', with: "user1234"
    fill_in 'Password', with: "password"
    click_on "Log in"

    expect(page).to have_content "user1234"
  end

end

describe "logging out" do
  it "begins with logged out state" do
    visit goals_url
    expect(page).to have_content "Log in"
    expect(page).to_not have_content "Log out"
  end

  it "doesn't show username on the homepage after logout" do
    visit new_user_url
    fill_in 'Username', with: "user1234"
    fill_in 'Password', with: "password"
    click_on "Create User"
    click_on "Log out"

    expect(page).to_not have_content "user1234"
  end

end
