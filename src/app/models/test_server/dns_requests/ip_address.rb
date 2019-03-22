module TestServer
  module DnsRequests
    class IpAddress
      include ActiveModel::Validations
      include ActiveModel::Conversion
      extend ActiveModel::Naming

      validates :ip_address, ip_address: true, presence:true

      def initialize(attributes = {})
        Hash(attributes).each do |name, value|
          send("#{name}=", value)
        end
      end

      attr_accessor :names, :ip_address

      def persisted?
        false
      end
    end
  end
end
