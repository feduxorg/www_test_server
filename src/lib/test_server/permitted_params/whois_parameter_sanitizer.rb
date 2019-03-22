require 'test_server/permitted_params/parameter_sanitizer'

module TestServer
  module PermittedParams
    class WhoisParameterSanitizer < ParameterSanitizer
      def allowed_parameters
        whoisable + \
          changable
      end
    end
  end
end
