class TestServer::Reflectors::RequestBodyController < ApplicationController
  skip_before_action :verify_authenticity_token

  add_breadcrumb I18n.t('views.root.link'), :root_path
  add_breadcrumb I18n.t('views.reflectors.link'), :test_server_reflectors_path

  def create
    render body: request.body.read
  end

  def show; end
end
