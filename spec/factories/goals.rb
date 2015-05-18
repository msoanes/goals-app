FactoryGirl.define do
  factory :goal do
    content { Faker::Hacker.say_something_smart }
    is_private false
    user { User.first }
  end

end
