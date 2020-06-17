class CourseType < ApplicationRecord
  has_many :courses

  validates :course_type, presence: true, length: { maximum: 50 }
end
