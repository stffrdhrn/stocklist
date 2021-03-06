class UsersController < ApplicationController
  skip_before_filter :check_authorization
  def get
     @user = current_user
     if @user
         render :json => @user.as_json(:except => [:password_digest])
     else
         render :json => {:error => "Not logged in"}, :status => :unauthorized
     end
  end

  def create
    @user = User.init(params[:name], 
                      params[:email], 
                      params[:password], 
                      params[:password_confirmation])
    if !@user.nil?
      sign_in @user
      render :json => @user
    else 
      render :json => {:error => "failed to create user", 
                       :reasons => @user.errors.full_messages}, 
                       :status => :bad_request
    end
  end
end
