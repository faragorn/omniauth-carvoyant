require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Carvoyant < OmniAuth::Strategies::OAuth2
      option :name, 'carvoyant'

      option :client_options, {
          site:           'https://auth.carvoyant.com',
          authorize_url:  'https://auth.carvoyant.com/oauth/authorize',
          token_url:      'https://api.carvoyant.com/oauth/token'
      }
    end
  end
end