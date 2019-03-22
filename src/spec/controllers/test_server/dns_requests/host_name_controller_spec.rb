require 'rails_helper'

RSpec.describe TestServer::DnsRequests::HostNameController, type: :controller do
  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end
end
