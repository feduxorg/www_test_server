class GeneratorPolicy < Struct.new(:user, :generator)
  def index?
    admin? || user?
  end

  private

  def admin?
    return false if user.blank?

    user.role? :admin
  end

  def user?
    return false if user.blank?

    user.role?(:user)
  end
end
