module TestServer
  module Reflectors
    class RequestHeader
      include ActiveModel::Validations
      include ActiveModel::Conversion
      extend ActiveModel::Naming

      validates :name, presence: true
      validates :value, presence: true

      def initialize(attributes = {})
        Hash(attributes).each do |name, value|
          send("#{name}=", value)
        end
      end

      attr_accessor :name, :value

      def name=(value)
        @name = value.to_s.gsub('HTTP_', '').split(/_/).map { |n| n.capitalize }.join('-')
      end

      def persisted?
        false
      end
    end
  end
end
