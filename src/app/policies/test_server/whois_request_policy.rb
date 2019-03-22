module TestServer
  class WhoisRequestPolicy
    attr_reader :user, :record

    def initialize(user, record)
      @user   = user
      @record = record
    end

    def create?
      admin? || user?
    end

    def new?
      create?
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
end
