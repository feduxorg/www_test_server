class HostNameValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.to_s =~ /(?:[[:alnum:]_-]+\.)*(?:[[:alnum:]_-]+)/

    record.errors.add(attribute, :invaid)
  end
end
