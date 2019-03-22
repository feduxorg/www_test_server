class ConfigurationPolicy < Struct.new(:user, :configuration)
  def index?
    admin?
  end

  private

  def admin?
    return false if user.blank?

    user.role? :admin
  end
end
