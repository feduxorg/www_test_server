module TestServer
  class FileDownloadPolicy
    attr_reader :user, :record

    def initialize(user, record)
      @user   = user
      @record = record
    end

    def index?
      admin? || user? || guest?
    end

    def show?
      admin? || user? || guest?
    end

    def create?
      admin? || user?
    end

    def new?
      create?
    end

    def update?
      admin? || user?
    end

    def edit?
      update?
    end

    def destroy?
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

    def guest?
      return true if user.blank?

      false
    end
  end
end
