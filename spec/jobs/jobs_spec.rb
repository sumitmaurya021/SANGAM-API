require 'rails_helper'

RSpec.describe 'Background Jobs', type: :job do
  describe PublishScheduledPostJob do
    it 'publishes a scheduled post' do
      post_item = create(:post, published: false, scheduled_at: 1.minute.ago)

      PublishScheduledPostJob.perform_now(post_item.id)

      expect(post_item.reload.published).to be true
    end

    it 'does not publish a post scheduled in the future' do
      post_item = create(:post, published: false, scheduled_at: 10.minutes.from_now)

      PublishScheduledPostJob.perform_now(post_item.id)

      expect(post_item.reload.published).to be false
    end
  end

  describe ArchiveExpiredStoriesJob do
    it 'archives expired stories' do
      expired_story = create(:story, expires_at: 1.second.ago, archived: false)
      active_story = create(:story, expires_at: 1.hour.from_now, archived: false)

      # We need to ensure the expired scope exists on Story
      # If not, let's mock or implement it
      # Wait, let's look at Story model to see if expired scope is there.
      # If Story doesn't have an expired scope, we'll verify it in the job perform.
      ArchiveExpiredStoriesJob.perform_now

      expect(expired_story.reload.archived).to be true
      expect(active_story.reload.archived).to be false
    end
  end

  describe SweepStalePresenceJob do
    it 'marks stale online users as offline' do
      stale_user = create(:user, online: true, last_seen_at: 5.minutes.ago)
      active_user = create(:user, online: true, last_seen_at: 10.seconds.ago)

      SweepStalePresenceJob.perform_now

      expect(stale_user.reload.online?).to be false
      expect(active_user.reload.online?).to be true
    end
  end
end
