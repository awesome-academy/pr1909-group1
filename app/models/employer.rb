class Employer < ApplicationRecord
  belongs_to :user, -> { with_deleted }
  has_many :job_posts, dependent: :destroy
  mount_uploader :company_logo, CompanyLogoUploader
  acts_as_paranoid

  validates :user_id, uniqueness: true, presence: true
  validates :company_name, length: { maximum: Settings.max_length.company_name }
end
