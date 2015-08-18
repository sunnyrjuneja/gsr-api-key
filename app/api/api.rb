require 'grape'
require 'wine_bouncer'

class API < Grape::API
  format :json
  use ::WineBouncer::OAuth2

  rescue_from WineBouncer::Errors::OAuthUnauthorizedError do
    Rack::Response.new({
      id: 'unauthenticated',
      message: 'Request failed because user is not authenticated.'
    }.to_json, 401,  'Content-Type' => 'text/error').finish
  end

  oauth2
  get :hello do
    { hello: "world" }
  end

  add_swagger_documentation(base_path: '/api', format: :json)
end
