require 'rails_helper'

RSpec.describe "test_server/reflectors/index", type: :view do
  before(:each) do
    assign(:test_server_reflectors, [
      TestServer::Reflector.create!(),
      TestServer::Reflector.create!()
    ])
  end

  it "renders a list of test_server/reflectors" do
    render
  end
end
