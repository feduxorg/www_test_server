require 'rails_helper'

RSpec.describe "TestServer::WhoisRequests", type: :request do
  describe "GET /test_server_whois_requests" do
    it "works! (now write some real specs)" do
      get test_server_whois_requests_path
      expect(response).to have_http_status(200)
    end
  end
end
