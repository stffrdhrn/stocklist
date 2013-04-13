class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  class NotAuthorized < Exception
  end

  rescue_from NotAuthorized, :with => :user_not_authorized
 
  before_filter :check_authorization

  def check_authorization
    if !signed_in?
      raise NotAuthorized
    end
  end

  def user_not_authorized
    render :json => {:status => 'No/Invalid auth tokens'}, :status => :unauthorized
  end
end
