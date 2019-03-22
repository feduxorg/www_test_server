require 'test_server/permitted_params/streaming_parameter_sanitizer'

module TestServer
  module Streaming
    class PlainController < ApplicationController
      include ActionController::Live

      def show
        streaming_params[:count].to_i.times do |n|
          response.stream.write(
            encode(streaming_params) { "#{n + 1}: data" }
          )
          sleep(streaming_params[:wait].to_f / 1_000.0)
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
