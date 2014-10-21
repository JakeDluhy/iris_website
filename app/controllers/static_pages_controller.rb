class StaticPagesController < ApplicationController
  before_action :admin_user, only: :backend
	
  def home
    members_of_the_week = User.where('member_of_the_week IS TRUE').order('created_at DESC')
    members_of_the_week[0].nil? ? @first_member = User.all.first : @first_member = members_of_the_week[0]
    @weekly_award = @first_member.weekly_awards.last
  end

  def about
    @teams = Team.all
  end

  def contact
    @ateam = User.where(role_type: "ateam").order('name ASC')
    @exec = User.where(role_type: "exec").order('name ASC')
  end

  def backend

  end
end
