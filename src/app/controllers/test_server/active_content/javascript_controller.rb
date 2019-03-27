module TestServer
  module ActiveContent
    class JavascriptController < ApplicationController
      add_breadcrumb I18n.t('views.root.link'), :root_path
      add_breadcrumb I18n.t('views.active_content.link'), :test_server_active_content_path
      add_breadcrumb I18n.t('views.active_content.javascript.link'), :test_server_active_content_javascript_path

      def show; end
    end
  end
end
