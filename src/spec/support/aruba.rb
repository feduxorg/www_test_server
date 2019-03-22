# encoding: utf-8
require 'aruba/api'

module TestServer
  module SpecHelper
    module Aruba
      include ::Aruba::Api
    end
  end
end

RSpec.configure do |c|
  c.include TestServer::SpecHelper::Aruba
end

