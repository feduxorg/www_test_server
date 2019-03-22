require 'rails_helper'

RSpec.describe "test_server/whois_requests/new", type: :view do
  before(:each) do
    assign(:test_server_whois_request, TestServer::WhoisRequest.new())
  end

  it "renders new test_server_whois_request form" do
    render

    assert_select "form[action=?][method=?]", test_server_whois_requests_path, "post" do
    end
  end
end
