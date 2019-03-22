# encoding: utf-8
module TestServer
  class UploadedFile
    private

    attr_reader :uploaded_file

    public

    attr_accessor :filetype, :virus_id, :checksum

    def initialize(uploaded_file)
      if uploaded_file.respond_to? :tempfile
        @uploaded_file = uploaded_file
      else
        @uploaded_file = OpenStruct.new
      end

      @checksum = []
    end

    def checksum=(sum)
      @checksum << sum
    end

    def path
      uploaded_file.path.to_s
    end

    def name
      File.basename(uploaded_file.original_filename.to_s)
    end

    def blank?
      raw_size == 0
    end

    def has_filetype?
      !filetype.blank?
    end

    def contains_virus?
      !virus_id.blank?
    end

    def has_checksum?
      !checksum.blank?
    end

    def raw_size
      uploaded_file.size || 0
    end

    def size
      formula = lambda { |number| raw_size.to_f  / (2**number) }

      result = {}
      result[:b] = FileSize.new(suffix: 'B', value: raw_size.to_s)
      result[:kib] = FileSize.new(suffix: 'KiB', value: '%.2f' % formula.call(10))
      result[:mib] = FileSize.new(suffix: 'MiB', value: '%.2f' % formula.call(20))
      result[:gib] = FileSize.new(suffix: 'GiB', value: '%.2f' % formula.call(30))

      result
    end
  end
end
