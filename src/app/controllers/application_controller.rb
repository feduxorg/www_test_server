require 'test_server/permitted_params/parameter_sanitizer'
require 'resolv'

class ApplicationController < ActionController::Base
  layout 'application'

  include Pundit

  include TestServer::WebHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_caching

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def login_via_ssl?
    ENV["LOGIN_VIA_SSL"] == "true" || ENV["LOGIN_VIA_SSL"] == "1"
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."

    if request.url == request.referrer
      redirect_to root_path
      return
    end

    redirect_to(request.referrer || root_path)
  end

  def parameter_sanitizer
    TestServer::PermittedParams::ParameterSanitizer.new
  end

  def dns_resolver
    if Rails.configuration.x.name_servers.blank?
      Resolv
    else
      Resolv::DNS.new(nameserver: Rails.configuration.x.name_servers)
    end
  end

  helper_method :parameter_sanitizer
  helper_method :login_via_ssl?
end
