require 'rails_helper'

RSpec.describe "TestServer::Reflectors::RequestHeaders", type: :request do
  describe "GET /test_server_reflectors_request_headers" do
    it "works! (now write some real specs)" do
      get test_server_reflectors_request_headers_path
      expect(response).to have_http_status(200)
    end
  end
end
