FactoryBot.define do
  factory :subscription do
    title { "Brew Town Monthly Subscription" }
    status { [true, false].sample }
    price { "$" Faker::Number.decimal(l_digits: 2)}
    frequency { "Once a month" }
    tea
    customer
  end
end
