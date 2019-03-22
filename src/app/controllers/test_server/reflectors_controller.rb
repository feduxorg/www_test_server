class TestServer::ReflectorsController < ApplicationController
  add_breadcrumb I18n.t('views.root.link'), :root_path

  # GET /test_server/reflectors
  def index
    add_breadcrumb I18n.t('views.reflectors.link'), :test_server_reflectors_path
  end
end
