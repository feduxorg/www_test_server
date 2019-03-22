require 'test_server/permitted_params/parameter_sanitizer'

module TestServer
  module PermittedParams
    class GeneratorParameterSanitizer < ParameterSanitizer
      def allowed_parameters
        generatable + \
          repeatable
      end
    end
  end
end
