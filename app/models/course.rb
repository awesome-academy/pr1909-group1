class Course < ApplicationRecord
  belongs_to :user
  mount_uploader :course_image, CourseImageUploader

  enum course_type: Settings.course_type.general.to_h
  enum course_type_view: Settings.course_type.view.to_h

  validates :user_id, :course_title, :course_overview, :course_description, :course_type, presence: true
  validates :user_id, numericality: { only_integer: true }
  validates :course_type, inclusion: { in: course_types.keys }
end
