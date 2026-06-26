FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}_#{SecureRandom.hex(4)}@example.com" }
    password { 'password123' }
    password_confirmation { 'password123' }
    name { Faker::Name.name }
    verified { true }
    confirmed_at { Time.current }
  end

  factory :remember_token do
    association :user
    token_hash { Digest::SHA256.hexdigest(SecureRandom.hex(32)) }
    expires_at { 7.days.from_now }
  end

  factory :post do
    association :user
    content { Faker::Lorem.sentence }
    visibility { 'public' }
  end

  factory :comment do
    association :user
    association :post
    content { Faker::Lorem.sentence }
  end

  factory :like do
    association :user
    association :post
  end

  factory :share do
    association :user
    association :post
  end

  factory :follow do
    association :follower, factory: :user
    association :followee, factory: :user
  end

  factory :friendship do
    association :user
    association :friend, factory: :user
    status { 'accepted' }
  end

  factory :group do
    association :owner, factory: :user
    name { "Group #{SecureRandom.hex(4)}" }
  end

  factory :group_membership do
    association :user
    association :group
    role { 'member' }
    status { 'active' }
  end

  factory :event do
    association :organizer, factory: :user
    title { Faker::Lorem.word }
    starts_at { 1.day.from_now }
    ends_at { 2.days.from_now }
  end

  factory :event_response do
    association :user
    association :event
    response { 'going' }
  end

  factory :conversation do
    association :sender, factory: :user
    association :recipient, factory: :user
  end

  factory :message do
    association :conversation
    association :user
    body { Faker::Lorem.sentence }
  end

  factory :notification do
    association :recipient, factory: :user
    association :actor, factory: :user
    notification_type { 'like' }
    message { 'liked your post' }
  end

  factory :reel do
    association :user
    caption { Faker::Lorem.sentence }
  end

  factory :reel_like do
    association :user
    association :reel
  end

  factory :reel_comment do
    association :user
    association :reel
    content { Faker::Lorem.sentence }
  end

  factory :story do
    association :user
    story_type { 'text' }
    expires_at { 24.hours.from_now }
  end

  factory :bookmark do
    association :user
    association :bookmarkable, factory: :post
  end

  factory :bookmark_collection do
    association :user
    name { "Collection #{SecureRandom.hex(4)}" }
  end

  factory :poll do
    association :post
    question { 'Do you like Rails?' }
  end

  factory :poll_option do
    association :poll
    body { 'Yes' }
  end

  factory :poll_vote do
    association :user
    association :poll
    association :poll_option
  end

  factory :hashtag do
    name { "tag#{SecureRandom.hex(4)}" }
  end

  factory :category_tag do
    name { "category#{SecureRandom.hex(4)}" }
    slug { "slug-#{SecureRandom.hex(4)}" }
  end

  factory :close_friend do
    association :user
    association :close_friend, factory: :user
  end

  factory :article do
    association :user
    title { Faker::Book.title }
  end

  factory :marketplace_listing do
    association :user
    title { 'Old Laptop' }
    price { 150.0 }
  end

  factory :group_chat do
    association :owner, factory: :user
    name { 'Group chat' }
  end

  factory :group_chat_member do
    association :group_chat
    association :user
  end

  factory :group_chat_message do
    association :group_chat
    association :user
    body { 'Hello guys' }
  end
end
