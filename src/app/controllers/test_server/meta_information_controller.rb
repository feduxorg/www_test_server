class TestServer::MetaInformationController < ApplicationController
  def index
    authorize :meta_information, :index?
  end
end
