# encoding: utf-8
require 'logger'

module TestServer
  class FilePermissionsRelaxer
    def initialize
      @logger = if defined? Rails
                  Rails.logger
                else
                  Logger.new($stderr)
                end
    end

    def use(file)
      FileUtils.chmod 0666, file.path
    rescue StandardError => err
      @logger.error "#{err.class}: #{err.message}"
    end
  end
end
