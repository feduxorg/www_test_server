module TestServer
  module DnsRequests
    class HostName
      include ActiveModel::Validations
      include ActiveModel::Conversion
      extend ActiveModel::Naming

      validates :name, host_name: true, presence: true

      def initialize(attributes = {})
        Hash(attributes).each do |name, value|
          send("#{name}=", value)
        end
      end

      attr_accessor :name, :ip_addresses

      def persisted?
        false
      end
    end
  end
end
