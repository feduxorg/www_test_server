module TestServer
  class ActiveContentController < ApplicationController
    add_breadcrumb I18n.t('views.root.link'), :root_path
    add_breadcrumb I18n.t('views.active_content.link'), :test_server_active_content_path

    def index; end
  end
end
