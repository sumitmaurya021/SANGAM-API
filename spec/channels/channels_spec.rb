require 'rails_helper'

RSpec.describe 'ActionCable Channels', type: :channel do
  let(:user) { create(:user) }

  before do
    stub_connection current_user: user
  end

  describe PresenceChannel do
    it 'subscribes and streams from user_presence' do
      subscribe
      expect(subscription).to be_confirmed
      expect(subscription).to have_stream_from('user_presence')
    end

    it 'marks user online on heartbeat' do
      user.update_columns(online: false)
      subscribe
      perform :heartbeat
      expect(user.reload.online?).to be true
    end
  end

  describe NotificationChannel do
    it 'subscribes and streams from notifications_#{user.id}' do
      subscribe
      expect(subscription).to be_confirmed
      expect(subscription).to have_stream_from("notifications_#{user.id}")
    end

    it 'marks notification as read' do
      notification = create(:notification, recipient: user, read_at: nil)
      subscribe
      perform :mark_read, notification_id: notification.id
      expect(notification.reload.read_at).to_not be_nil
    end
  end
end
