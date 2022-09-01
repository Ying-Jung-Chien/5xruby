FactoryBot.define do
  factory :task do
    header { Faker::Name.name }
    content { Faker::Lorem.paragraph }
    priority { Faker::Number.between(from: 0, to: 2) }
    status { Faker::Number.between(from: 0, to: 2) }
    start_time { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now + 1) }
    end_time { Faker::Time.between(from: DateTime.now + 1, to: DateTime.now + 5) }
    association :user, factory: :user
  end
end
