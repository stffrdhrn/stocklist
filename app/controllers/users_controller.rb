class UsersController < ApplicationController

  def get
     @user = current_user
     if @user
         render :json => @user
     else
         render :json => {:error => "Not logged in"}, :status => :forbidden
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
