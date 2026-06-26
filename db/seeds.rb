if Doorkeeper::Application.count.zero?
  Doorkeeper::Application.create(name: "SANGAM-API", redirect_uri: "", scopes: "")
end
