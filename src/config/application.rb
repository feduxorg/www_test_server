require_relative 'boot'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'rails/all'
require 'test_server'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# Load environment
Dotenv::Railtie.load

module TestServer
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    
    # handle exceptions
    #config.exceptions_app = self.routes
    config.exceptions_app = ->(env) { TestServer::ErrorsController.action(:show).call(env) }

    # Precompile additional assets.
    # application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
    # config.assets.precompile += %w( search.js )
    config.assets.precompile << Proc.new { |path|
      true if %w( .png  .gif .jpg .jpeg .svg .eot  .otf .svc .woff .ttf ).include? Pathname.new(path).extname
    }

    # logging
    # config.logger = ActiveSupport::TaggedLogging.new(::Logger.new('log/error.log'))

    # assets
    config.assets.paths << Rails.root.join('vendor', 'assets', 'components')
    config.assets.cache = Sprockets::Cache::FileStore.new('tmp/cache/sass')

    # store for http caching
    config.cache_store = :memory_store

    config.middleware.use Rack::Deflater
    # config.middleware.use Rack::CommonLogger, TestServer::AccessLogger.new('log/access.log')

    ::Sass::Script::Number.precision = [10, ::Sass::Script::Number.precision].max

    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += %W[#{config.root}/app/validators/]

    # DNS servers
    config.x.name_servers = ENV['TEST_SERVER_NAME_SERVERS'].to_s.split(/ /)

    # configuration
    config.action_mailer.default_url_options = TestServer::Config.action_mailer_default_url
    config.secret_key_base                   = TestServer::Config.rails_secret_key_base

    # make booleans be integer
    config.active_record.sqlite3.represent_boolean_as_integer = true

    # Single logger for everything
    logger = ActiveSupport::Logger.new($stdout)

    # Separate logger required to add custom formatter
    require_relative '../lib/custom_logger_formatter'
    logger.formatter = CustomLoggerFormatter.new

    # Change it into tagged logger to add more information based on request
    config.logger = ActiveSupport::TaggedLogging.new(logger)
    config.log_tags = [:request_id, :remote_ip, :host]
    config.log_level = ENV.fetch('LOG_LEVEL', 'debug')

    # map activerecord logger to default rails logger
    config.after_initialize do
      ActiveRecord::Base.logger = Rails.logger
      Rack::Timeout::Logger.logger = Rails.logger if defined?(Rack::Timeout)
    end
  end
end
