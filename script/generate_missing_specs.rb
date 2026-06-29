require 'fileutils'
require 'active_support/inflector'

models_dir = File.join(__dir__, '..', 'app', 'models')
factories_dir = File.join(__dir__, '..', 'spec', 'factories')
specs_dir = File.join(__dir__, '..', 'spec', 'models')

FileUtils.mkdir_p(factories_dir)
FileUtils.mkdir_p(specs_dir)

Dir.glob(File.join(models_dir, '*.rb')).each do |file|
  filename = File.basename(file, '.rb')
  next if filename == 'application_record' || filename == 'concerns' || filename.include?('application')
  
  model_name = filename.camelize
  
  # Generate factory
  factory_file = File.join(factories_dir, "#{filename.pluralize}.rb")
  unless File.exist?(factory_file)
    File.write(factory_file, <<~RUBY)
      FactoryBot.define do
        factory :#{filename} do
          # Add default attributes here
        end
      end
    RUBY
    puts "Created factory: #{factory_file}"
  end
  
  # Generate model spec
  spec_file = File.join(specs_dir, "#{filename}_spec.rb")
  unless File.exist?(spec_file)
    File.write(spec_file, <<~RUBY)
      require 'rails_helper'

      RSpec.describe #{model_name}, type: :model do
        describe 'Validations' do
          # pending "add some examples to (or delete) \#{__FILE__}"
        end

        describe 'Associations' do
          # pending "add some examples to (or delete) \#{__FILE__}"
        end
      end
    RUBY
    puts "Created spec: #{spec_file}"
  end
end

puts "Done generating missing specs and factories."
