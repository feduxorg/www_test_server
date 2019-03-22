require 'rails_helper'

RSpec.describe "TestServer::Reflectors::ClientIpAddress", type: :request do
  describe "GET /test_server_reflectors_client_ip_addresses" do
    it "works! (now write some real specs)" do
      get test_server_reflectors_client_ip_addresses_path
      expect(response).to have_http_status(200)
    end
  end
end
