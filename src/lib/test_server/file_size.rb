# encoding: utf-8

class FileSize
  attr_accessor :value, :suffix

  def initialize(value:, suffix:)
    @value = value
    @suffix = suffix
  end

  def to_s
    "#{value} #{suffix}"
  end
end
