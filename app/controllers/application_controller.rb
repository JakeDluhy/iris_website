class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :members_week


  def members_week
    @members_of_the_week =  User.where("member_of_the_week IS true");
  end

  
end
