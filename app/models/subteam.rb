class Subteam < ActiveRecord::Base
  include TeamHelper
  #subteams table

  #id - integer
  #name - string
  #description - string
  #team_id - string
  #segment_id - integer
  #created_at - datetime
  #updated_at - datetime

  belongs_to :team

  #Methods
  def add_user_membership(user)
    Membership.create({:team_id => team.id, :subteam_id => self.id, :user_id => user.id}) if !team.nil?
    Membership.create({:subteam_id => self.id, :user_id => user.id}) if team.nil?
  end
end
