class User < ApplicationRecord
  has_secure_password

  before_create :generate_auth_token

  has_many :user_properties, dependent: :destroy
  has_many :properties, through: :user_properties


  def regenerate_auth_token
    update(auth_token: SecureRandom.hex)
  end

  def invalidate_auth_token
    update(auth_token: nil)
  end

  private

  def generate_auth_token
    self.auth_token = SecureRandom.hex
  end
end
