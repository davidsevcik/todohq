FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "joe#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
    # sequence(:authentication_token) { |n| "token#{n}" }
  end

  factory :task do
    sequence(:title) { |n| "Taks no. #{n}" }
    user
  end
end
