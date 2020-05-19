class ApplyActivity < ApplicationRecord
  belongs_to :candidate
  belongs_to :job_post, foreign_key: :job_post_id
  belongs_to :employer, foreign_key: :employer_id
  validates :candidate_id, uniqueness: { scope: :job_post_id }
  validates :candidate_id, :job_post_id, :employer_id, presence: true

  include AASM
  aasm do
    state :applying, initial: true
    state :testing
    state :interviewing
    state :approve
    state :rejected

    event :review do
      transitions from: :applying, to: :testing
    end

    event :mark do
      transitions from: :testing, to: :interviewing, guard: :if_pass?
      transitions from: :testing, to: :rejected
    end

    event :process_interview do
      transitions from: :interviewing, to: :approve
    end

    event :reject do
      transitions from: [:applying, :testing, :interviewing, :approve], to: :rejected
    end
  end

  def if_pass?(test_mark)
    test_mark >= 7
  end
end
