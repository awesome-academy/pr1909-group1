class Employer < ApplicationRecord
  belongs_to :user
  has_many :job_post, dependent: :destroy
  mount_uploader :company_logo, CompanyLogoUploader

  validates :user_id, presence: true, uniqueness: true
  validates :company_name, length: { maximum: 70 }
end
