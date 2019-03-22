require 'logger'

class CustomLoggerFormatter < ::Logger::Formatter
  def call(severity, time, progname, msg)
    "[#{severity}] #{msg2str(msg)}\n"
  end
end

