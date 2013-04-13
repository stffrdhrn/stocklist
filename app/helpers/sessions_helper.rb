module SessionsHelper
  def sign_in(user)
    session[:id] = user.id
    current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    session.delete(:id)
    @current_user = nil 
  end

  def current_user=(user)
    @current_user = user
  end
 
  def current_user
    if !session[:id].nil?
      @current_user ||= User.find(session[:id])
    end
  end

end
