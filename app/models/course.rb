class Course < ApplicationRecord
  searchkick  word_start: [:course_title, :course_type], word_middle: [:course_title, :course_type],
    highlight: [:course_title, :course_type]
  belongs_to :user
  belongs_to :course_type
  mount_uploader :course_image, CourseImageUploader

  has_many :registers, dependent: :destroy
  has_many :review_courses, dependent: :destroy
  has_many :users, through: :registers
  has_many :lessons, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :user_id, :course_title, :course_overview, :course_description, :course_type_id, presence: true
  validates :course_type_id, :user_id, numericality: { only_integer: true }
  accepts_nested_attributes_for :lessons

  def search_data
    {
      course_title: course_title,
      course_type: course_type.course_type
    }
  end
end
