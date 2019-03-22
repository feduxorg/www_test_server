require 'rails_helper'

RSpec.describe "test_server/dns_requests/new", type: :view do
  before(:each) do
    assign(:test_server_dns_request, TestServer::DnsRequest.new())
  end

  it "renders new test_server_dns_request form" do
    render

    assert_select "form[action=?][method=?]", test_server_dns_requests_path, "post" do
    end
  end
end
