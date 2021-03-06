require "rails_helper"

RSpec.describe TestServer::DnsRequests::HostNameController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/test_server/dns_requests").to route_to("test_server/dns_requests#index")
    end

    it "routes to #new" do
      expect(:get => "/test_server/dns_requests/new").to route_to("test_server/dns_requests#new")
    end

    it "routes to #show" do
      expect(:get => "/test_server/dns_requests/1").to route_to("test_server/dns_requests#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/test_server/dns_requests/1/edit").to route_to("test_server/dns_requests#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/test_server/dns_requests").to route_to("test_server/dns_requests#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/test_server/dns_requests/1").to route_to("test_server/dns_requests#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/test_server/dns_requests/1").to route_to("test_server/dns_requests#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/test_server/dns_requests/1").to route_to("test_server/dns_requests#destroy", :id => "1")
    end

  end
end
