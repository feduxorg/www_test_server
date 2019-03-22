module TestServer
  class WhoisRequest
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    validates :request, presence: true

    def initialize(attributes = {})
      Hash(attributes).each do |name, value|
        send("#{name}=", value)
      end
    end

    attr_accessor :request, :response

    def persisted?
      false
    end
  end
end
