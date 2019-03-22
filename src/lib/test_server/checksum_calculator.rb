# encoding: utf-8
module TestServer
  class ChecksumCalculator
    private

    attr_reader :engine

    public

    def use(file)
      file.checksum = compute_checksum(file)
    rescue StandardError => err
      Rails.logger.error "#{err.class}: #{err.message}"

      checksum = OpenStruct.new
      checksum.value = "An error occured while determine checksum for \"#{file.name}\"."

      file.checksum = checksum
    end

    private

    def compute_checksum(file)
      raise MethodNotImplemented, JSON.dump(method: :compute_checksum)
    end
  end
end
