class Register < ApplicationRecord
  belongs_to :course
  belongs_to :user

  validates :course_id, :user_id, presence: true, numericality: { only_integer: true }
  validates :user_id, uniqueness: { scope: :course_id }

  after_create :increase_counter_register

  private

  def increase_counter_register
    Course.find(course_id).increment(:total_registers_count).save
  end
end
