# encoding: utf-8
module TestServer
  class ErrorHandler

    @handlers = []
    @mutex    = Mutex.new

    class << self
      attr_reader :handlers, :mutex
    end

    private

    attr_reader :details_i18n, :summary_i18n

    public

    attr_reader :exception, :status_code, :exit_code
    attr_accessor :original_message, :backtrace

    def initialize(options = {})
      @exception    = options.fetch(:exception)
      @details_i18n = options.fetch(:details)
      @summary_i18n = options.fetch(:summary)
      @exit_code    = options.fetch(:exit_code, 1)
      @status_code  = options.fetch(:status_code, :internal_server_error)
    rescue KeyError => e
      raise ArgumentError, e.message
    end

    class << self
      def create(options = {}, &block)
        handler = new(options, &block)
        handlers << handler

        handler
      end

      def find(exception)
        handlers.find(proc { default_handler }) { |h| h.exception == exception }
      end

      private

      def default_handler
        mutex.synchronize do
          @default_handler ||= new(
            exception: StandardError,
            details: 'errors.default.details',
            summary: 'errors.default.summary',
            exit_code: 99,
          )
        end
      end
    end

    def details(format = :plain)
      case format
      when :plain
        @details
      when :html
        Rack::Utils.escape_html(@details)
      else
        @details
      end
    end

    def summary(format = :plain)
      case format
      when :plain
        @summary
      when :html
        Rack::Utils.escape_html(@summary)
      else
        @summary
      end
    end

    def use(data)
      data = JSON.parse(data) if data.kind_of? String
      data = data.to_h.symbolize_keys

      @details ||= I18n.t(details_i18n, data)
      @summary ||= I18n.t(summary_i18n, data)
    end

    def execute(data = {})
      use(data)

      Kernel.exit exit_code
    end

    def to_hash
      ErrorHandler.mutex.synchronize do
        @details ||= I18n.t(details_i18n)
        @summary ||= I18n.t(summary_i18n)
      end

      {
        error_summary: summary,
        error_details: details,
        result: :failure,
      }
    end

    def to_json
      JSON.dump(to_hash)
    end
  end
end
