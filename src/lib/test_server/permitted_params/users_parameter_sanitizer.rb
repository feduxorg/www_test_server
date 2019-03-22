require 'test_server/permitted_params/parameter_sanitizer'

module TestServer
  module PermittedParams
    class UsersParameterSanitizer < ParameterSanitizer
      def allowed_parameters
        changable + \
          [{user: %i(email password role_id)}, :save]
      end
    end
  end
end
