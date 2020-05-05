class ApplyActivity < ApplicationRecord
  belongs_to :candidate
  belongs_to :job_post
  validates :candidate_id, uniqueness: { scope: :job_post_id }
  validates :candidate_id, :job_post_id, :employer_id, presence: true
end
