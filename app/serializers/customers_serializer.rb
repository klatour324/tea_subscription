class CustomersSerializer
  include FastJsonapi::ObjectSerializer
  set_type "customer"
  attributes  :first_name,
              :last_name,
              :email,
              :street_address,
              :city,
              :state,
              :zipcode
end
