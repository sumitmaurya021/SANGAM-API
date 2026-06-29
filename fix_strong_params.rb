require_relative 'config/environment'
Dir[Rails.root.join('app/models/**/*.rb')].each { |f| require f unless f.include?('concerns') }

Dir.glob('c:/Users/Zeus/Desktop/ROR PROJECTS/SANGAM-API/app/controllers/api/v1/**/*.rb').each do |file|
  next if file.include?('auth/') || file.include?('admin/')
  
  content = File.read(file)
  
  next unless content.include?('.permit!')
  
  basename = File.basename(file, '_controller.rb')
  model_name = basename.classify
  
  begin
    model = Object.const_get(model_name)
    columns = model.column_names.reject { |c| ['id', 'created_at', 'updated_at', 'password_digest'].include?(c) }
    
    permit_str = ".permit(#{columns.map { |c| ":" + c }.join(", ")})"
    
    new_content = content.gsub('.permit!', permit_str)
    
    File.write(file, new_content)
    puts "Fixed strong params in #{file}"
  rescue NameError
    puts "Could not find model #{model_name} for #{file}"
  end
end
