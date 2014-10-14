class StaticPagesController < ApplicationController
  before_action :admin_user, only: :backend
	
  def home
    members_of_the_week = User.where('member_of_the_week IS TRUE').order('created_at DESC')
    members_of_the_week[0].nil? ? @first_member = User.find(1) : @first_member = members_of_the_week[0]
    members_of_the_week[1].nil? ? @second_member = User.find(2) : @second_member = members_of_the_week[1]
  end

  def about
    @teams = Team.all
  end

  def contact
    @leaders = User.where('admin IS TRUE')
  end

  def backend

  end
end
