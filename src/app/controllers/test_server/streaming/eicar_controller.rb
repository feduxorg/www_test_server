require 'test_server/permitted_params/streaming_parameter_sanitizer'

module TestServer
  module Streaming
    class EicarController < ApplicationController
      include ActionController::Live

      def show
        streaming_params[:count].to_i.times do |n|
          generate_eicar.each do |c|
            response.stream.write(
              encode(streaming_params) { c }
            )

            sleep(streaming_params[:wait].to_f / 1_000.0)
          end
        end

        response.stream.close
      end

      private

      def parameter_sanitizer
        TestServer::PermittedParams::StreamingParameterSanitizer.new
      end

      def streaming_params
        parameter_sanitizer.use(
          params,
          'wait'   => 1_000,
          'count'  => 1,
          'base64' => false,
          'gzip'   => false,
        )
      end
    end
  end
end
