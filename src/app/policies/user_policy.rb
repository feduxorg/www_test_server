class UserPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user   = user
    @record = record
  end

  def index?
    admin?
  end

  def show?
    admin?
  end

  def create?
    admin?
  end

  def new?
    create?
  end

  def update?
    admin?
  end

  def edit?
    update?
  end

  def destroy?
    admin?
  end

  def toggle_approve?
    admin?
  end

  def toggle_removable?
    admin?
  end

  private

  def admin?
    return false if user.blank?

    user.role? :admin
  end
end
