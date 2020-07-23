require "faker"

FactoryBot.define do
  factory :course_type do |c|
    c.course_type { ["Web Design", "Web Development", "Marketing", "Product Management"].sample }
  end
end
