require 'rails_helper'

RSpec.describe "test_server/whois_requests/edit", type: :view do
  before(:each) do
    @test_server_whois_request = assign(:test_server_whois_request, TestServer::WhoisRequest.create!())
  end

  it "renders the edit test_server_whois_request form" do
    render

    assert_select "form[action=?][method=?]", test_server_whois_request_path(@test_server_whois_request), "post" do
    end
  end
end
