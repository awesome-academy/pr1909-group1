class Candidate < ApplicationRecord
  belongs_to :user, -> { with_deleted }
  accepts_nested_attributes_for :user
  has_many :apply_activities, dependent: :destroy
  has_many :job_posts, through: :apply_activities
  mount_uploader :avatar, AvatarUploader
  mount_uploader :cv, CvUploader
  acts_as_paranoid

  # validate
  validates :user_id, presence: true, uniqueness: true
  validates :phone, length: { maximum: Settings.max_length.phone }, format: { with: /[-+ 0-9]/ }, allow_blank: true
  validates :date_of_birth, exclusion: { in: (18.years.ago.to_date..Date.today.to_date) }

  def apply(job_post)
    ApplyActivity.create(candidate_id: id, job_post_id: job_post.id, employer_id: job_post.employer_id)
  end

  def apply?(job_post)
    ApplyActivity.exists?(candidate_id: id, job_post_id: job_post.id)
  end
end
