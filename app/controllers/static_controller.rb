class StaticController < ApplicationController
  skip_before_filter :check_authorization

  def index
  end
end
