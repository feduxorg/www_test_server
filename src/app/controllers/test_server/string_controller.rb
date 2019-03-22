require 'test_server/permitted_params/string_parameter_sanitizer'

module TestServer
  class StringController < ApplicationController
    add_breadcrumb I18n.t('views.root.link'), :root_path
    add_breadcrumb I18n.t('views.string.link'), :test_server_string_path

    def index; end
  end
end
