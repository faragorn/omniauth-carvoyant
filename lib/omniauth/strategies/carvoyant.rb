require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Carvoyant < OmniAuth::Strategies::OAuth2

      SITE_PREFIX = '/v1/api'

      option :name, 'carvoyant'

      option :client_options, {
          site:           'https://api.carvoyant.com/v1/api',
          authorize_url:  'https://auth.carvoyant.com/oauth/authorize',
          token_url:      'https://api.carvoyant.com/oauth/token'
      }

      uid do
        raw_info['id']
      end

      info do
        {
          'name'                    => "#{raw_info['firstName']} #{raw_info['lastName']}",
          'first_name'              => raw_info['firstName'],
          'last_name'               => raw_info['lastName'],
          'email'                   => raw_info['email'],
          'username'                => raw_info['username']
        }
      end


      def callback_url
        full_host + script_name + callback_path
      end

      def raw_info
        @raw_info ||= access_token.get("#{SITE_PREFIX}/account").parsed['account'][0]
      end
    end
  end
end