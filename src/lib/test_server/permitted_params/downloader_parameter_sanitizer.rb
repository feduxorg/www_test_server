require 'test_server/permitted_params/parameter_sanitizer'

module TestServer
  module PermittedParams
    class DownloaderParameterSanitizer < ParameterSanitizer
      def allowed_parameters
        downloadable + \
          changable
      end
    end
  end
end
