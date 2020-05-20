class JobPost < ApplicationRecord
  belongs_to :employer
  has_many :apply_activities, foreign_key: :job_post_id, dependent: :destroy
  has_many :apply_activities, foreign_key: :employer_id, dependent: :destroy
  has_many :candidates, through: :apply_activities
  scope :not_expired, -> { where("job_expired_date >= ?", Date.today) }

  enum job_location: Settings.job_location.general.to_h
  enum job_type: Settings.job_type.general.to_h
  enum job_status: Settings.job_status.general.to_h
  enum job_location_view: Settings.job_location.view.to_h
  enum job_type_view: Settings.job_type.view.to_h

  validates :employer_id, :job_location, :job_type, :job_status, :post_priority, :salary_min,
            :post_title, :job_description, presence: true
  validates :employer_id, numericality: { only_integer: true }
  validates :job_location, inclusion: { in: job_locations.keys }
  validates :job_type, inclusion: { in: job_types.keys }
  validates :job_status, inclusion: { in: job_statuses.keys }
  validates :salary_max, numericality: { greater_than: :salary_min }
  validates :salary_min, numericality: { greater_than_or_equal_to: 0 }
  validates :job_expired_date, inclusion: { in: (Date.today.to_date..1.year.from_now.to_date) }
end
