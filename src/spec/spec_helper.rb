# encoding: utf-8
$LOAD_PATH << File.expand_path('../../lib', __FILE__)

require 'test_server'
include TestServer

require 'simplecov'
SimpleCov.command_name 'rspec'
SimpleCov.start 'rails'

# Loading support files
Dir.glob(::File.expand_path('../support/**/*.rb', __FILE__)).each { |f| require_relative f }
