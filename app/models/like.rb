class Like < ApplicationRecord
  include Discard::Model
  belongs_to :course
  belongs_to :user

  validates_uniqueness_of :course_id, scope: :user_id
  validates :user_id, :course_id, presence: true, numericality: { only_integer: true }

  after_discard do
    Course.find(course_id).increment(:total_likes_count).save
  end

  after_undiscard do
    Course.find(course_id).decrement(:total_likes_count).save
  end
end
