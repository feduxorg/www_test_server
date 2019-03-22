# encoding: utf-8
module TestServer
  class Checksum
    attr_reader :algorithm, :prefix, :data, :engine

    def initialize(algorithm: nil, prefix: nil, data: nil, engine: nil)
      @algorithm = algorithm
      @prefix    = prefix
      @engine    = engine
      @data      = data
    end

    def value
      engine.hexdigest data.to_s
    end

    def to_s
      "#{prefix} #{value}"
    end
  end
end
