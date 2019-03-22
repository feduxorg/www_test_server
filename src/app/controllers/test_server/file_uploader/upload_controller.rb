require 'test_server/permitted_params/uploader_parameter_sanitizer'

module TestServer
  module FileUploader
    class UploadController < ApplicationController
      include ERB::Util

      add_breadcrumb I18n.t('views.root.link'), :root_path
      add_breadcrumb I18n.t('views.file_uploader.link'), :test_server_file_uploader_path

      def create
        add_breadcrumb I18n.t('views.file_uploader.upload.link'), :test_server_file_uploader_upload_path

        @file_upload = FileUpload.new(file_upload_params)

        raise ActionController::BadRequest, "No or empty file uploaded" if @file_upload.uploaded_file.blank?

        operations = []

       if @file_upload.virus_scan == true
         operations << FilePermissionsRelaxer.new
         operations << VirusDetector.new
       end

        operations << FiletypeDetector.new if @file_upload.filetype_detection == true

        if @file_upload.checksum_calculation == true
          operations << Sha256Calculator.new 
          operations << MD5Calculator.new 
        end

        operations << FileDeleter.new

        operations.each do |d| 
          d.use @file_upload.uploaded_file
        end

        add_breadcrumb I18n.t('views.file_uploader.result.link', file: html_escape(@file_upload.uploaded_file.name))
      end

      def new
        add_breadcrumb I18n.t('views.file_uploader.upload.link'), :test_server_file_uploader_upload_path

        @file_upload = FileUpload.new
        @file_upload.virus_scan = false
        @file_upload.filetype_detection = false
        @file_upload.checksum_calculation = false
      end

      private

      def file_upload_params
        params.require(:test_server_file_upload).permit(:uploaded_file, :virus_scan, :filetype_detection, :checksum_calculation)
      end
    end
  end
end
