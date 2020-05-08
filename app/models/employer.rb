class Employer < ApplicationRecord
  belongs_to :user, -> { with_deleted }
  has_many :job_posts, dependent: :destroy
  mount_uploader :company_logo, CompanyLogoUploader
  acts_as_paranoid

  validates :user_id, presence: true, uniqueness: true
  validates :company_name, length: { maximum: 70 }
end
