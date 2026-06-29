require_relative '../config/environment'

specs_dir = File.join(__dir__, '..', 'spec', 'requests', 'api', 'v1')
FileUtils.mkdir_p(specs_dir)

Rails.application.routes.routes.each do |route|
  next unless route.defaults[:controller] && route.defaults[:controller].start_with?('api/v1/')
  
  controller_path = route.defaults[:controller]
  controller_name = controller_path.split('/').last
  action = route.defaults[:action]
  
  # Format spec filename based on controller
  spec_file = File.join(specs_dir, "#{controller_name}_spec.rb")
  
  unless File.exist?(spec_file)
    File.write(spec_file, <<~RUBY)
      require 'rails_helper'

      RSpec.describe "#{controller_name.camelize} API", type: :request do
        let(:user) { create(:user) }
        let(:headers) { auth_headers(user) }

      end
    RUBY
  end
  
  # Read existing spec to append if needed (simple string replacement for demonstration)
  content = File.read(spec_file)
  
  unless content.include?("describe '#{route.verb} #{route.path.spec.to_s}'")
    test_block = <<~RUBY
        describe '#{route.verb} #{route.path.spec.to_s}' do
          it 'returns a successful response' do
            # pending "add examples"
          end
        end
    RUBY
    
    # Insert before the last end
    content = content.sub(/\nend\Z/, "\n#{test_block}\nend")
    File.write(spec_file, content)
  end
end

puts "Done generating request specs."
