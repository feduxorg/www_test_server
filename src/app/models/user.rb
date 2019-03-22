class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable, :timeoutable
  # devise :database_authenticatable, :trackable, :timeoutable
  devise :database_authenticatable, :trackable
  belongs_to :role

  has_many :file_downloads, class_name: 'TestServer::FileDownload'

  before_create :set_default_role
  scope :all_but_anonymous, ->{ User.where.not(email: 'anonymous') }

  def role?(r)
    role.name.to_sym == r.to_sym
  end

  def toggle_approve
    if approved?
      self.approved = false
    else
      self.approved = true
    end

  end

  def toggle_removable
    if removable?
      self.removable = false
    else
      self.removable = true
    end
  end

  def removable?
    removable == true
  end

  def approved?
    approved == true
  end

  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    if !approved? 
      :not_approved 
    else
      super # Use whatever other message 
    end
  end

  private

  def set_default_role
    self.role ||= Role.find_by_name('user')
  end
end
