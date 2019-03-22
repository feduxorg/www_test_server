require 'test_server/permitted_params/streaming_parameter_sanitizer'

module TestServer
  class StreamingController < ApplicationController
    include ActionController::Live

    add_breadcrumb I18n.t('views.root.link'), :root_path
    add_breadcrumb I18n.t('views.streaming.link'), :test_server_streaming_path

    def index; end
  end
end
