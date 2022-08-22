FactoryBot.define do
    factory :user do
      name { Faker::Name.name }
      password { Internet.password }
      position { "user" }
    end
  end