require "faker"

FactoryBot.define do
  factory :user do |f|
    f.full_name { Faker::Name.middle_name.delete("',^") }
    f.email { Faker::Internet.email }
    f.password { "password" }
    f.password_confirmation { "password" }
    f.confirmed_at { Time.zone.now }
    f.is_admin { false }
    f.created_at { Faker::Date.between(from: '2020-07-01', to: Time.zone.now) }
  end
end
