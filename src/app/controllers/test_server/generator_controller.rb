require 'test_server/permitted_params/generator_parameter_sanitizer'

module TestServer
  class GeneratorController < ApplicationController
    add_breadcrumb I18n.t('views.root.link'), :root_path
    add_breadcrumb I18n.t('views.generator.link'), :test_server_generator_path

    before_action :authenticate_user!

    def index; end
  end
end
