require 'test_server/permitted_params/string_parameter_sanitizer'

module TestServer
  module String
    class RandomController < ApplicationController
      def show
        Kernel.sleep string_params[:wait].to_i

        render plain: encode(string_params) { generate_string(string_params[:count]) }
      end

      private

      def parameter_sanitizer
        TestServer::PermittedParams::StringParameterSanitizer.new
      end

      def string_params
        parameter_sanitizer.use(
          params,
          'count'  => 1,
          'base64' => false,
          'gzip'   => false,
        )
      end
    end
  end
end
