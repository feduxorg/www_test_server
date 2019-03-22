require 'test_server/permitted_params/parameter_sanitizer'

module TestServer
  module PermittedParams
    class UploaderParameterSanitizer < ParameterSanitizer
      def allowed_parameters
        uploadable + \
          changable
      end
    end
  end
end
