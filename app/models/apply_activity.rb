class ApplyActivity < ApplicationRecord
  belongs_to :candidate
  belongs_to :job_post, foreign_key: :job_post_id
  belongs_to :employer, foreign_key: :employer_id
  validates :candidate_id, uniqueness: { scope: :job_post_id }
  validates :candidate_id, :job_post_id, :employer_id, presence: true
end
