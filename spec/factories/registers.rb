require "faker"

FactoryBot.define do
  factory :register do |r|
    r.lesson_step { rand(1..18) }
    association :user
    association :course
  end
end
