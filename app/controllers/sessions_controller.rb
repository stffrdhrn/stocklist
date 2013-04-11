class SessionsController < ApplicationController

  def new
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      sign_in @user
      render :json => @user
    else
      render :json => {:error => 'Login Failed'}, :status => :unauthorized
    end
    
  end
   
  def destroy
    sign_out
    render :json => {:status => 'Logged out'}, :status => :ok
  end

end
