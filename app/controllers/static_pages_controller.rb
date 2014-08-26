class StaticPagesController < ApplicationController
  before_action :admin_user, only: :backend
	
  def home
  end

  def about
    @teams = Team.all
  end

  def backend

  end
end
