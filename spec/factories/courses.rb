require "faker"

FactoryBot.define do
  factory :course do |c|
    c.user_id { 1 }
    c.course_title { Faker::Lorem.sentence(word_count: 5) }
    c.course_overview { Faker::Lorem.sentence(word_count: 15) }
    c.course_description { Faker::Lorem.sentence(word_count: 40) }
    c.course_type_id { rand(1..4) }
    c.course_image { Faker::Avatar.image }
    association :course_type
    association :user
  end
end
