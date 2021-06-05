FactoryBot.define do
  factory :subscription do
    title { "Brew Town Monthly Subscription" }
    status { [0, 1].sample }
    price { Faker::Commerce.price(range: 9.99..99.99)}
    frequency { "Once a month" }
    tea
    customer
  end
end
