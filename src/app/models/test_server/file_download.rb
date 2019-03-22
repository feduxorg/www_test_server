# encoding: utf-8
module TestServer
  class FileDownload < ActiveRecord::Base
    validates :file, presence: true
    validates :label, presence: true, uniqueness: true

    attachment :file

    belongs_to :user

    def path
      file.to_io.path
    end

    def name
      file_filename
    end

    def mime_type
      file_content_type || 'application/octet-stream'
    end

    def size
      formula = lambda { |number| file.size.to_f  / (2**number) }

      result = {}
      result[:b] = FileSize.new(suffix: 'B', value: file.size.to_s)
      result[:kib] = FileSize.new(suffix: 'KiB', value: '%.2f' % formula.call(10))
      result[:mib] = FileSize.new(suffix: 'MiB', value: '%.2f' % formula.call(20))
      result[:gib] = FileSize.new(suffix: 'GiB', value: '%.2f' % formula.call(30))

      result.values.map(&:to_s).join(', ')
    end
  end
end
