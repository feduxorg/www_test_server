require 'securerandom'

module TestServer
  module Config
    class << self
      def action_mailer_default_url
        if (url = ENV['ACTION_MAILER_DEFAULT_URL'])
          Addressable::URI.heuristric_parse(url.to_s).to_hash.slice(:host, :port)
        else
          { host: 'localhost', port: 3000 }
        end
      end

      def rails_secret_key_base
        if (key = ENV['RAILS_SECRET_KEY_BASE'])
          key
        else
          SecureRandom.hex(128)
        end
      end

      def rails_secret_token
        if (key = ENV['RAILS_SECRET_TOKEN'])
          key
        else
          SecureRandom.hex(128)
        end
      end

      def devise_secret_key
        if (key = ENV['DEVISE_SECRET_KEY'])
          key
        else
          SecureRandom.hex(128)
        end
      end
    end
  end
end
