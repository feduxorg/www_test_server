module TestServer
  class DashboardController < ApplicationController
    add_breadcrumb I18n.t('views.root.link'), :root_path

    def show; end
  end
end
