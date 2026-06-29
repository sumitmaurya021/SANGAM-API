require_relative '../config/environment'

specs_dir = File.join(__dir__, '..', 'spec', 'models')

ActiveRecord::Base.descendants.each do |model|
  next if model.name == 'ApplicationRecord' || model.name == 'ActionText::RichText' || model.name == 'ActionText::EncryptedRichText' || model.name.start_with?('ActionMailbox') || model.name.start_with?('ActiveStorage') || model.name.start_with?('ActionText')
  
  filename = model.name.underscore
  spec_file = File.join(specs_dir, "#{filename}_spec.rb")
  
  spec_content = "require 'rails_helper'\n\n"
  spec_content += "RSpec.describe #{model.name}, type: :model do\n"
  
  # Associations
  spec_content += "  describe 'Associations' do\n"
  model.reflect_on_all_associations.each do |assoc|
    case assoc.macro
    when :belongs_to
      spec_content += "    it { should belong_to(:#{assoc.name}) }\n"
    when :has_many
      spec_content += "    it { should have_many(:#{assoc.name}) }\n"
    when :has_one
      spec_content += "    it { should have_one(:#{assoc.name}) }\n"
    when :has_and_belongs_to_many
      spec_content += "    it { should have_and_belongs_to_many(:#{assoc.name}) }\n"
    end
  end
  spec_content += "  end\n\n"
  
  # Validations
  spec_content += "  describe 'Validations' do\n"
  model.validators.each do |validator|
    validator.attributes.each do |attr|
      next if attr.to_s.include?('.')
      case validator
      when ActiveRecord::Validations::PresenceValidator
        spec_content += "    it { should validate_presence_of(:#{attr}) }\n"
      when ActiveRecord::Validations::LengthValidator
        if validator.options[:maximum]
          spec_content += "    it { should validate_length_of(:#{attr}).is_at_most(#{validator.options[:maximum]}) }\n"
        end
        if validator.options[:minimum]
          spec_content += "    it { should validate_length_of(:#{attr}).is_at_least(#{validator.options[:minimum]}) }\n"
        end
      when ActiveRecord::Validations::UniquenessValidator
        spec_content += "    it { should validate_uniqueness_of(:#{attr}).case_insensitive }\n"
      end
    end
  end
  spec_content += "  end\n"
  
  spec_content += "end\n"
  
  File.write(spec_file, spec_content)
  puts "Generated comprehensive model spec: #{spec_file}"
end
