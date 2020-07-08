class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  mount_uploader :avatar, AvatarUploader
  attr_readonly :email
  has_many :courses, dependent: :destroy
  has_many :registers, dependent: :destroy
  has_many :courses, through: :registers
  has_many :review_courses, dependent: :destroy
  has_many :quiz_result, dependent: :destroy
  has_many :comment_lesson, dependent: :destroy
  has_many :likes, dependent: :destroy

  scope :not_admin, -> { where(is_admin: false) }
  scope :created_at_today, -> { where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  validates :full_name, presence: true, format: { with: /\A[A-Za-z\s]+\z/ }
  validates :is_admin, inclusion: { in: [true, false] }

  def self.from_omniauth(auth)
    @user = find_by email: auth.info.email
    return @user if @user
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.full_name = auth.info.name
      user.email = auth.info.email
      user.remote_avatar_url = auth.info.image
      user.password = Devise.friendly_token[8, 20]
      user.token = auth.credentials.token
      user.refresh_token = auth.credentials.refresh_token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.skip_confirmation!
      user.save(validate: false)
    end
  end
end
