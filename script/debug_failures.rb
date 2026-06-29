require_relative '../config/environment'

# Mock request and auth
include Api::V1::AuthHelpers rescue nil

user = User.first || User.create!(email: 'test@example.com', password: 'password123', name: 'Test')
admin = User.find_by(super_admin: true) || User.create!(email: 'admin@example.com', password: 'password123', name: 'Admin', super_admin: true)

# Group creation
puts "--- Testing Group Creation ---"
begin
  group = Group.new(name: 'My New Group', privacy: 'public')
  # emulate controller behavior or just create directly to see validation errors
  # If it's failing in controller, let's call controller action directly
  controller = Api::V1::GroupsController.new
  # this is hard to mock correctly outside request spec. Let's just print group validation
  puts group.valid? ? "Group is valid" : group.errors.full_messages
rescue => e
  puts e.message
  puts e.backtrace[0..5]
end

# Admin dashboard
puts "--- Testing Admin Dashboard ---"
begin
  controller = Api::V1::Admin::DashboardController.new
  # The issue is likely in the view blueprints or a missing relationship
  # recent_users = User.order(created_at: :desc).limit(8)
  # UserBlueprint.render_as_hash(recent_users, view: :normal)
  puts "Admin dashboard test script..."
rescue => e
  puts e.message
  puts e.backtrace[0..5]
end
