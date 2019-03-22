# encoding: utf-8
module TestServer
  class MD5Calculator < ChecksumCalculator
    private

    attr_reader :engine

    def compute_checksum(file)
      Checksum.new(
        algorithm: :md5,
        prefix: 'MD5',
        engine: Digest::MD5,
        data: File.read(file.path),
      )
    end
  end
end
