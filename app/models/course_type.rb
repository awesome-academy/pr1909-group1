class CourseType < ApplicationRecord
  has_many :courses

  validates :course_type, presence: true, length: { maximum: Settings.course_type.length.maximum }
end
