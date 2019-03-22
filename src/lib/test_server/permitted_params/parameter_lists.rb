module TestServer
  module PermittedParams
    module ParameterLists
      private

      def generatable
        [:count, :timeout, :url]
      end

      def repeatable
        [:repeat]
      end

      def streamable
        [:wait]
      end

      def encodable
        [:base64, :base64_strict, :gzip]
      end

      def countable
        [:count]
      end

      def cachable
        [:expires]
      end

      def changable
        [:authenticity_token, :utf8]
      end

      def uploadable
        [:file, :upload, { test_server_file_upload: [ :uploaded_file, :virus_scan, :filetype_detection, :checksum_calculation ] }, :utf8]
      end

      def downloadable
        [:file, :upload, { test_server_file_download: [ :file, :label ] }]
      end

      def resolvable
        [{ test_server_dns_requests_ip_address: [ :name, :ip_address ] }, { test_server_dns_requests_host_name: [ :name, :ip_address ] }]
      end

      def base
        [:action, :_method]
      end

      def whoisable
        [{ test_server_whois_request: [ :request ] }]
      end

      def showable
        [:id]
      end
    end
  end
end
