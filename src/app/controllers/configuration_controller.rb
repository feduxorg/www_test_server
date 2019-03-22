class ConfigurationController < ApplicationController
  add_breadcrumb I18n.t('views.root.link'), :root_path
  add_breadcrumb I18n.t('views.configuration.link'), :configuration_index_path

  before_action :authenticate_user!

  def index
    authorize :configuration
  end
end
