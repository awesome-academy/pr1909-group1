class Employer < ApplicationRecord
  belongs_to :user
  mount_uploader :company_logo, CompanyLogoUploader

  # validate
  validates :user_id, presence: true, uniqueness: true
  validates :company_name, length: { maximum: 70 }
end
