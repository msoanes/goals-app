FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name }
    session_token { '1234245'}
    password_digest { BCrypt::Password.create("password") }
  end

end
