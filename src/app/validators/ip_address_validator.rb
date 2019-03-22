require 'ipaddr'

class IpAddressValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    begin
      ip = IPAddress.parse(value.to_s)
      return if ip.ipv4? || ip.ipv6?

      record.errors.add(attribute, :invaid)
    rescue Addressable::URI::InvalidURIError
      record.errors.add(attribute, :invalid)
    end
  end
end
