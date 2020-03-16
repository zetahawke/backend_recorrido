module V1
  class ApiController < ActionController::Base
    protect_from_forgery with: :exception, unless: -> { request.format.json? }
    before_action :cors_preflight_check
    after_action :cors_set_access_control_headers
    before_action :add_allow_credentials_headers
  
    def cors_set_access_control_headers
      headers['Access-Control-Allow-Origin']  = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization'
      headers['Access-Control-Max-Age']       = '1728000'
    end
  
    def cors_preflight_check
      if request.method == 'OPTIONS'
        headers['Access-Control-Allow-Origin']  = '*'
        headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
        headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Authorization'
        headers['Access-Control-Max-Age']       = '1728000'
        render text: '', content_type: 'text/plain'
      end
    end
  
    def add_allow_credentials_headers
      response.headers['Access-Control-Allow-Origin'] = '*'
      response.headers['Access-Control-Allow-Credentials'] = 'true'
      response.headers['Access-Control-Allow-Methods'] = 'POST, PUT, PATCH, DELETE, GET, OPTIONS'
      response.headers['Access-Control-Request-Method'] = '*'
      response.headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    end
  end
end
