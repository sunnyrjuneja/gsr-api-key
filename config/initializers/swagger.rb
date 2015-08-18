GrapeSwaggerRails.options.tap do |o|
  o.app_url  = 'http://localhost:3000/api'
  o.api_auth     = 'bearer'
  o.api_key_name = 'Authorization'
  o.api_key_type = 'header'
end
