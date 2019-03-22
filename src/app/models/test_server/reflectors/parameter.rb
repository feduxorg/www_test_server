module TestServer
  module Reflectors
    class Parameter
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

      def name=(n)
        @name = n
      end

      def value=(v)
        v = '<no value>' if v.blank?
        @value = v
      end

      def persisted?
        false
      end
    end
  end
end
