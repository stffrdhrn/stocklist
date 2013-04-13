class UsersController < ApplicationController
  skip_before_filter :check_authorization
  def get
     @user = current_user
     if @user
         render :json => @user
     else
         render :json => {:error => "Not logged in"}, :status => :unauthorized
     end
  end

  def create
    @user = User.new()
    if @user.save
      sign_in @user
      render :json => @user
    else 
      render :json => {:error => "failed to create user", 
                       :reasons => @user.errors.full_messages}, 
                       :status => :bad_request
    end
  end
end
