module AuthHelper
  def create_user(username = Faker::Internet.user_name, password = "password")
    visit new_user_url
    fill_in 'Username', with: username
    fill_in 'Password', with: password
    click_on "Create User"
    [username, password]
  end
end
