class CommentLesson < ApplicationRecord
  belongs_to :lesson
  belongs_to :user

  validates :lesson_id, :user_id, presence: true, numericality: { only_integer: true }
  validates :content, presence: true
end
