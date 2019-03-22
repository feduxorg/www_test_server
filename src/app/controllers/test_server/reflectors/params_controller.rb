class TestServer::Reflectors::ParamsController < ApplicationController
  add_breadcrumb I18n.t('views.root.link'), :root_path
  add_breadcrumb I18n.t('views.reflectors.link'), :test_server_reflectors_path

  def show
    add_breadcrumb I18n.t('views.reflectors_request_headers.link'), :test_server_reflectors_params_path
    @my_params = params.to_unsafe_h.delete_if { |k, v| %w(action controller).include?(k) }.map { |k, v| TestServer::Reflectors::Parameter.new(name: k, value: v) }
  end
end
