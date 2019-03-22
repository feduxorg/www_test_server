# encoding: utf-8
module TestServer
  class FiletypeDetector
    private

    attr_reader :engine

    public

    def initialize(engine: FileMagic.new)
      @engine = engine
    end

    def use(file)
      file.filetype = engine.file(file.path)
    rescue StandardError => err
      Rails.logger.error "#{err.class}: #{err.message}"
      file.filetype = "An error occured while determine file type for \"#{file.name}\"."
    end
  end
end
