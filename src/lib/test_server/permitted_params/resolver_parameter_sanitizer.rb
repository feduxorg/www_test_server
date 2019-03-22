require 'test_server/permitted_params/parameter_sanitizer'

module TestServer
  module PermittedParams
    class ResolverParameterSanitizer < ParameterSanitizer
      def allowed_parameters
        resolvable + \
          changable
      end
    end
  end
end
