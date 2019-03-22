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
      exception: Exceptions::UserError,
      details: 'errors.user_error.details',
      summary: 'errors.user_error.summary',
      status_code: :internal_server_error,
    )
end
