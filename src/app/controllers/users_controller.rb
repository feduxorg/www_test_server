require 'test_server/permitted_params/users_parameter_sanitizer'

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :destroy, :update, :toggle_approve, :toggle_removable]

  add_breadcrumb I18n.t('views.root.link'), :root_path
  add_breadcrumb I18n.t('views.users.link'), :users_path

  before_action :authenticate_user!

  # GET /users
  def index
    authorize User
    @users = User.all_but_anonymous
  end

  # GET /users/1
  def show
    add_breadcrumb @user.email
  end

  # GET /users/new
  def new
    @user = User.new
    authorize @user
  end

  # GET /users/1/edit
  def edit
  end

  def toggle_approve
    fail 'Cannot unapprove last admin user' if @user.role.name == 'admin' && @user.approved? && User.joins(:role).where(roles: { name: 'admin'}).count < 2
    fail 'Cannot modify anonymous' if @user.email == 'anonymous'

    authorize @user
    @user.toggle_approve
    @user.save!

    redirect_to request.referrer
  end

  def toggle_removable
    fail 'Cannot modify anonymous' if @user.email == 'anonymous'

    authorize @user
    @user.toggle_removable
    @user.save!

    redirect_to request.referrer
  end

  # POST /users
  def create
    @user = User.new(user_params)
    authorize @user
    @user.save!

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /users/1
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /users/1
  def destroy
    fail 'Cannot delete last admin user' if @user.role.name == 'admin' && User.joins(:role).where(roles: { name: 'admin'}).count < 2

    null_user = User.where(email: 'anonymous').first
    files = @user.file_downloads.all
    files.each do |f|
      f.user = null_user
      f.save!
    end

    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
    authorize @user
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    parameter_sanitizer.use(
      params
    ).fetch(:user, {})
  end

  def parameter_sanitizer
    TestServer::PermittedParams::UsersParameterSanitizer.new
  end
end
