class JobPost < ApplicationRecord
  belongs_to :employer

  enum job_location: Settings.job_location.general.to_h
  enum job_type: Settings.job_type.general.to_h
  enum job_status: Settings.job_status.general.to_h

  validates :employer_id, :job_location, :job_type, :job_status, :post_priority, :salary_min,
            :post_title, :job_description, :job_expired_date, presence: true
  validates :employer_id, :salary_min, numericality: { only_integer: true }
  validates :job_location, inclusion: { in: job_locations.keys }
  validates :job_type, inclusion: { in: job_types.keys }
  validates :job_status, inclusion: { in: job_statuses.keys }
  validates :salary_max, numericality: { greater_than: :salary_min }
  validates :job_location, inclusion: { in: job_locations.keys }
  validates :job_type, inclusion: { in: job_types.keys }
  validates :job_status, inclusion: { in: job_statuses.keys }
  validates :job_expired_date, inclusion: { in: (Date.today.to_date..1.year.from_now.to_date) }
end
