class TestServer::DnsRequests::IpAddressController < ApplicationController
  add_breadcrumb I18n.t('views.root.link'), :root_path
  add_breadcrumb I18n.t('views.dns_requests_ip_address.link'), :new_test_server_dns_requests_ip_address_path

  before_action :authenticate_user!, only: [:create, :new]

  # GET /test_server/dns_requests/ip_address/new
  def new
    authorize TestServer::DnsRequests::IpAddress

    @dns_request   = TestServer::DnsRequests::IpAddress.new
  end

  # POST /test_server/dns_requests/ip_address
  def create
    authorize TestServer::DnsRequests::IpAddress

    add_breadcrumb dns_request_params[:ip_address] if dns_request_params.key? :ip_address

    result     = {}
    ip_address = dns_request_params[:ip_address].strip

    begin
      result[:names]      = dns_resolver.getnames(ip_address)
      result[:ip_address] = ip_address
    rescue => e
      Rails.logger.error e.message
      flash[:alert] = format('Resolving "%s" failed. Please see logs for more details', ip_address)

      result[:names] = ['N/A']
    end

    @dns_request = TestServer::DnsRequests::IpAddress.new(result)

    render :show
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def dns_request_params
    parameter_sanitizer.use(
      params
    ).fetch(:test_server_dns_requests_ip_address, {})
  end

  def parameter_sanitizer
    TestServer::PermittedParams::ResolverParameterSanitizer.new
  end
end
