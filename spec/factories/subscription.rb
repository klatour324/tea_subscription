FactoryBot.define do
  factory :subscription do
    title { Faker::Coffee.blend_name }
    status { [0, 1].sample }
    price { Faker::Commerce.price(range: 9.99..99.99)}
    frequency { ["monthly", "weekly", "annually"].sample }
    tea
    customer
  end
end
