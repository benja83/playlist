# frozen_string_literal: true

json.data users do |user|
    json.type 'users'
    json.id user.id
    json.attributes do
      json.first_name user.first_name
      json.last_name user.last_name
      json.email user.email
      json.username user.user_name
    end
end
