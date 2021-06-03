class SubscriptionSerializer
  include FastJsonapi::ObjectSerializer
  set_type "subscription"
  attributes  :title,
              :price,
              :active,
              :frequency,
              :customer_id,
              :tea_id
end
