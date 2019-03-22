require 'test_server/permitted_params/parameter_lists'

module TestServer
  module PermittedParams
    class ParameterSanitizer
      include ParameterLists

      def use(params, defaults = {})
        old_params = params.to_unsafe_h.modify_values { |v| v.to_bool }
        old_params_with_defaults_set = old_params.reverse_merge(defaults)

        ActionController::Parameters.new(old_params_with_defaults_set).permit(allowed_parameters)
      end

      def allowed_parameters
        {}
      end
    end
  end
end
