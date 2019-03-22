require 'test_server/permitted_params/generator_parameter_sanitizer'

module TestServer
  module Generator
    class XhrController < ApplicationController
      add_breadcrumb I18n.t('views.root.link'), :root_path
      add_breadcrumb I18n.t('views.generator.link'), :test_server_generator_xhr_path

      before_action :authenticate_user!

      def show
        authorize :generator, :index?

        add_breadcrumb I18n.t('views.generator.xhr.link'), :test_server_generator_xhr_path

        @urls = [
          # is already part of list
          # "http://#{request.host_with_port}/static/plain.html",
          test_server_streaming_plain_url,
          test_server_streaming_eicar_url,
          test_server_streaming_random_url,
          test_server_string_plain_url,
          test_server_string_eicar_url,
          test_server_string_sleep_url,
          test_server_string_random_url
        ]

        @count   = generator_params[:count]
        @url     = generator_params[:url]
        @timeout = generator_params[:timeout]
        @repeat  = generator_params[:repeat]
      end

      private

      def parameter_sanitizer
        TestServer::PermittedParams::GeneratorParameterSanitizer.new
      end

      def generator_params
        parameter_sanitizer.use(
          params,
          'count'   => 10,
          'timeout' => 1_000,
          'repeat'  => 'false',
        )
      end
    end
  end
end
