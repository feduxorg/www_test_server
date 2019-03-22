require 'whois'
class TestServer::WhoisRequestsController < ApplicationController
  add_breadcrumb I18n.t('views.root.link'), :root_path
  add_breadcrumb I18n.t('views.whois_requests.link'), :new_test_server_whois_request_path

  before_action :authenticate_user!, only: [:create, :new]

  # GET /test_server/whois_requests/new
  def new
    authorize TestServer::WhoisRequest

    @whois_request   = TestServer::WhoisRequest.new
  end

  # POST /test_server/whois_requests
  def create
    authorize TestServer::WhoisRequest

    add_breadcrumb whois_request_params[:request] if whois_request_params.key? :request

    result  = {}
    request = whois_request_params[:request].strip

    begin
      result[:request]  = request
      result[:response] = whois_fetcher.lookup(request).to_s
    rescue => e
      Rails.logger.error e.message
      flash[:alert] = format('Gathering information about "%s" failed. Please see logs for more details', request)

      result[:response] = 'N/A'
    end

    @whois_request = TestServer::WhoisRequest.new(result)

    render :show
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def whois_request_params
    parameter_sanitizer.use(
      params
    ).fetch(:test_server_whois_request, {})
  end

  def parameter_sanitizer
    TestServer::PermittedParams::WhoisParameterSanitizer.new
  end

  def whois_fetcher
    Whois::Client.new(timeout: 5)
  end
end
