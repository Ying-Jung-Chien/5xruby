FactoryBot.define do
    factory :user do
      name { Faker::Name.name }
      password { Faker::Internet.password(min_length: 10, mix_case: true) }
      position { "user" }
    end
  end