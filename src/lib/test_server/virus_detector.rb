# encoding: utf-8
module TestServer
  class VirusDetector

    private

    attr_reader :command, :timeout

    public

    def initialize(command: which('clamdscan'))
      @command = command
      @timeout = 60
    end

    def use(file)
      file.virus_id = scan(file)
    end

    private

    include TestServer::RunCommand

    def scan(file)
      return "Scan commands \"clamdscan\" and \"clamscan\" not found. File \"#{file.name}\" could not be scanned." if command.blank?

      result = run_command("#{command} #{file.path}", timeout: timeout)

      return "Timeout \"#{timeout}\" reached before finishing scan." if result.status == 99
      return "Scan failed due to error: #{extract_error(result.stdout)}" if result.stdout.first.to_s['ERROR']
      return "Scan failed due to error: #{extract_error(result.stderr)}" if result.stderr.first.to_s['ERROR']

      # man clamdscan => exit status == 1 => virus found
      return extract_virus_id(result.stdout) if result.status == 1

      "No virus found"
    end

    def extract_error(data)
      data.first.to_s.chomp.split(/:/).last
    end

    def extract_virus_id(data)
      data.first.scan(/^[^:]+:\s([[:alnum:]._-]+)/).flatten.first
    end
  end
end
