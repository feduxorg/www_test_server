require 'rails_helper'

RSpec.describe "test_server/reflectors/show", type: :view do
  before(:each) do
    @test_server_reflector = assign(:test_server_reflector, TestServer::Reflectors::RequestHeader.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
