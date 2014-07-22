class StaticPagesController < ApplicationController
	
  def home
  end

  def about
    @teams = Team.all
  end

  def backend

  end
end
