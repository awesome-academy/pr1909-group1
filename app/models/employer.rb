class Employer < ApplicationRecord
  belongs_to :user, -> { with_deleted }
  has_many :job_posts, dependent: :destroy
  mount_uploader :company_logo, CompanyLogoUploader
  acts_as_paranoid

  validates :user_id, :company_size, :company_name, presence: true
  validates :user_id, uniqueness: true
  validates :company_name, length: { maximum: 70 }
end
