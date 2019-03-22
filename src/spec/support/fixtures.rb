# encoding: utf-8

module TestServer
  module SpecHelper
    module Fixtures
      def fixture_file(name)
        File.new(File.expand_path("../../fixtures/#{name}", __FILE__))
      end
    end
  end
end

RSpec.configure do |c|
  c.include TestServer::SpecHelper::Fixtures
end

