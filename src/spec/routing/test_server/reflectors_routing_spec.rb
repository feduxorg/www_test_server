require "rails_helper"

RSpec.describe TestServer::ReflectorsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/test_server/reflectors").to route_to("test_server/reflectors#index")
    end

    it "routes to #new" do
      expect(:get => "/test_server/reflectors/new").to route_to("test_server/reflectors#new")
    end

    it "routes to #show" do
      expect(:get => "/test_server/reflectors/1").to route_to("test_server/reflectors#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/test_server/reflectors/1/edit").to route_to("test_server/reflectors#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/test_server/reflectors").to route_to("test_server/reflectors#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/test_server/reflectors/1").to route_to("test_server/reflectors#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/test_server/reflectors/1").to route_to("test_server/reflectors#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/test_server/reflectors/1").to route_to("test_server/reflectors#destroy", :id => "1")
    end

  end
end
