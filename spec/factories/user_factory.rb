# frozen_string_literal: true

FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name  'Doe'
    email      { FFaker::Internet.email }
    user_name  { FFaker::Internet.user_name }
  end
end
