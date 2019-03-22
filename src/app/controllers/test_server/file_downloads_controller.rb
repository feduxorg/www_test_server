require 'test_server/permitted_params/downloader_parameter_sanitizer'

module TestServer
  class FileDownloadsController < ApplicationController
    before_action :set_file_download, only: [:show, :edit, :update, :destroy]

    add_breadcrumb I18n.t('views.root.link'), :root_path
    add_breadcrumb I18n.t('views.file_downloads.link'), :test_server_file_downloads_path

    before_action :authenticate_user!, only: [:edit, :update, :new]

    # GET /file_downloads
    def index
      authorize FileDownload
      @file_downloads = FileDownload.all
    end

    # GET /file_downloads/1
    def show
      add_breadcrumb @file_download.name
    end

    # GET /file_downloads/new
    def new
      @file_download = FileDownload.new
      authorize @file_download
    end

    # GET /file_downloads/1/edit
    def edit
    end

    def by_label
      @file_download = FileDownload.where(label: label_params[:label]).first

      fail ActiveRecord::RecordNotFound if @file_download.blank?

      send_file @file_download.path, type: @file_download.mime_type, disposition: 'attachment', filename: @file_download.name
    end

    # POST /file_downloads
    def create
      @file_download = FileDownload.new(file_download_params)

      authorize @file_download

      @file_download.user = current_user if current_user
      @file_download.file_filename = file_download_params[:file].original_filename
      @file_download.file_content_type = file_download_params[:file].content_type
      @file_download.save!

      set_metadata(@file_download)

      respond_to do |format|
        if @file_download.save
          format.html { redirect_to @file_download, notice: 'File was successfully created.' }
        else
          format.html { render :new }
        end
      end
    end

    # PATCH/PUT /file_downloads/1
    def update
      @file_download.update(file_download_params)

      @file_download.user              = current_user if current_user
      @file_download.file_filename     = file_download_params[:file].original_filename
      @file_download.file_content_type = file_download_params[:file].content_type

      set_metadata(@file_download)

      respond_to do |format|
        if @file_download.update(file_download_params)
          format.html { redirect_to @file_download, notice: 'File was successfully updated.' }
        else
          format.html { render :edit }
        end
      end
    end

    # DELETE /file_downloads/1
    def destroy
      @file_download.destroy

      respond_to do |format|
        format.html { redirect_to file_downloads_url, notice: 'File was successfully destroyed.' }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_file_download
      @file_download = FileDownload.find(params[:id])
      authorize @file_download
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def file_download_params
      params.require(:test_server_file_download).permit(:file, :label)
    end

    def set_metadata(f)
      operations = []
      operations << VirusDetector.new
      operations << FiletypeDetector.new
      operations << Sha256Calculator.new

      operations.each { |o| o.use f }
    end

    def label_params
      params.permit(:label)
    end
  end
end
