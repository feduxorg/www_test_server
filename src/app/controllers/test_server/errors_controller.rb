require 'test_server/server_error'

module TestServer
  class ErrorsController < ApplicationController
    add_breadcrumb I18n.t('views.root.link'), :root_path

    def show
      @details = details

      render status: status_code
    end

    private

    def server_response
      ActionDispatch::ExceptionWrapper.rescue_responses[server_error.class.name]
    end

    def status_code
      ActionDispatch::ExceptionWrapper.new(request.env, server_error).status_code
    end

    def server_error
      TestServer::ServerError.new(request.env['action_dispatch.exception'])
    end

    def details
      @details ||= {}.tap do |h|
        I18n.with_options scope: [:exception, :show, server_response], exception_name: server_error.class_name, exception_message: server_error.message do |i18n|
          h[:title]     = i18n.t "#{server_error.name}.title", default: i18n.t(:title, default: server_error.class_name)
          h[:description] = i18n.t "#{server_error.name}.description", default: i18n.t(:description, default: server_error.message)
        end
      end
    end
    helper_method :details

    # def error_params
    #   params.permit(:exception)
    # end
  end
end
