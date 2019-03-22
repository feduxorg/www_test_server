require 'delegate'

module TestServer
  class ServerError < SimpleDelegator
    def name
      class_name.underscore
    end

    def class_name
      __getobj__.class.name
    end
  end
end
