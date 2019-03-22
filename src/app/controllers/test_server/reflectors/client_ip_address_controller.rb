class TestServer::Reflectors::ClientIpAddressController < ApplicationController
  add_breadcrumb I18n.t('views.root.link'), :root_path
  add_breadcrumb I18n.t('views.reflectors.link'), :test_server_reflectors_path

  # GET /test_server/reflectors/client_ip_address
  def show
    add_breadcrumb I18n.t('views.reflectors_client_ip_address.link'), :test_server_reflectors_client_ip_address_path
    @ip_address = request.remote_ip
  end
end
