# encoding: utf-8
module TestServer
    # See http://futureshock-ed.com/2011/03/04/http-status-code-symbols-for-rails/
    # for list of symbols for status codes
    ErrorHandler.create(
      exception: StandardError,
      summary: 'errors.default.summary',
      details: 'errors.default.details',
      status_code: :internal_server_error,
    )

    ErrorHandler.create(
      exception: Exceptions::InternalError,
      details: 'errors.internal_error.details',
      summary: 'errors.internal_error.summary',
      status_code: :internal_server_error,
    )
    
    ErrorHandler.create(
      exception: Exceptions::ConfigFileNotReadable,
      details: 'errors.unreadable_config_file.details',
      summary: 'errors.unreadable_config_file.summary',
      status_code: :internal_server_error,
    )

    ErrorHandler.create(
      exception: Exceptions::UserError,
      details: 'errors.user_error.details',
      summary: 'errors.user_error.summary',
      status_code: :internal_server_error,
    )

    ErrorHandler.create(
      exception: Exceptions::PidFileDoesNotExist,
      details: 'errors.invalid_proxy_pac.details',
      summary: 'errors.invalid_proxy_pac.summary',
      status_code: :internal_server_error,
    )

    ErrorHandler.create(
      exception: Exceptions::GivenUrlInvalid,
      details: 'errors.invalid_url.details',
      summary: 'errors.invalid_url.summary',
      status_code: :internal_server_error,
    )
    
    ErrorHandler.create(
      exception: Exceptions::ServerListenStatementInvalid,
      details: 'errors.invalid_listen_statement.details',
      summary: 'errors.invalid_listen_statement.summary',
      status_code: :internal_server_error,
    )

    ErrorHandler.create(
      exception: Exceptions::AccessLogPathInvalid,
      details: 'errors.invalid_access_log_path.details',
      summary: 'errors.invalid_access_log_path.summary',
      status_code: :internal_server_error,
    )
end
