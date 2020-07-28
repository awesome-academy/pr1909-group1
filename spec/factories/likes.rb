require "faker"

FactoryBot.define do
  factory :like do |r|
    association :user
    association :course
  end
end
