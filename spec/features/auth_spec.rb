require 'rails_helper'

describe "the signup process" do

  it "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New user"
  end

  feature "signing up a user" do

    it "shows username on the homepage after signup" do
      username, = create_user
      expect(page).to have_content username
    end

  end

end

describe "logging in" do

  it "shows username on the homepage after login" do
    # Put this into a helper method!
    username, password = create_user
    click_on "Log out"

    visit new_session_url
    fill_in 'Username', with: username
    fill_in 'Password', with: password
    click_on "Log in"

    expect(page).to have_content username
  end

end

describe "logging out" do
  it "begins with logged out state" do
    visit goals_url
    expect(page).to have_content "Sign in"
    expect(page).to_not have_content "Log out"
  end

  it "doesn't show username on the homepage after logout" do
    create_user
    click_on "Log out"

    expect(page).to_not have_content "user1234"
  end

end
