require 'rails_helper'

RSpec.describe 'Social Models', type: :model do
  describe Post do
    it { should belong_to(:user) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
    it { should have_many(:shares).dependent(:destroy) }
    it { should validate_inclusion_of(:visibility).in_array(Post::VISIBILITY_OPTIONS) }
  end

  describe Comment do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  describe Like do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  describe Share do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  describe Follow do
    it { should belong_to(:follower).class_name('User') }
    it { should belong_to(:followee).class_name('User') }
  end

  describe Friendship do
    it { should belong_to(:user) }
    it { should belong_to(:friend).class_name('User') }
  end

  describe Group do
    it { should belong_to(:owner).class_name('User') }
    it { should have_many(:group_memberships).dependent(:destroy) }
    it { should have_many(:members).through(:group_memberships).source(:user) }
  end

  describe GroupMembership do
    it { should belong_to(:user) }
    it { should belong_to(:group) }
  end

  describe Event do
    it { should belong_to(:organizer).class_name('User') }
    it { should have_many(:event_responses).dependent(:destroy) }
  end

  describe EventResponse do
    it { should belong_to(:user) }
    it { should belong_to(:event) }
  end

  describe Fundraiser do
    it { should belong_to(:post) }
  end

  describe MarketplaceListing do
    it { should belong_to(:user) }
    it { should validate_presence_of(:title) }
  end

  describe Conversation do
    it { should belong_to(:sender).class_name('User') }
    it { should belong_to(:recipient).class_name('User') }
    it { should have_many(:messages).dependent(:destroy) }
  end

  describe Message do
    it { should belong_to(:conversation) }
    it { should belong_to(:user) }
  end

  describe Notification do
    it { should belong_to(:recipient).class_name('User') }
    it { should belong_to(:actor).class_name('User') }
  end

  describe Reel do
    it { should belong_to(:user) }
    it { should have_many(:reel_comments).dependent(:destroy) }
    it { should have_many(:reel_likes).dependent(:destroy) }
  end

  describe ReelLike do
    it { should belong_to(:user) }
    it { should belong_to(:reel) }
  end

  describe ReelComment do
    it { should belong_to(:user) }
    it { should belong_to(:reel) }
  end

  describe Story do
    it { should belong_to(:user) }
  end

  describe Bookmark do
    it { should belong_to(:user) }
    it { should belong_to(:bookmarkable) }
  end

  describe BookmarkCollection do
    it { should belong_to(:user) }
    it { should have_many(:bookmarks).dependent(:nullify) }
  end

  describe Poll do
    it { should belong_to(:post) }
    it { should have_many(:poll_options).dependent(:destroy) }
  end

  describe PollOption do
    it { should belong_to(:poll) }
  end

  describe PollVote do
    it { should belong_to(:user) }
    it { should belong_to(:poll) }
    it { should belong_to(:poll_option) }
  end

  describe Hashtag do
    subject { build(:hashtag) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  describe CategoryTag do
    subject { build(:category_tag) }
    it { should validate_uniqueness_of(:slug) }
  end

  describe CloseFriend do
    it { should belong_to(:user) }
    it { should belong_to(:close_friend).class_name('User') }
  end

  describe Article do
    it { should belong_to(:user) }
  end
end
