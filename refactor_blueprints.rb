require 'active_support/core_ext/string'
Dir.glob('c:/Users/Zeus/Desktop/ROR PROJECTS/SANGAM-API/app/controllers/api/v1/**/*.rb').each do |file|
  next if file.include?('auth/') || file.include?('admin/')
  
  content = File.read(file)
  
  # Infer model name from file name
  # e.g., events_controller.rb -> Event
  basename = File.basename(file, '_controller.rb')
  model_name = basename.classify
  blueprint = "#{model_name}Blueprint"
  
  # Check if Blueprint exists
  next unless File.exist?("c:/Users/Zeus/Desktop/ROR PROJECTS/SANGAM-API/app/blueprints/#{model_name.underscore}_blueprint.rb")
  
  # Replace data: @model with data: ModelBlueprint.render_as_hash(@model, view: :normal)
  var_name = model_name.underscore
  
  new_content = content.gsub(/data:\s*@#{var_name}\b/) do |match|
    "data: #{blueprint}.render_as_hash(@#{var_name}, view: :normal)"
  end
  
  new_content = new_content.gsub(/data:\s*#{var_name}\b/) do |match|
    "data: #{blueprint}.render_as_hash(#{var_name}, view: :normal)"
  end
  
  new_content = new_content.gsub(/data:\s*record\b/) do |match|
    "data: #{blueprint}.render_as_hash(record, view: :normal)"
  end
  
  new_content = new_content.gsub(/data:\s*records\b/) do |match|
    "data: #{blueprint}.render_as_hash(records, view: :normal)"
  end
  
  new_content = new_content.gsub(/data:\s*@records\b/) do |match|
    "data: #{blueprint}.render_as_hash(@records, view: :normal)"
  end

  if content != new_content
    File.write(file, new_content)
    puts "Refactored #{file}"
  end
end
