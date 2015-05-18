FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name }
    session_token nil
    password_digest { BCrypt::Password.create("password") }
  end

end
