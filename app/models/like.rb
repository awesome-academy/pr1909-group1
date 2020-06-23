class Like < ApplicationRecord
  belongs_to :course
  belongs_to :user

  validates_uniqueness_of :course_id, scope: :user_id
  validates :user_id, :course_id, presence: true, numericality: { only_integer: true }

  after_create :increase_counter_like
  after_destroy :decrease_counter_like

  private

  def increase_counter_like
    Course.find(self.course_id).increment(:total_likes_count).save
  end

  def decrease_counter_like
    Course.find(self.course_id).decrement(:total_likes_count).save
  end
end
