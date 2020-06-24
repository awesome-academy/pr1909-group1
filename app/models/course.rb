class Course < ApplicationRecord
  belongs_to :user
  belongs_to :course_type
  mount_uploader :course_image, CourseImageUploader
  has_many :registers, dependent: :destroy
  has_many :review_courses, dependent: :destroy
  has_many :users, through: :registers
  has_many :evaluate_courses, dependent: :destroy
  has_many :lessons, dependent: :destroy

  validates :user_id, :course_title, :course_overview, :course_description, :course_type_id, presence: true
  validates :course_type_id, :user_id, numericality: { only_integer: true }
end
