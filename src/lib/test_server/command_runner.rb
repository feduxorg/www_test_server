# encoding: utf-8
require 'timeout'
require 'ostruct'

module TestServer
  class CommandRunner

    private

    attr_reader :timeout

    public

    def initialize(timeout:)
      @timeout = timeout
    end

    def run(command)
      # stdout, stderr pipes
      rout, wout = IO.pipe
      rerr, werr = IO.pipe

      result = OpenStruct.new

      begin
        result.pid = Process.spawn(command, :out => wout, :err => werr)
        _, status = Timeout::timeout(timeout) { Process.wait2(result.pid) }

        result.status = status.exitstatus
      rescue Timeout::Error
        Process.kill 'KILL', result.pid
        result.status = 99
      end

      # close write ends so we could read them
      wout.close
      werr.close

      result.stdout = rout.readlines
      result.stderr = rerr.readlines

      # dispose the read ends of the pipes
      rout.close
      rerr.close

      result
    end
  end
end

module TestServer
  module RunCommand
    def run_command(command, timeout: 5)
      runner = CommandRunner.new(timeout: timeout)
      runner.run(command)
    end

    def which(cmd, options = {})
      options = {
        paths:                         ENV['PATH'].split(File::PATH_SEPARATOR),
        pathexts:                      ENV['PATHEXT'].to_s.split(/;/),
        raise_error_on_not_executable: false,
        raise_error_on_not_found:      false
      }.merge options

      cmd = Pathname.new(cmd)

      paths                         = options[:paths]
      pathexts                      = options[:pathexts]
      raise_error_on_not_executable = options[:raise_error_on_not_executable]
      raise_error_on_not_found      = options[:raise_error_on_not_found]

      raise "Command not found" if cmd.to_s.empty?
      return nil if cmd.to_s.empty?

      if cmd.absolute?
        return cmd.to_s if cmd.executable?
        raise "Command not found" if raise_error_on_not_found && !cmd.exist?
        fail "Command not executable" if raise_error_on_not_executable && !cmd.executable?
        return nil
      end

      pathexts = [''] if pathexts.blank?

      Array(paths).each do |path|
        Array(pathexts).each do |ext|
          file = Pathname.new(File.join(path, "#{cmd}#{ext}"))
          return file.to_s if file.executable?
          raise "Command not executable" if raise_error_on_not_executable && !cmd.executable?
        end
      end
      raise "Command not found" if raise_error_on_not_found
      nil
    end
  end
end
