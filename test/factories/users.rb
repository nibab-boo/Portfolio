FactoryBot.define do
  factory :user do
    email { 'test1@test.com' }
    password { "password123" }
    admin { false }
  end

  factory :admin, class: User do
    email { 'test1@test.com' }
    password { "password123" }
    admin { true }
  end
end
