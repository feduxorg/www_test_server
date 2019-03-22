module TestServer
  class FileUploaderController < ApplicationController
    include ERB::Util

    add_breadcrumb I18n.t('views.root.link'), :root_path
    add_breadcrumb I18n.t('views.file_uploader.link'), :test_server_file_uploader_path

    def index; end
  end
end
