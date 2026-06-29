class RememberToken < ApplicationRecord
  belongs_to :user

  validates :token_hash, presence: true, uniqueness: true
  validates :expires_at, presence: true

  def expired?
    Time.current > expires_at
  end
end
