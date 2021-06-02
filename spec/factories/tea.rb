FactoryBot.define do
  factory :tea do
    title { Faker::Company.name }
    description { Faker::Tea.variety }
    temperature { Faker::Number.decimal(l_digits: 2) }
    brew_time { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)}
  end
end
