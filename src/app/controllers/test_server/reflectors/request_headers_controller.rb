class TestServer::Reflectors::RequestHeadersController < ApplicationController
  add_breadcrumb I18n.t('views.root.link'), :root_path
  add_breadcrumb I18n.t('views.reflectors.link'), :test_server_reflectors_path

  # GET /test_server/reflectors/request_headers
  def show
    add_breadcrumb I18n.t('views.reflectors_request_headers.link'), :test_server_reflectors_request_headers_path
    @http_headers = request.headers.to_h.keep_if { |k, v| k.start_with?('HTTP_') }.map { |k, v| TestServer::Reflectors::RequestHeader.new(name: k, value: v) }
  end
end
