require_relative 'config/environment'
Dir[Rails.root.join('app/models/**/*.rb')].each { |f| require f unless f.include?('concerns') }


models = ActiveRecord::Base.descendants.reject { |m| m.abstract_class? || m.name.start_with?('Action', 'Active') }

models.each do |model|
  blueprint_name = "#{model.name}Blueprint"
  file_path = Rails.root.join("app/blueprints/#{model.name.underscore}_blueprint.rb")
  
  next if File.exist?(file_path)
  
  columns = model.column_names.reject { |c| ['id', 'password_digest'].include?(c) }
  
  content = <<~RUBY
    class #{blueprint_name} < Blueprinter::Base
      identifier :id

      view :normal do
        fields #{columns.map { |c| ":" + c }.join(", ")}
      end
    end
  RUBY
  
  File.write(file_path, content)
  puts "Created #{file_path}"
end
