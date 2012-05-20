class UsersController < ApplicationController
  # This controller can only be accessed by admins
  before_filter :require_admin
  
  # GET /users
  # GET /users.json
  def index
    # Just display all users
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end
  
  # GET /users/1
  # GET /users/1.json
  def show
    # Display the given user
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    # Find the given user for editing
    @user = User.find(params[:id])
  end
  
  # PUT /users/1
  # PUT /users/1.json
  def update
    # Save the user's changed data
    
    # Remove empty password fields so the don't get validated causing an error
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    @user = User.find(params[:id])
    
    # Is admin cannot be mass assigned - otherwise users could make themselves admins.
    # Thus it must be set explicitly.
    @user.is_admin = params[:user][:is_admin]
    params[:user].delete(:is_admin)
    
    # Try to save
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to users_url, notice: t('users.saved') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    # Delete the given user
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: t('users.destroyed') }
      format.json { head :no_content }
    end
  end
end
