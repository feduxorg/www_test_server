# encoding: utf-8
require 'logger'

module TestServer
  class FileDeleter
    def initialize
      @logger = if defined? Rails
                  Rails.logger
                else
                  Logger.new($stderr)
                end
    end

    def use(file)
      FileUtils.rm(file.path)
    rescue StandardError => err
      @logger.error "#{err.class}: #{err.message}"
    end
  end
end
