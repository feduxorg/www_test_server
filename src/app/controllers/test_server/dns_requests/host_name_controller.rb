class TestServer::DnsRequests::HostNameController < ApplicationController
  add_breadcrumb I18n.t('views.root.link'), :root_path
  add_breadcrumb I18n.t('views.dns_requests_host_name.link'), :new_test_server_dns_requests_host_name_path

  before_action :authenticate_user!, only: [:create, :new]

  # GET /test_server/dns_requests/host_name/new
  def new
    authorize TestServer::DnsRequests::HostName

    @dns_request   = TestServer::DnsRequests::HostName.new
  end

  # POST /test_server/host_name/dns_requests
  def create
    authorize TestServer::DnsRequests::HostName

    add_breadcrumb dns_request_params[:name] if dns_request_params.key? :name

    result = {}
    name   = dns_request_params[:name].strip

    begin
      result[:ip_addresses] = dns_resolver.getaddresses(name)
      result[:name]         = name
    rescue => e
      Rails.logger.error e.message
      flash[:alert] = format('Resolving "%s" failed. Please see logs for more details', name)

      result[:ip_addresses] = ['N/A']
    end

    @dns_request = TestServer::DnsRequests::HostName.new(result)

    render :show
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def dns_request_params
    parameter_sanitizer.use(
      params
    ).fetch(:test_server_dns_requests_host_name, {})
  end

  def parameter_sanitizer
    TestServer::PermittedParams::ResolverParameterSanitizer.new
  end
end
