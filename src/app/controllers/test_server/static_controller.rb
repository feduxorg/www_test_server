module TestServer
  class StaticController < ApplicationController
    def index
      add_breadcrumb I18n.t('views.root.link'), :root_path
      add_breadcrumb I18n.t('views.static.link'), :static_path
    end
  end
end
