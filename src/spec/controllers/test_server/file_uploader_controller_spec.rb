require 'rails_helper'

describe TestServer::FileUploaderController do

  describe "GET 'show'" do
    it "returns http success" do
      post 'result'
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET 'upload'" do
    it "returns http success" do
      get 'upload'
      expect(response).to have_http_status(:success)
    end
  end
end
