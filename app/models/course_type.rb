class CourseType < ApplicationRecord
  has_many :courses

  validates :course_type, presence: true, length: { maximum: Settings.length.course_type.maximum }
end
