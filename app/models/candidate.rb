class Candidate < ApplicationRecord
  belongs_to :user
  accepts_nested_attributes_for :user
  mount_uploader :avatar, AvatarUploader
  mount_uploader :cv, CvUploader

  # validate
  validates :user_id, presence: true, uniqueness: true
  validates :phone, length: { maximum: 16 }, format: { with: /[-+ 0-9]/ }, allow_blank: true
  validates :date_of_birth, exclusion: { in: (18.years.ago.to_date..Date.today.to_date) }
end
