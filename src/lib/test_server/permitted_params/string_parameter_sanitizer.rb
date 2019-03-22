require 'test_server/permitted_params/parameter_sanitizer'

module TestServer
  module PermittedParams
    class StringParameterSanitizer < ParameterSanitizer
      def allowed_parameters
        encodable + \
          streamable + \
          cachable + \
          countable
      end
    end
  end
end
