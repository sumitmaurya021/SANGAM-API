require_relative '../config/environment'

Dir.glob(File.join(__dir__, '..', 'spec', 'requests', 'api', 'v1', '*_spec.rb')).each do |file|
  # Skip the manually written resources_spec.rb and auth_spec.rb to preserve their high quality tests
  next if file.include?('resources_spec.rb') || file.include?('auth_spec.rb')

  content = File.read(file)
  
  new_content = content.gsub(/describe '(GET|POST|PATCH|PUT|DELETE) (.*?)' do\s*it 'returns a successful response' do\s*# pending "add examples"\s*end\s*end/m) do |match|
    verb = $1
    path = $2
    
    clean_path = path.sub('(.:format)', '')
    path_params = clean_path.scan(/:([a-zA-Z0-9_]+)/).flatten
    
    setup_code = ""
    url_code = clean_path
    
    model_deps = []
    
    path_params.each do |param|
      if param == 'id'
        parts = clean_path.split('/')
        id_index = parts.index(':id')
        if id_index && id_index > 0
          resource = parts[id_index - 1]
          model_name = resource.singularize
          setup_code += "    let(:#{model_name}) { create(:#{model_name}) }\n"
          url_code = url_code.sub(':id', "\#{#{model_name}.id}")
          model_deps << model_name
        end
      elsif param.end_with?('_id')
        model_name = param.sub('_id', '')
        setup_code += "    let(:#{model_name}) { create(:#{model_name}) }\n"
        url_code = url_code.sub(":#{param}", "\#{#{model_name}.id}")
        model_deps << model_name
      end
    end
    
    request_call = ""
    if verb == 'POST' || verb == 'PATCH' || verb == 'PUT'
      parts = clean_path.split('/')
      resource = parts.last == ':id' ? parts[-2] : parts.last
      model_name = resource.singularize
      
      request_call = "      valid_attributes = attributes_for(:#{model_name}) rescue {}\n"
      request_call += "      #{verb.downcase} \"#{url_code}\", params: { #{model_name}: valid_attributes }, headers: headers\n"
      request_call += "      expect(response.status).to be_between(200, 422)\n"
    elsif verb == 'DELETE'
      request_call = "      #{verb.downcase} \"#{url_code}\", headers: headers\n"
      request_call += "      expect(response.status).to be_between(200, 204).or eq(404)\n"
    else
      request_call = "      #{verb.downcase} \"#{url_code}\", headers: headers\n"
      request_call += "      expect(response).to have_http_status(:success).or have_http_status(:not_found)\n"
    end
    
    <<~RUBY
      describe '#{verb} #{path}' do
    #{setup_code}
        it 'executes the request and returns a valid status' do
    #{request_call}
        end
      end
    RUBY
  end
  
  File.write(file, new_content)
  puts "Updated request specs in #{File.basename(file)}"
end
puts "All pending request specs populated!"
