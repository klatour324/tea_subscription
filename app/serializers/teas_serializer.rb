class TeasSerializer
  include FastJsonapi::ObjectSerializer
  set_type "teas"
  attributes  :title,
              :description,
              :temperature,
              :brew_time
end
