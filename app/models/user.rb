class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  attr_readonly :email
  has_many :courses, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  validates :first_name, :last_name, presence: true, format: { with: /\A[A-Za-z\s]+\z/ }
  validates :is_admin, inclusion: { in: [true, false] }
  has_secure_token
  has_secure_token :token
  def self.from_omniauth(auth)
    @user = find_by email: auth.info.email
    return @user if @user
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.first_name = auth.info.name
      user.last_name = auth.info.last_name
      user.email = auth.info.email
      user.password = Devise.friendly_token[8, 20]
      user.token = auth.credentials.token
      user.refresh_token = auth.credentials.refresh_token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.skip_confirmation!
      user.save(validate: false)
    end
  end
end
