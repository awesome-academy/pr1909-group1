class Course < ApplicationRecord
  searchkick word_start: [:course_title, :course_type], highlight: [:course_title, :course_type], callbacks: false
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
  validate :at_least_one_quiz

  accepts_nested_attributes_for :lessons, allow_destroy: true
  after_commit :reindex_course, if: -> (model) { model.previous_changes.key?("course_title") }

  def at_least_one_quiz
    check = 0
    lessons.each do |lesson|
      if lesson.quiz? && lesson.quiz_questions.length > 0
        check = 1
      end
    end
    errors.add(:lessons, "must be have at least one quiz") if check == 0
  end

  def reindex_course
    Course.search_index.delete
    Course.reindex
  end

  def search_data
    {
      course_title: course_title,
      course_type: course_type.course_type,
    }
  end
end
