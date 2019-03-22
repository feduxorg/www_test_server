# encoding: utf-8
require 'pry'

if RUBY_VERSION < '2.0.0'
  require 'debugger'
else
  require 'byebug'
end
