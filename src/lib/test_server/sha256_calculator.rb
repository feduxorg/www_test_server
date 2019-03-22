# encoding: utf-8
module TestServer
  class Sha256Calculator < ChecksumCalculator
    private

    attr_reader :engine

    def compute_checksum(file)
      Checksum.new(
        algorithm: :sha256,
        prefix: 'SHA256',
        engine: Digest::SHA256,
        data: File.read(file.path),
      )
    end
  end
end
