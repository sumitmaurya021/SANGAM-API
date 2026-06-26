require 'rails_helper'

RSpec.describe RememberToken, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    subject { build(:remember_token) }
    it { should validate_presence_of(:token_hash) }
    it { should validate_uniqueness_of(:token_hash) }
    it { should validate_presence_of(:expires_at) }
  end

  describe '#expired?' do
    it 'returns true if expires_at is in the past' do
      token = build(:remember_token, expires_at: 1.hour.ago)
      expect(token.expired?).to be true
    end

    it 'returns false if expires_at is in the future' do
      token = build(:remember_token, expires_at: 1.hour.from_now)
      expect(token.expired?).to be false
    end
  end
end
