# encoding: utf-8
module TestServer
  class FileUpload
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    attr_reader :virus_scan, :checksum_calculation, :filetype_detection

    def initialize(attributes = {})
      Hash(attributes).each do |name, value|
        send("#{name}=", value)
      end
    end

    [:virus_scan, :checksum_calculation, :filetype_detection ].each do |m|
      define_method :"#{m}=" do |value|
        instance_variable_set :"@#{m}", case value
        when /1|y|on/
          true
        when /0|n|off/
          false
        else
          false
        end
      end
    end

    def uploaded_file=(file)
      @uploaded_file = UploadedFile.new(file)
    end

    def uploaded_file
      @uploaded_file || UploadedFile.new(nil)
    end

    def persisted?
      false
    end
  end
end
